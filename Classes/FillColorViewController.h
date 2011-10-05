//
//  FillColorViewController.h
//  FillColor
//
//  Created by Astron Infotech on 03/05/2010.
//  Copyright Astron Infotech 2011. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FillColorView.h"
#import "ColorPickerImageView.h"
#import <QuartzCore/QuartzCore.h>

@interface FillColorViewController : UIViewController 
{
	/* 
	 Tools That you have used in xib file, need to bind with its controller file.
	 This is done by Declaring tool with IBOutlet as Prefix.
	 
	 Tools That you haven't used in xib but used in controller file, need not to bind with xib,
	 such tools do not have IBOutlet as Prefix.
	 
	 Declaration of all global variables and objects also here.
	 */
	
	IBOutlet ColorPickerImageView* colorWheel;
	IBOutlet UISlider* objSlider;
	IBOutlet UIButton* btnPickColor;
	IBOutlet UIImageView* imgSelectedColor;
	FillColorView* imgFillColor;
}

// Defining Property as per fields, tools, variables and objects.
@property(nonatomic,retain)ColorPickerImageView *colorWheel;

// Declaration of all Public methods that are going to i mplement inside implementation file, need to declare here.

#pragma mark color picker Methods
- (IBAction) pickColor: (id)sender;
- (void) pickedColor:(UIColor*)color;
- (void) animateColorWheelToShow:(BOOL)show duration:(NSTimeInterval)duration;

#pragma mark Slider Methods
-(IBAction) sliderValue_Changed: (id)sender;

@end

