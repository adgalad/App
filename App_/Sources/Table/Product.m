//
//  Product.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/21/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "Product.h"

@implementation Product

+(id) initWithName:(NSString*)name images:(NSArray*)images
		 thumbnail:(NSString*)thumbnail price:(NSNumber*)price date:(NSDate*)date
{
	Product *product = [[Product alloc] init];
	
	product.name  = name;

	NSURL *imageURL = [[NSURL alloc] initWithString:thumbnail];
	NSData *data = [NSData dataWithContentsOfURL:imageURL];
	product.thumbnail = [[UIImage alloc] initWithData:data];
	product.images = images;
	product.price = price;
	product.date  = date;
	
	return product;
}

+(NSArray*) createDummyDatabase
{
	NSArray *array = [[NSArray alloc] initWithObjects:
			[Product initWithName:@"Ipod"
						   images:@[@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/ipod.png",@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/ipad.png",@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/macbook.jpg",@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/macbook_pro.jpg"]
						thumbnail:@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/ipod.png"
							price: @499
							 date:[NSDate date]],
			[Product initWithName:@"Ipad"
						   images:@[@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/ipad.png"]
						thumbnail: @"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/ipad.png"
							price:@799
							 date:[NSDate date]],
			[Product initWithName:@"Macbook"
						   images:@[@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/macbook.jpg"]
 						thumbnail: @"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/macbook.jpg"
							price:@1199
							date:[NSDate date]],
			[Product initWithName:@"Macbook Pro"
						   images:@[@"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/macbook_pro.jpg"]
						thumbnail: @"/Volumes/HDD/Desktop_HDD/App_/App_/Resources/macbook_pro.jpg"
							price:@1899
							 date:[NSDate date]],

					  nil];

	return array;
}

@end
