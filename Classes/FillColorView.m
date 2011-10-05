//
//  FillColorView.m
//  TenderTouch
//
//  Created by Astron Infotech on 03/05/2010.
//  Copyright Astron Infotech 2011. All rights reserved.

#import "FillColorView.h"

@interface UITouch (TouchSorting)
- (NSComparisonResult)compareAddress:(id)obj;
@end

@implementation UITouch (TouchSorting)
- (NSComparisonResult)compareAddress:(id) obj 
{
    if ((void *) self < (void *) obj) return NSOrderedAscending;
    else if ((void *) self == (void *) obj) return NSOrderedSame;
	else return NSOrderedDescending;
}
@end

@implementation FillColorView
@synthesize red;
@synthesize green;
@synthesize blue;
@synthesize alpha;
@synthesize thickness;
@synthesize imgBlack;
@synthesize imgTransparent;

- (id) initWithImage: (UIImage *) anImage
{
	if (self = [super initWithImage:anImage])
	{
    }
    return self;
}

#pragma mark -
#pragma mark Touch View Methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	mouseSwiped = NO;
	UITouch *touch = [touches anyObject];
	
	lastPoint = [touch locationInView:self];
	
	//If mask is not available
	if(!mask)
	{
		CGImageRef maskImage = imgBlack.CGImage;
		
		///Create mask using image with black and white component
		mask = CGImageMaskCreate(CGImageGetWidth(maskImage)
								 , CGImageGetHeight(maskImage)
								 , CGImageGetBitsPerComponent(maskImage)
								 , CGImageGetBitsPerPixel(maskImage)
								 , CGImageGetBytesPerRow(maskImage)
								 ,  CGImageGetDataProvider(maskImage)
								 , NULL
								 , false);
		
		//Create image layer
		imageLayer=CGLayerCreateWithContext(UIGraphicsGetCurrentContext(), self.frame.size, NULL);
		
		//create a context for image layer
		imageContext=CGLayerGetContext(imageLayer);
		
		//draw image on layer
		UIImage* white=[UIImage imageNamed:@"white.png"];
		CGContextDrawImage(imageContext, self.bounds, white.CGImage);
		CGContextDrawImage(imageContext, self.bounds, self.image.CGImage);
		CGContextSetLineCap(imageContext, kCGLineCapRound);
	
		
		//set mask context to null
		maskContext=nil;
		
		//Begin Image context to fill color in image
		UIGraphicsBeginImageContext(self.frame.size);
		
		//set current drawing context to mask context
		maskContext=UIGraphicsGetCurrentContext();
		CGContextTranslateCTM(maskContext, 0, self.bounds.size.height);
		CGContextScaleCTM(maskContext, 1.0, -1.0);
		
		//Clip context to mask in order to retrict our drawing area 
		CGContextClipToMask(maskContext, self.bounds, mask);
		
		//Draw transparent border
		CGContextDrawImage(maskContext, self.bounds, imgTransparent.CGImage);
	}
	//set line width and color
	CGContextSetLineWidth(imageContext, self.thickness);
	CGContextSetRGBStrokeColor(imageContext, self.red,self.green,self.blue,self.thickness);
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	mouseSwiped = YES;
	
	UITouch *touch = [touches anyObject];	
	CGPoint currentPoint = [touch locationInView:self];
	
	//Draw line on image layer
	CGContextBeginPath(imageContext);
	CGContextMoveToPoint(imageContext, lastPoint.x, self.bounds.size.height-lastPoint.y);
	CGContextAddLineToPoint(imageContext, currentPoint.x,self.bounds.size.height-currentPoint.y);
	CGContextStrokePath(imageContext);
	
	///draw image layer on mask context in order to get the new image with filled color
	CGContextDrawLayerInRect(maskContext, self.bounds, imageLayer);
	
	//draw transparent border for image clarity
	CGContextDrawImage(maskContext, self.bounds, imgTransparent.CGImage);
	
	//save image
	self.image = UIGraphicsGetImageFromCurrentImageContext();
	
	lastPoint = currentPoint;
	mouseMoved++;
	
	if (mouseMoved == 10) 
	{
		mouseMoved = 0;
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	flag=FALSE;
	if(!mouseSwiped) 
	{
		UIGraphicsBeginImageContext(self.frame.size);
		CGRect rect=self.bounds;
		CGContextBeginPath(imageContext);
		CGContextMoveToPoint(imageContext, lastPoint.x, self.bounds.size.height-lastPoint.y);
		CGContextAddLineToPoint(imageContext, lastPoint.x,self.bounds.size.height-lastPoint.y);
		CGContextStrokePath(imageContext);
		CGContextTranslateCTM(UIGraphicsGetCurrentContext(), 0, self.bounds.size.height);
		CGContextScaleCTM(UIGraphicsGetCurrentContext(), 1.0, -1.0);
		CGContextClipToMask(UIGraphicsGetCurrentContext(), rect, mask);
		CGContextDrawLayerInRect(UIGraphicsGetCurrentContext(), rect, imageLayer);
		CGContextDrawImage(maskContext, self.bounds, imgTransparent.CGImage);
		self.image = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();
	}
}

- (void)dealloc 
{
	//Release Context
	if(maskContext)   
	{
		CGLayerRelease(imageLayer);
		maskContext=nil;
		UIGraphicsEndImageContext();
	}
	CGImageRelease(mask);
    [super dealloc];
}


@end
