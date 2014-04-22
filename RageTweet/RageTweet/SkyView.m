//
//  SkyView.m
//  RageTweet
//
//  Created by Brian Douglas Moakley on 2/22/13.
//  Copyright (c) 2013 Razeware. All rights reserved.
//

#import "SkyView.h"

#define HAPPY 0
#define SOMEWHAT_HAPPY 1
#define NEUTRAL 2
#define TICKED_OFF 3
#define RAGING 4

@implementation SkyView

-(void) setRageLevel:(NSInteger)rageLevel
{
    _rageLevel = rageLevel;
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
     CGContextRef context = UIGraphicsGetCurrentContext();
     CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
     
     //draw sky
     [self drawSkyInRect:rect inContext:context withColorSpace:colorSpace];
     
     //draw mountains
     [self drawMountainsinRect:rect inContext:context withColorSpace:colorSpace];
     //draw grass
     //draw flowers
     
     CGColorSpaceRelease(colorSpace);
 }

- (void)drawSkyInRect:(CGRect)rect inContext:(CGContextRef)context withColorSpace:(CGColorSpaceRef)colorSpace
{
    UIColor *baseColor = [UIColor colorWithRed:148.0/255.0 green:158.0/255.0 blue:183.0/255.0 alpha:1.0];
    UIColor *middleStop = [UIColor colorWithRed:127.0/255.0 green:138.0/255.0 blue:166.0/255.0 alpha:1.0];
    UIColor *farStop = [UIColor colorWithRed:96.0/255.0 green:111.0/255.0 blue:144.0/255.0 alpha:1.0];
    
    CGContextSaveGState(context);
    
    CGFloat locations[] = {0.0,0.1,0.25};
    
    NSArray *colors = @[(__bridge id)baseColor.CGColor, (__bridge id)middleStop.CGColor, (__bridge id)farStop.CGColor];
    
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    
    CGPoint startPoint = CGPointMake(rect.size.height * 0.5, 0);
    CGPoint endPoint = CGPointMake(rect.size.height * 0.5, rect.size.width);
    
    CGContextDrawLinearGradient(context,
                                gradient,
                                startPoint,
                                endPoint,
                                0);
    
    CGGradientRelease(gradient);
    CGContextRestoreGState(context);
}
- (void)drawMountainsinRect:(CGRect)rect inContext :(CGContextRef)context withColorSpace:(CGColorSpaceRef)colorSpace
{
    UIColor *darkColor = [UIColor colorWithRed:1.0/255.0 green:93.0/255.0 blue:67.0/255.0 alpha:1.0];
    UIColor *lightColor = [UIColor colorWithRed:63.0/255.0 green:109.0/255.0 blue:79.0/255.0 alpha:1.0];
    
    NSArray *mountainColors = @[(__bridge id)darkColor.CGColor, (__bridge id)lightColor.CGColor];
    CGFloat mountainLocations[] = {0.1, 0.2};
    CGGradientRef backgroundGradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)mountainColors, mountainLocations);
    
    CGPoint mountainStart = CGPointMake(rect.size.height * 0.5, 100);
    CGPoint mountainEnd = CGPointMake(rect.size.height * 0.5, rect.size.width);
    
    CGContextSaveGState(context);
    
    //background mountain
    CGMutablePathRef backgroundMountains = CGPathCreateMutable();
    CGPathMoveToPoint(backgroundMountains, nil, -5, 157);
    CGPathAddQuadCurveToPoint(backgroundMountains, nil, 30, 129, 77, 157);
    CGPathAddCurveToPoint(backgroundMountains, nil, 190, 210, 200, 70, 303, 125);
    CGPathAddQuadCurveToPoint(backgroundMountains, nil, 340, 150, 350, 150);
    CGPathAddQuadCurveToPoint(backgroundMountains, nil, 380, 155, 410, 145);
    CGPathAddCurveToPoint(backgroundMountains, nil, 500, 100, 540, 190, 580, 165);
    CGPathAddLineToPoint(backgroundMountains, nil, 580, rect.size.width);
    CGPathAddLineToPoint(backgroundMountains, nil, -5, rect.size.width);
    CGPathCloseSubpath(backgroundMountains);
    
    CGContextAddPath(context, backgroundMountains);
    CGContextClip(context);
    CGContextDrawLinearGradient(context, backgroundGradient, mountainStart, mountainEnd, 0);
    
    CGContextSetLineWidth(context, 4);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextAddPath(context, backgroundMountains);
    CGContextStrokePath(context);
    
    //foreground mountains
    CGMutablePathRef foregroundMountains = CGPathCreateMutable();
    CGPathMoveToPoint(foregroundMountains, nil, -5, 190);
    CGPathAddCurveToPoint(foregroundMountains, nil, 160, 250, 200, 140, 303, 190);
    CGPathAddCurveToPoint(foregroundMountains, nil, 430, 250, 550, 170, 590, 210);
    CGPathAddLineToPoint(foregroundMountains, nil, 590, 230);
    CGPathAddCurveToPoint(foregroundMountains, nil, 300, 260, 140, 215, 0, 225);
    CGPathCloseSubpath(foregroundMountains);
    
    //foreground mountain drawing
    CGContextAddPath(context, foregroundMountains);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, darkColor.CGColor);
    CGContextFillRect(context, CGRectMake(0, 170, 590, 90));
    
    //foreground mountain stroking
    CGContextAddPath(context, foregroundMountains);
    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
    CGContextStrokePath(context);
    
    
//    //add points
//    CGFloat width = 4;
//    CGContextAddRect(context, CGRectMake(-5, 157, width, width));
//    CGContextAddRect(context, CGRectMake(77, 157, width, width));
//    CGContextAddRect(context, CGRectMake(303, 125, width, width));
//    CGContextAddRect(context, CGRectMake(350, 150, width, width));
//    CGContextAddRect(context, CGRectMake(410, 145, width, width));
//    
//    //add control points
//    CGContextAddRect(context, CGRectMake(30, 129, width, width));
//    CGContextAddRect(context, CGRectMake(190, 210, width, width));
//    CGContextAddRect(context, CGRectMake(200, 70, width, width));
//    CGContextAddRect(context, CGRectMake(340, 150, width, width));
//    CGContextAddRect(context, CGRectMake(380, 155, width, width));
//    CGContextAddRect(context, CGRectMake(500, 100, width, width));
//    CGContextAddRect(context, CGRectMake(540, 190, width, width));
//    
//    CGContextClip(context);
//    
//    CGContextSetFillColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextFillRect(context, rect);
    //add control points
    //add quad control points
    
    //release path
    CGPathRelease(foregroundMountains);
    CGPathRelease(backgroundMountains);
    
    CGContextRestoreGState(context);
    CGGradientRelease(backgroundGradient);
}

@end
l;