//
//  FillColorView.h
//  TenderTouch
//
//  Created by Astron Infotech on 03/05/2010.
//  Copyright Astron Infotech 2011. All rights reserved.

#import <UIKit/UIKit.h>
@interface FillColorView : UIImageView 
{
	CGPoint lastPoint;
	BOOL mouseSwiped;	
	int mouseMoved;
	
	///RGB components used to fill color
	double red;
	double green;
	double blue;
	double alpha;
	
	///Brush size 
	double thickness;
	
	CGImageRef mask;
	CGContextRef maskContext;
	CGLayerRef imageLayer;
	CGContextRef imageContext;
	BOOL flag;
	
	UIImage* imgBlack;
	UIImage* imgTransparent;
	UIImage* imgWhite;
}

@property(nonatomic, readwrite) double red;
@property(nonatomic, readwrite) double green;
@property(nonatomic, readwrite) double blue;
@property(nonatomic, readwrite) double alpha;
@property(nonatomic, readwrite) double thickness;
@property(nonatomic, retain) UIImage* imgBlack;
@property(nonatomic, retain) UIImage* imgTransparent;

@end
