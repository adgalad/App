//
//  FilteredTableViewController.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/21/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "FilteredTableViewController.h"
#import "TableViewCell.h"
@implementation FilteredTableViewController


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (void) updateSearchResultsForSearchController:(UISearchController *)searchController
{
	
}
- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	
	TableViewCell *cell = [[TableViewCell alloc]
						   initWithProduct:self.filteredProducts[indexPath.row]];
	
	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.filteredProducts.count;
}

@end
