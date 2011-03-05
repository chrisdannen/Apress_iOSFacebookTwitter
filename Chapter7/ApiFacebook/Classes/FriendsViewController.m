//
//  FriendsViewController.m
//  OAuthFacebook
//
//  Created by Christopher White on 2/19/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FriendsViewController.h"
#import "AppDelegate.h"
#import "FriendTableViewCell.h"

@implementation FriendsViewController

#pragma mark -
#pragma mark View lifecycle

- (id)init {
	self = [super init];
	if (self != nil) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Friends" image:nil tag:1] autorelease];
	}
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
	
	NSMutableDictionary *params = [NSMutableDictionary dictionary];
	//[params setObject:@"id,name,picture" forKey:@"fields"];
	//[params setObject:@"U" forKey:@"date_format"];
	
	//does not require extended permissions
	//[facebook requestWithGraphPath:@"me/friends" andParams:params andDelegate:self];
	
	//[facebook requestWithGraphPath:@"me/home" andParams:params andDelegate:self];
	
	// requires 'user_notes' extended permissions
	//[facebook requestWithGraphPath:@"me/notes" andParams:params andDelegate:self];
	
	// requires 'user_events' extended permissions
	//[facebook requestWithGraphPath:@"me/events" andParams:params andDelegate:self];
	
	//requires 'user_groups' extended permissions
	//[facebook requestWithGraphPath:@"me/groups" andParams:params andDelegate:self];
	
	// requires 'user_likes' extended permissions
	//[facebook requestWithGraphPath:@"me/likes" andParams:params andDelegate:self];
	//[facebook requestWithGraphPath:@"me/movies" andParams:params andDelegate:self];
	//[facebook requestWithGraphPath:@"me/music" andParams:params andDelegate:self];
	//[facebook requestWithGraphPath:@"me/books" andParams:params andDelegate:self];	??
	
	// requires 'read_stream' extended permissions
	//[facebook requestWithGraphPath:@"me/feed" andParams:params andDelegate:self];
	
	// requires 'user_photos' extended permissions
	//[facebook requestWithGraphPath:@"me/photos" andParams:params andDelegate:self]; //tagged photos?
	//[facebook requestWithGraphPath:@"me/videos" andParams:params andDelegate:self]; //tagged photos?
	//[facebook requestWithGraphPath:@"me/albums" andParams:params andDelegate:self];
	
	// requires 'user_checkins' extended permissions
	//[facebook requestWithGraphPath:@"me/checkins" andParams:params andDelegate:self];

	[params setObject:@"3" forKey:@"limit"];
	[params setObject:@"3" forKey:@"offset"];
	[facebook requestWithGraphPath:@"me/feed" andParams:params andDelegate:self];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/


#pragma mark -
#pragma mark Table view data source

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    FriendTableViewCell *cell = (FriendTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[FriendTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	NSDictionary *friendDictionary = [items objectAtIndex:[indexPath row]];
	cell.data = friendDictionary;
    
    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController release];
    */
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end

