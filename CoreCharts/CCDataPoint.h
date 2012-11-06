//
//  CCDataPoint.h
//  CoreCharts
//
//  Created by David Mills on 2012-11-05.
//  Copyright (c) 2012 1morepx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CCDataPoint : NSObject

@property (strong, nonatomic) NSNumber *value;
@property (strong, nonatomic) NSString *title;
@property (strong, nonatomic) UIColor *color;

@end
