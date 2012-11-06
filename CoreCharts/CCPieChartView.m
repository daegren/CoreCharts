//
//  CCPieChartView.m
//  CoreCharts
//
//  Created by David Mills on 2012-11-05.
//  Copyright (c) 2012 1morepx. All rights reserved.
//

#import "CCPieChartView.h"
#import "CCDataPoint.h"

@implementation CCPieChartView

@synthesize dataPoints = _dataPoints;

-(void)setDataPoints:(NSArray *)dataPoints {
    _dataPoints = dataPoints;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)drawRect:(CGRect)rect {
    // Drawing code
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGFloat radius = self.radius;
    CGFloat padding = radius / 2;
    
    // calculate where each segment starts
    // SOH CAH TOA
    
    CCDataPoint *c = [self.dataPoints objectAtIndex:0];
    CGFloat angle = [self getRadians:-90];
    CGFloat newAngle = [self getAngleInRadiansFromPercentage:c.value] + angle;
    
    //NSLog(@"percentage: %f", [c.percentage floatValue] * 100);
    //NSLog(@"Start: %f, End: %f", angle, newAngle);
    
    [self drawPieSegmentInContext:context withPadding:padding startingAngle:angle andEndAngle:newAngle colorWith:c.color];
    
    for (int i = 1; i < self.dataPoints.count; i++) {
        c = [self.dataPoints objectAtIndex:i];
        angle = newAngle + [self getRadians:1];
        newAngle = [self getAngleInRadiansFromPercentage:c.value] + angle;
        if (i + 1 == self.dataPoints.count) {
            // last item set end to top of chart
            newAngle = [self getRadians:270];
        }
        
        //NSLog(@"percentage: %f", [c.percentage floatValue] * 100);
        //NSLog(@"Start: %f, End: %f", angle, newAngle);
        
        [self drawPieSegmentInContext:context withPadding:padding startingAngle:angle andEndAngle:newAngle colorWith:c.color];
    }
    
    [[UIColor whiteColor] set];
    CGContextAddArc(context, self.drawingCenter.x, self.drawingCenter.y, self.radius, 0, 2 * M_PI, 1);
    CGContextSetShadow(context, CGSizeMake(0, 0), 2);
    CGContextDrawPath(context, kCGPathStroke);
    
    CGContextAddArc(context, self.drawingCenter.x, self.drawingCenter.y, self.radius - padding, 0, 2 * M_PI, 1);
    CGContextSetShadow(context, CGSizeMake(0, 0), 2);
    CGContextDrawPath(context, kCGPathStroke);
}

- (void)drawPieSegmentInContext:(CGContextRef)ctxt
                    withPadding:(CGFloat)padding
                  startingAngle:(CGFloat)startAngle
                    andEndAngle:(CGFloat)endAngle
                      colorWith:(UIColor *)color {
    CGPoint center = self.drawingCenter;
    CGFloat radius = self.radius;
    
    CGContextBeginPath(ctxt);
    
    
    CGPoint startPoint = CGPointMake(cosf(startAngle) * radius + center.x, sinf(startAngle) * radius + center.y);
    CGContextMoveToPoint(ctxt, startPoint.x, startPoint.y);
    CGContextAddArc(ctxt, center.x, center.y, radius, startAngle, endAngle, 0);
    CGContextAddArc(ctxt, center.x, center.y, radius - padding, endAngle, startAngle, 1);
    
    [color setFill];
    [[UIColor whiteColor] setStroke];
    CGContextSetLineWidth(ctxt, 2.0f);
    CGContextSetShouldAntialias(ctxt, YES);
    CGContextDrawPath(ctxt, kCGPathEOFillStroke);
}

- (CGPoint)drawingCenter {
    return CGPointMake(self.bounds.size.width/2+self.bounds.origin.x, self.bounds.size.height/2+self.bounds.origin.y);
}

- (CGFloat)radius {
    return MIN(self.bounds.size.width, self.bounds.size.height) / 2 - 5;
}

- (CGFloat)getAngleInRadiansFromPercentage:(NSNumber *)percentage {
    CGFloat percentf = [percentage floatValue] * 100;
    return 2 * M_PI * (percentf / 100);
}

- (CGFloat)getRadians:(CGFloat)angle {
    return (angle * M_PI / 180);
}

@end
