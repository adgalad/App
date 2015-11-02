//
//  TableViewController.m
//  App_
//
//  Created by Carlos Spaggiari Roa on 10/21/15.
//  Copyright © 2015 ARSC. All rights reserved.
//

#import "TableViewController.h"
#import "FilteredTableViewController.h"
#import "ProductInformationViewController.h"
@interface TableViewController () <UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating>

@property UISearchController *searchController;
@property NSMutableArray  *products;
@property NSMutableArray  *allproducts;
@property NSMutableData   *data;
@property NSURLConnection *connection;
@property FilteredTableViewController *filteredTable;


@end

@implementation TableViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	self.products = [[NSMutableArray alloc] init];
	
	self.refreshControl = [[UIRefreshControl alloc] init];
	self.refreshControl.backgroundColor = [UIColor blueColor];
	self.refreshControl.tintColor = [UIColor whiteColor];
	[self.refreshControl addTarget:self
							action:@selector(loadFromServer:)
				  forControlEvents:UIControlEventValueChanged];


	[self loadFromServer:nil];
	self.allproducts = self.products;
	
	[self.tableView setDelegate:self];
	[self.tableView reloadData];
	
	_searchController = [[UISearchController alloc] initWithSearchResultsController:self.filteredTable];
	
	self.searchController.searchResultsUpdater = self;
	[self.searchController.searchBar sizeToFit];

	self.tableView.tableHeaderView = self.searchController.searchBar;
	
	self.searchController.delegate = self;
	self.searchController.dimsBackgroundDuringPresentation = NO;
	self.searchController.searchBar.delegate = self;
	
    self.definesPresentationContext = YES;
	

	

}

-(void) loadFromServer:(UIRefreshControl*)rc
{
	NSURLRequest *request = [NSURLRequest requestWithURL:
								[NSURL URLWithString:@"http://localhost:3000/products.json"]];
	self.connection = [[NSURLConnection alloc]
					   initWithRequest:request delegate:self];
	[self.refreshControl endRefreshing];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if ([self.products count] > 0) {

		self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
		self.tableView.backgroundView = nil;
		return 1;
		
	} else {
		
		// Display a message when the table is empty
		UILabel *messageLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height)];
		
		messageLabel.text = @"No data is currently available. Please pull down to refresh.";
		messageLabel.textColor = [UIColor blackColor];
		messageLabel.numberOfLines = 0;
		messageLabel.textAlignment = NSTextAlignmentCenter;
		messageLabel.font = [UIFont fontWithName:@"Palatino-Italic" size:20];
		[messageLabel sizeToFit];
		
		self.tableView.backgroundView = messageLabel;
		self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
		
	}
	
	return 0;
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController
{
	
	if ([self.searchController.searchBar.text isEqual:@""]){
		self.products = self.allproducts;
		[self.tableView reloadData];
		return;
	}
	NSString *searchText = self.searchController.searchBar.text;
	NSArray *searchResults = [self.products mutableCopy];
	
    searchText = [searchText stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
	NSString *regex = [NSString stringWithFormat:@".*%@.*",searchText];
	NSPredicate *predicate = [NSPredicate
							  predicateWithFormat:@"SELF.name MATCHES [c] %@",regex];
	searchResults = [self.allproducts filteredArrayUsingPredicate:predicate];

	self.products = [searchResults copy];
	[self.tableView reloadData];
	
}
- (TableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

	TableViewCell *cell = [[TableViewCell alloc]
						   initWithProduct:self.products[indexPath.row]];

	return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return self.products.count;
}




- (void) searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
	
}
- (void) addItemToTable:(UIBarButtonItem*) button
{

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Product *selectedProduct = (tableView == self.tableView) ?
	self.products[indexPath.row] : self.filteredTable.filteredProducts[indexPath.row];
	
	ProductInformationViewController *productViewController =
	[self.storyboard instantiateViewControllerWithIdentifier:
		@"ProductInformationViewController"];
	
	productViewController.product = selectedProduct;
	
	[self.navigationController pushViewController:productViewController animated:YES];
	
	
	
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	// A response has been received, this is where we initialize the instance var you created
	// so that we can append data to it in the didReceiveData method
	// Furthermore, this method is called each time there is a redirect so reinitializing it
	// also serves to clear it
	_data = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	// Append the new data to the instance variable you declared
	[_data appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
				  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
	// Return nil to indicate not necessary to store a cached response for this connection
	return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSString *responseString = [[NSString alloc] initWithData:_data encoding:NSUTF8StringEncoding];
	NSError *e = nil;
	NSData *jsonData = [responseString dataUsingEncoding:NSUTF8StringEncoding];
	NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:jsonData options: NSJSONReadingMutableContainers error: &e];
	if (JSON){
		[self.products removeAllObjects];
		for(NSDictionary *i in JSON)
		{
			NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
			[dateFormat setDateFormat:@"yyyy-MM-dd"];
			NSDate *date = [dateFormat dateFromString:i[@"date"]];
			
			[self.products addObject:[Product initWithName: i[@"name"]
													images: i[@"images"]
												 thumbnail: i[@"thumbnail"]
													 price: i[@"price"]
													  date: date]];
		}
		[self.tableView reloadData];
	}

}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	// The request has failed for some reason!
	// Check the error var
}

@end
