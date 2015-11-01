//
//  LoginSegue.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/19/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "LoginStoryboardSegue.h"

@implementation LoginStoryboardSegue

- (void) perform
{
	LoginViewController *sourceViewController = [self sourceViewController];
	UIViewController	*destinationViewController = [self destinationViewController];

	if ([sourceViewController loginButtonPressed]){
		[sourceViewController.navigationController
				pushViewController:	destinationViewController animated:YES];
		[sourceViewController presentViewController:destinationViewController
										   animated:YES completion:NULL];
	}
}

@end
