//
//  ViewController.m
//  FriendsList
//
//  Created by Lion User on 28/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
 
@end

@implementation ViewController

NSMutableArray *tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize table data with names from "Game of Thrones"    
    tableData = [NSMutableArray arrayWithObjects:@"Khaleesi", @"Eddard", @"Arya", @"Tyrion", @"Cersei", @"Jon Snow", @"Joffrey", @"Mormont", @"Sansa",@"Drogo",nil];
    
    // Add an Edit button to navigation bar
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
    

}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/* two standard methods */

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableViewLocal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableViewLocal dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

/* row removed on swipe */
- (void)tableView:(UITableView *)tableViewLocal commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableData removeObjectAtIndex:indexPath.row];
    
    [tableViewLocal reloadData];
}


// React to Edit button
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if(self.editing)
    {        
        [tableView setEditing:NO animated:NO];
        [tableView reloadData];
    }
    else
    {
        [tableView setEditing:YES animated:YES];
        [tableView reloadData];
    }
}
//Resolve the possibility to move
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *stringToMove = [tableData objectAtIndex:sourceIndexPath.row];
    [tableData removeObjectAtIndex:sourceIndexPath.row];
    [tableData insertObject:stringToMove atIndex:destinationIndexPath.row];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
        // Allow the proposed destination.
    return proposedDestinationIndexPath;
}

@end
