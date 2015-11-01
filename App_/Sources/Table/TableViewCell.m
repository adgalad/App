//
//  TableViewCell.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/21/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (id) initWithProduct:(Product*)product
{
	TableViewCell *cell = [[[NSBundle mainBundle] loadNibNamed:@"TableViewCell" owner:self options:nil] firstObject];
	
	[self organizeViews:cell.contentView];;
	_image.image = product.thumbnail;
	_name.text = product.name;
	_price.text = [[NSString alloc] initWithFormat:@"$%@",product.price];
	NSLog(@"Hola");
	return cell;
}

- (void) organizeViews:(UIView*) root
{
	for (UIView *i in root.subviews)
	{
		if ([[i restorationIdentifier] isEqual:@"name"]){
			_name = (UILabel*)i;
		}
		else if ([[i restorationIdentifier] isEqual:@"price"]){
			_price = (UILabel*)i;
		}
		else if ([[i restorationIdentifier] isEqual:@"image"]){
			_image = (UIImageView*)i;
		}
		else{
			[self organizeViews:i];
		}
	}
}

- (void)awakeFromNib {

	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
