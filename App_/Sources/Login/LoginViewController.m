//
//  ViewController.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/18/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()
@property UITextField *usernameField;
@property UITextField *passwordField;
@property UIButton	  *loginButton;
@property UIButton	  *clearButton;
@property NSUInteger   image;
@property (nonatomic, strong) IBOutlet UIView *blurEffectView;
@end

@implementation LoginViewController

- (id) init {
	UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
	
	LoginViewController *loginViewController = [mainStoryboard instantiateViewControllerWithIdentifier:@"loginViewController"];
	
	return loginViewController;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	[self createLoginView];
	[self createTapRecognizer];
}

- (void) respondToTapGesture:(UITapGestureRecognizer *)tapRecognizer;
{

	switch (self.image) {
		case 0:
			[self.view setBackgroundColor:
			 [UIColor colorWithPatternImage:
			  [UIImage imageNamed:@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/fotografías-de-paisajes-para-el-celular copy.jpg"]]];
			self.image = (self.image+1)%2;
			break;
		case 1:
			[self.view setBackgroundColor:
			 [UIColor colorWithPatternImage:
			  [UIImage imageNamed:@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/background_palm.jpg"]]];
			self.image = (self.image+1)%2;
		default:
			break;
	}
}

- (void) clearButtonPressed:(UIButton *)clearButton;
{
	[self.usernameField setText:@""];
	[self.passwordField setText:@""];
}

- (BOOL) loginButtonPressed
{
	if ([self.usernameField.text isEqual:@""]){
		[self.usernameField setBackgroundColor:[UIColor redColor]];
	} else {
		[self.usernameField setBackgroundColor:[UIColor whiteColor]];
	}
	
	if ([self.passwordField.text isEqual:@""])
	{
		[self.passwordField setBackgroundColor:[UIColor redColor]];
	} else {
		[self.passwordField setBackgroundColor:[UIColor whiteColor]];
	}

	if (![self.passwordField.text isEqual:@""] &&
		![self.usernameField.text isEqual:@""])
	{
		NSLog(@"Trying to login with \nUsername:\"%@\"\nPassword:\"%@\"",
			self.usernameField.text, self.passwordField.text);
		return YES;
	}
	return NO;
}

- (void) createTapRecognizer;
{
	UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
            initWithTarget:self action:@selector(respondToTapGesture:)];
	
	tapRecognizer.numberOfTapsRequired = 1;
	
	[self.view addGestureRecognizer:tapRecognizer];
}


- (void) createLoginView;
{
	
	for (UIView *i in self.view.subviews[0].subviews[2].subviews){
		if([i isKindOfClass:[UIButton class]]){
			UIButton *item = (UIButton *)i;
			if([[item restorationIdentifier] isEqual: @"loginButton"]){
				self.loginButton = item;
			}
			else if ([[item restorationIdentifier] isEqual:@"clearButton"]){
				self.clearButton = item;
				[self.clearButton addTarget:self
								action:@selector(clearButtonPressed:)
				 				forControlEvents:UIControlEventTouchUpInside];
			}
		}
		else if([i isKindOfClass:[UITextField class]]){
			UITextField *item = (UITextField *)i;
			if([[item restorationIdentifier] isEqual: @"usernameField"]){
				self.usernameField = item;
			}
			else if ([[item restorationIdentifier] isEqual:@"passwordField"]){
				self.passwordField = item;
			}
		}
	}
	[self.view setBackgroundColor:
	 [UIColor colorWithPatternImage:
	  [UIImage imageNamed:@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/background_palm.jpg"]]];
	self.image = 0;
	
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)segue:(id)sender{
//	[self performSegueWithIdentifier:@"loginButtonSegue" sender:self];
}

@end
