    //
//  TimelineViewController.m
//  ApiTwitter
//
//  Created by Christopher White on 3/3/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TimelineViewController.h"
#import "OfflineTwitterAppDelegate.h"
#import "TweetTableViewCell.h"
#import "TwitterDataStore.h"

@implementation TimelineViewController

- (id)init {
	self = [super init];
	if (self != nil) {
		self.tabBarItem = [[[UITabBarItem alloc] initWithTitle:@"Tweets" image:nil tag:0] autorelease];
	}
	return self;
}

- (void)refreshUI
{
    [tweets release];
    tweets = [[twitterDataStore tweets] retain];

    [self.tableView reloadData];
}

- (void)tweetsDidSynchronize:(NSNotification*)notification 
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    //update the UI on the main thread
    [self performSelectorOnMainThread:@selector(refreshUI) withObject:nil waitUntilDone:YES];
}

- (void)synchronizeTweets:(NSArray*)newTweets 
{
    //listen for a notification with the name of the identifier
	[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(tweetsDidSynchronize:) 
                                                 name:@"tweetsDidSynchronize" 
                                               object:nil];
    
    [twitterDataStore synchronizeTweets:newTweets];
}

- (void)twitterFollowersRequestDidComplete:(NSNotification*)notification {
	
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    
    [self performSelectorInBackground:@selector(synchronizeTweets:) withObject:[notification.userInfo objectForKey:@"tweets"]];
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    
    twitterDataStore = [[TwitterDataStore alloc] init];
    tweets = [[twitterDataStore tweets] retain];
	
	NSString *identifier = [sa_OAuthTwitterEngine getHomeTimeline];
    
	//listen for a notification with the name of the identifier
	[[NSNotificationCenter defaultCenter] addObserver:self 
                                             selector:@selector(twitterFollowersRequestDidComplete:) 
                                                 name:identifier 
                                               object:nil];
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
	return [tweets count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";

    TweetTableViewCell *cell = (TweetTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[TweetTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
	Tweet *tweet = [tweets objectAtIndex:[indexPath row]];
	cell.tweet = tweet;
    
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

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [twitterDataStore release];
    [tweets release];
    [super dealloc];
}


@end
