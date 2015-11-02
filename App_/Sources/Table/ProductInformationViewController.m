//
//  ProductInformationViewController.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/22/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "ProductInformationViewController.h"


@interface ProductInformationViewController ()
{
	CGPoint _initialPosition;
}
@property UIImageView* imageView;
@property NSMutableArray *images;
@property UIPageControl *imageControl;
@end

@implementation ProductInformationViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	self.images = [[NSMutableArray alloc] init];
	// Set the thumbnail image as one of the images to display
	// in the product information
	[self.images addObject:self.product.thumbnail];
	
	// Load the rest of the images from the server
	for (NSString *i in self.product.images)
	{
		UIImage *image =[UIImage imageWithData:
						 [NSData dataWithContentsOfURL:
						  [NSURL URLWithString:i]]];
		if (image){
			[self.images addObject:image];
		}
	}
	[self organizeView:self.view];
}

// Setting all controller's UIViews recursively
- (void) organizeView:(UIView*)root
{
	for (UIView* i in root.subviews)
	{
		if ([[i restorationIdentifier] isEqual:@"imageView"]){
			self.imageView = (UIImageView*) i;
			[self.imageView setImage:self.images[0]];
		}
		else if ([[i restorationIdentifier] isEqual:@"name"]){
			[((UILabel*)i) setText:self.product.name];
		}
		else if ([[i restorationIdentifier] isEqual:@"price"]){
			[((UILabel*)i) setText:[NSString stringWithFormat:@"$ %@",self.product.price]];
		}
		else if ([[i restorationIdentifier] isEqual:@"date"]){
			NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
			[formatter setDateFormat:@"dd-MM-yyyy"];
			NSString *stringFromDate = [formatter stringFromDate:self.product.date];
			[((UILabel*)i) setText:stringFromDate];
		}
		else if ([[i restorationIdentifier] isEqual:@"imageControl"]){
			self.imageControl = (UIPageControl*)i;
			self.imageControl.numberOfPages = [self.images count];
			self.imageControl.hidesForSinglePage = YES;
			[self.imageControl addTarget:self action:@selector(imageControlTouched:) forControlEvents:UIControlEventTouchUpInside];
		}
		else{
			[self organizeView:i];
		}
	}
}

// Change the image if the image controller was touched.
- (void)imageControlTouched:(UIPageControl*)imageControl
{
	[self.imageView setImage:[self.images
						objectAtIndex:self.imageControl.currentPage]];
}

// Get the initial position of the touch event.
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	_initialPosition = [touch locationInView:self.view];
}

// Calculate if the touch event was a swap to the left or to the
// right, then set correct image.
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	for (UITouch *i in [touches allObjects]) {
		if ([[i.view restorationIdentifier] isEqual:@"Hola"]){
			CGPoint endPosition = [i locationInView:self.view];
			// Move to Right
			if (_initialPosition.x >= endPosition.x &&
				self.imageControl.currentPage < self.imageControl.numberOfPages)
			{
				self.imageControl.currentPage =
					(self.imageControl.currentPage + 1);
				
				[self.imageView setImage:[self.images
								objectAtIndex:self.imageControl.currentPage]];
			}
			// Move to Left
			else if (self.imageControl.currentPage > 0) {
				self.imageControl.currentPage =
						(self.imageControl.currentPage - 1);
				[self.imageView setImage:[self.images
								objectAtIndex:self.imageControl.currentPage]];
			}
			return;
		}
	};
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}
@end
