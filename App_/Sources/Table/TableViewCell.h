//
//  TableViewCell.h
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/21/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"

@interface TableViewCell : UITableViewCell{
	UIImageView *_image;
	UILabel		*_name;
	UILabel		*_price;
	
}

- (id) initWithProduct:(Product*)product;

@end
