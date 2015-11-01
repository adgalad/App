//
//  LogoutStoryboardSegue.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/19/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "LogoutStoryboardSegue.h"

@implementation LogoutStoryboardSegue

- (void) perform
{
	UIViewController *sourceViewController = [self sourceViewController];
	UIViewController *destinationViewController = [self destinationViewController];
	
	[sourceViewController presentViewController:destinationViewController animated:YES completion:NULL];
}

@end
