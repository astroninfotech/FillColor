//
//  FillColorViewController.m
//  FillColor
//
//  Created by Astron Infotech on 03/05/2010.
//  Copyright Astron Infotech 2011. All rights reserved.
//

#import "FillColorViewController.h"

@implementation FillColorViewController
@synthesize colorWheel;

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	colorWheel.pickedColorDelegate = self;
	[self animateColorWheelToShow:NO duration:0];
	
	//initialize slider value
	objSlider.maximumValue=10;
	objSlider.minimumValue=1;
	objSlider.value=5;
	imgSelectedColor.backgroundColor=[UIColor redColor];
	
	///initialize drawing with image
	imgFillColor=[[FillColorView alloc]initWithImage:[UIImage imageNamed:@"butterfly.png"]];
	imgFillColor.imgBlack=[UIImage imageNamed:@"butterfly_black.png"];
	imgFillColor.imgTransparent=[UIImage imageNamed:@"butterfly_transparent.png"];
	imgFillColor.frame= CGRectMake(5,65,310,395);
	imgFillColor.red=1.0;
	imgFillColor.blue=0;
	imgFillColor.green=0;
	imgFillColor.alpha=1;
	imgFillColor.thickness=objSlider.value;
	imgFillColor.userInteractionEnabled=TRUE;
	[self.view addSubview:imgFillColor];
	[self.view sendSubviewToBack:imgFillColor];
}

#pragma mark -
#pragma mark color picker methods

- (IBAction) pickColor: (id)sender {
	[self animateColorWheelToShow:YES duration:0.3]; 
}

- (void) pickedColor:(UIColor*)color 
{
	[self animateColorWheelToShow:NO duration:0.3];
	if(CGColorGetNumberOfComponents(color.CGColor)==4)
	{
		//set brush color to picked color
		imgSelectedColor.backgroundColor=color;
		const float* colors = CGColorGetComponents( color.CGColor );
		imgFillColor.red = colors[0];
		imgFillColor.green = colors[1];
		imgFillColor.blue = colors[2];
		imgFillColor.alpha = colors[3];
	}
	[self.view setNeedsDisplay];
}

- (void) animateColorWheelToShow:(BOOL)show duration:(NSTimeInterval)duration {
	int x;
	float angle;
	float scale;
	if (show==NO) { 
		x = -320;
		angle = -3.12;
		scale = 0.01;
		self.colorWheel.hidden=YES; 
	} else {
		x=0;
		angle = 0;
		scale = 1;
		[self.colorWheel setNeedsDisplay];
		self.colorWheel.hidden=NO;
	}
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationDuration:duration];
	
	CATransform3D transform = CATransform3DMakeTranslation(0,0,0);
	transform = CATransform3DScale(transform, scale,scale,1);
	self.colorWheel.transform=CATransform3DGetAffineTransform(transform);
	self.colorWheel.layer.transform=transform;
	[UIView commitAnimations];
}

#pragma mark -
#pragma mark Slider methods

-(IBAction) sliderValue_Changed: (id)sender
{
	//set the thickness of brush
	imgFillColor.thickness=objSlider.value;
}


#pragma mark -
#pragma mark Memory Methods

- (void)dealloc 
{
	///Release all components
	[imgSelectedColor release];
	[self.colorWheel release];
	[objSlider release];
	[imgFillColor release];
    [super dealloc];
}

@end
