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
@property UIImageView* image;
@property UIPageControl *imageControl;
@end

@implementation ProductInformationViewController

- (void) viewDidLoad
{
	[super viewDidLoad];
	[self organizeView:self.view];
}

- (void) organizeView:(UIView*)root
{
	for (UIView* i in root.subviews)
	{
		if ([[i restorationIdentifier] isEqual:@"imageView"]){
			self.image = (UIImageView*) i;
			[self.image setImage:self.product.thumbnail];
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
			self.imageControl.numberOfPages = [self.product.images count];
			self.imageControl.hidesForSinglePage = YES;
			[self.imageControl addTarget:self action:@selector(imageControlTouched:) forControlEvents:UIControlEventTouchUpInside];
		}
		else{
			[self organizeView:i];
		}
	}
}

- (void)imageControlTouched:(UIPageControl*)imageControl
{
	[self.image setImage:[UIImage
						  imageNamed:self.product.images[self.imageControl.currentPage]]];
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	_initialPosition = [touch locationInView:self.view];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	
	for (UITouch *i in [touches allObjects]) {
		if ([[i.view restorationIdentifier] isEqual:@"Hola"]){
			CGPoint endPosition = [i locationInView:self.view];
			
			if (_initialPosition.x >= endPosition.x &&
				self.imageControl.currentPage < self.imageControl.numberOfPages){
				
				self.imageControl.currentPage =
					(self.imageControl.currentPage + 1);
				
				[self.image setImage:[UIImage
									  imageNamed:self.product.images[
											self.imageControl.currentPage]]];
			}
			else if (self.imageControl.currentPage > 0) {
				self.imageControl.currentPage =
						(self.imageControl.currentPage - 1);
				[self.image setImage:[UIImage
									  imageNamed:self.product.images[
											self.imageControl.currentPage]]];
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
