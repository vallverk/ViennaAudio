//
//  MapAnnotation.h
//  TravelMe
//
//  Created by Viktor Bondarev on 06.04.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MapAnnotation : NSObject <MKAnnotation>

    @property (nonatomic, assign) CLLocationCoordinate2D coordinate;
    @property (nonatomic, copy) NSString *title;
    @property (nonatomic, copy) NSString *subtitle;
    @property (nonatomic, copy) NSString *isBuy;
    @property (nonatomic, copy) NSString *idPin;
    @property (nonatomic, copy) NSString *nameColorPin;
    @property (nonatomic, copy) NSString *nameColorBigPin;
    @property (nonatomic, copy) NSString *nameCategory;
@end
