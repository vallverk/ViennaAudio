//
//  UIImage+Scale.h
//  Vienna
//
//  Created by Denis Kuznetsov on 26.10.15.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Scale)
+ (UIImage*)imageWithImage:(UIImage*)image
              scaledToSize:(CGSize)newSize;
+ (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)targetSize;
+(UIImage*)imageWithImage: (UIImage*) sourceImage scaledToWidth: (float) i_width;
@end
