//
//  Product.h
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/21/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Product : NSObject
@property NSArray  *images;
@property UIImage  *thumbnail;
@property NSString *name;
@property NSNumber *price;
@property NSDate   *date;

+(id) initWithName:(NSString*)name images:(NSArray*)images
		 thumbnail:(NSString*)thumbnail price:(NSNumber*)price date:(NSDate*)date;

+(NSArray*) createDummyDatabase;

@end
