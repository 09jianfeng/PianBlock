//
//  GameBLBGFactory.m
//  PianoBlock
//
//  Created by 陈建峰 on 16/9/5.
//  Copyright © 2016年 陈建峰. All rights reserved.
//

#import "GameBLBGFactory.h"

@implementation GameBLBGFactory{
    NSCache *_imageFlyweightPool;
}

- (instancetype)init{
    self = [super init];
    if (self) {
        _imageFlyweightPool = [[NSCache alloc] init];
        _imageFlyweightPool.countLimit = 10;
    }
    return self;
}

- (UIImage *)blockBackgroundWithType:(BLBackgroundType)type{
    NSString *imageName = @"";
    switch (type) {
        case 0:
            imageName = @"white_block";
            break;
        case 1:
            imageName = @"black_block";
            break;
            
        default:
            break;
    }
    
    UIImage *image = [_imageFlyweightPool objectForKey:imageName];
    if (image) {
        return image;
    }
    
    image = [self imageWithName:imageName];
    [_imageFlyweightPool setObject:image forKey:imageName];
    
    return image;
}

- (UIImage *)imageWithName:(NSString *)imageName{
    UIImage *image = [UIImage imageNamed:imageName];
    
    return [self decodedImageWithImage:image];
}

- (UIImage *)decodedImageWithImage:(UIImage *)image {
    // while downloading huge amount of images
    // autorelease the bitmap context
    // and all vars to help system to free memory
    // when there are memory warning.
    // on iOS7, do not forget to call
    // [[SDImageCache sharedImageCache] clearMemory];
    
    if (image == nil) { // Prevent "CGBitmapContextCreateImage: invalid context 0x0" error
        return nil;
    }
    
    @autoreleasepool{
        // do not decode animated images
        if (image.images != nil) {
            return image;
        }
        
        CGImageRef imageRef = image.CGImage;
        
        CGImageAlphaInfo alpha = CGImageGetAlphaInfo(imageRef);
        BOOL anyAlpha = (alpha == kCGImageAlphaFirst ||
                         alpha == kCGImageAlphaLast ||
                         alpha == kCGImageAlphaPremultipliedFirst ||
                         alpha == kCGImageAlphaPremultipliedLast);
        if (anyAlpha) {
            return image;
        }
        
        // current
        CGColorSpaceModel imageColorSpaceModel = CGColorSpaceGetModel(CGImageGetColorSpace(imageRef));
        CGColorSpaceRef colorspaceRef = CGImageGetColorSpace(imageRef);
        
        BOOL unsupportedColorSpace = (imageColorSpaceModel == kCGColorSpaceModelUnknown ||
                                      imageColorSpaceModel == kCGColorSpaceModelMonochrome ||
                                      imageColorSpaceModel == kCGColorSpaceModelCMYK ||
                                      imageColorSpaceModel == kCGColorSpaceModelIndexed);
        if (unsupportedColorSpace) {
            colorspaceRef = CGColorSpaceCreateDeviceRGB();
        }
        
        size_t width = CGImageGetWidth(imageRef);
        size_t height = CGImageGetHeight(imageRef);
        NSUInteger bytesPerPixel = 4;
        NSUInteger bytesPerRow = bytesPerPixel * width;
        NSUInteger bitsPerComponent = 8;
        
        
        // kCGImageAlphaNone is not supported in CGBitmapContextCreate.
        // Since the original image here has no alpha info, use kCGImageAlphaNoneSkipLast
        // to create bitmap graphics contexts without alpha info.
        CGContextRef context = CGBitmapContextCreate(NULL,
                                                     width,
                                                     height,
                                                     bitsPerComponent,
                                                     bytesPerRow,
                                                     colorspaceRef,
                                                     kCGBitmapByteOrderDefault|kCGImageAlphaNoneSkipLast);
        
        // Draw the image into the context and retrieve the new bitmap image without alpha
        CGContextDrawImage(context, CGRectMake(0, 0, width, height), imageRef);
        CGImageRef imageRefWithoutAlpha = CGBitmapContextCreateImage(context);
        UIImage *imageWithoutAlpha = [UIImage imageWithCGImage:imageRefWithoutAlpha
                                                         scale:image.scale
                                                   orientation:image.imageOrientation];
        
        if (unsupportedColorSpace) {
            CGColorSpaceRelease(colorspaceRef);
        }
        
        CGContextRelease(context);
        CGImageRelease(imageRefWithoutAlpha);
        
        return imageWithoutAlpha;
    }
    
}

@end
