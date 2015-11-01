//
//  IndexViewController.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/19/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "ColorGameViewController.h"

@interface ColorGameViewController () {
	CGFloat _viewTransparency[3];
	UIView *_playView[3];
}
@property UIButton *redColorButton;
@property UIButton *blueColorButton;
@property UIButton *greenColorButton;
@property UISlider *transparencySlider;
@property UISlider *lightSlider;
@property NSMutableArray  *color;
@property NSNumber *currentView;
@property UISegmentedControl *layerSegmentedControl;
@end

@implementation ColorGameViewController

- (id)init{
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main"
												 bundle:[NSBundle mainBundle]];
	ColorGameViewController *indexViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"indexViewController"];

	return indexViewController;
}

- (void)viewDidLoad {

    [super viewDidLoad];

	_viewTransparency[0] = 0.5;
	_viewTransparency[1] = 0.5;
	_viewTransparency[2] = 0.5;
	self.color = [NSMutableArray arrayWithObjects:[UIColor redColor],
				  [UIColor blueColor], [UIColor greenColor], nil];
	
	[self organizeViews:self.view];

}

- (void) organizeViews:(UIView*)rootView
{
	for (UIView *i in rootView.subviews)
	{
		if ([[i restorationIdentifier] isEqual:@"redColorButton"]) {
			self.redColorButton = (UIButton*)i;
			[self.redColorButton addTarget:self
									action:@selector(colorButtonPressed:)
						  forControlEvents:UIControlEventTouchUpInside];
		}
		else if ([[i restorationIdentifier] isEqual:@"blueColorButton"]) {
			self.blueColorButton = (UIButton*)i;
			[self.blueColorButton addTarget:self
									 action:@selector(colorButtonPressed:)
						   forControlEvents:UIControlEventTouchUpInside];
		}
		else if ([[i restorationIdentifier] isEqual:@"greenColorButton"]) {
			self.greenColorButton = (UIButton*)i;
			[self.greenColorButton addTarget:self
									  action:@selector(colorButtonPressed:)
							forControlEvents:UIControlEventTouchUpInside];
		}
		else if ([[i restorationIdentifier] isEqual:@"transparencySlider"]) {
			self.transparencySlider = (UISlider*)i;
			[self.transparencySlider addTarget:self
										action:@selector(transparencySliderDragger:)
							  forControlEvents:UIControlEventTouchDragInside];
		}
		else if ([[i restorationIdentifier] isEqual:@"lightSlider"]) {
			self.lightSlider = (UISlider*)i;
			[self.lightSlider addTarget:self
								 action:@selector(lightSliderDragged:)
					   forControlEvents:UIControlEventTouchDragInside];
		}
		else if ([[i restorationIdentifier] isEqual:@"firstView"]) {
			_playView[0] = i;
		}
		else if ([[i restorationIdentifier] isEqual:@"secondView"]) {
			_playView[1] = i;
		}
		else if ([[i restorationIdentifier] isEqual:@"thirdView"]) {
			_playView[2] = i;
		}
		else if ([[i restorationIdentifier] isEqual:@"layerSegmentedControl"]) {
			self.layerSegmentedControl = (UISegmentedControl*)i;
			[self.layerSegmentedControl addTarget:self
										   action:@selector(layerSegmentedControlPressed:)
								 forControlEvents:UIControlEventAllEvents];
		}
		else{
			[self organizeViews:i];
		}
	}

}

- (void) colorButtonPressed:(UIButton*) button
{
	if ([[button restorationIdentifier] isEqual:@"redColorButton"])
	{
		self.color[self.layerSegmentedControl.selectedSegmentIndex] = [UIColor redColor];
	}
	else if ([[button restorationIdentifier] isEqual:@"blueColorButton"])
	{
		self.color[self.layerSegmentedControl.selectedSegmentIndex] = [UIColor blueColor];
	}
	else if ([[button restorationIdentifier] isEqual:@"greenColorButton"])
	{
		self.color[self.layerSegmentedControl.selectedSegmentIndex] = [UIColor greenColor];
	}
	CGFloat h, s, b, a;
	if ([self.color[self.layerSegmentedControl.selectedSegmentIndex]
		 getHue:&h saturation:&s brightness:&b alpha:&a])
	{
		[_playView[self.layerSegmentedControl.selectedSegmentIndex]
					setBackgroundColor:[UIColor colorWithHue:h
												saturation:s
												brightness:self.lightSlider.value
												alpha:a]];
	}
}

- (void) transparencySliderDragger:(UISlider*)slider
{
	NSInteger index = self.layerSegmentedControl.selectedSegmentIndex;
	[_playView[index] setAlpha:self.transparencySlider.value];
	_viewTransparency[index] = [self.transparencySlider value];
	
}
- (void) lightSliderDragged:(UISlider*)slider
{
	CGFloat h, s, b, a;
	if ([self.color[self.layerSegmentedControl.selectedSegmentIndex]
		 getHue:&h saturation:&s brightness:&b alpha:&a])
	{
		[_playView[self.layerSegmentedControl.selectedSegmentIndex]
					setBackgroundColor:[UIColor colorWithHue:h
												saturation:s
												brightness:self.lightSlider.value
												alpha:a]];
	}
}

- (void)layerSegmentedControlPressed:(UISegmentedControl*) segmenetedcontrol
{
	NSLog(@"%lu",self.layerSegmentedControl.selectedSegmentIndex);
	CGFloat f = _viewTransparency[self.layerSegmentedControl.selectedSegmentIndex];
	[self.transparencySlider setValue:f];
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
