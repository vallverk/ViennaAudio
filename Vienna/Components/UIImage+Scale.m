//
//  UIImage+Scale.m
//  Vienna
//
//  Created by Denis Kuznetsov on 26.10.15.
//
//

#import "UIImage+Scale.h"

@implementation UIImage (Scale)

+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContextWithOptions(newSize, 1.0f, 0.0f);
    [image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();

    return newImage;
}

+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)newSize {

    float width = newSize.width;
    float height = newSize.height;

    UIGraphicsBeginImageContextWithOptions(newSize, 1.0f, 0.0f);
    CGRect rect = CGRectMake(0, 0, width, height);

    float widthRatio = image.size.width / width;
    float heightRatio = image.size.height / height;
    float divisor = widthRatio > heightRatio ? widthRatio : heightRatio;

    width = image.size.width / divisor;
    height = image.size.height / divisor;

    rect.size.width  = width;
    rect.size.height = height;

    //indent in case of width or height difference
    float offset = (width - height) / 2;
    if (offset > 0) {
        rect.origin.y = offset;
    }
    else {
        rect.origin.x = -offset;
    }

    [image drawInRect: rect];

    UIImage *smallImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return smallImage;
    
}

+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width
{
    float oldWidth = sourceImage.size.width;
    float scaleFactor = i_width / oldWidth;

    float newHeight = sourceImage.size.height * scaleFactor;
    float newWidth = oldWidth * scaleFactor;

    UIGraphicsBeginImageContextWithOptions(CGSizeMake(newWidth, newHeight), 1.0f, 0.0f);
    [sourceImage drawInRect:CGRectMake(0, 0, newWidth, newHeight)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}

@end
