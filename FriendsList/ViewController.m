//
//  ViewController.m
//  FriendsList
//
//  Created by Lion User on 28/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"

@interface ViewController ()
 
@end

@implementation ViewController

NSMutableArray *tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize table data with names from "Game of Thrones"    
    tableData = [DataManager loadDataFromFile];

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
    int count = [tableData count];
	if(self.editing) count++;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableViewLocal cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableViewLocal dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //int count = 0;
	//if(self.editing && indexPath.row != 0)
	//	count = 1;
	
    if(indexPath.row == ([tableData count]) && self.editing){
		cell.textLabel.text = @"Add Data";
		return cell;
	}
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
        
    return cell;
}

/* row removed on swipe */
- (void)tableView:(UITableView *)tableViewLocal commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableData removeObjectAtIndex:indexPath.row];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        [tableData addObject:@"NewName"];
    }
    
    [tableViewLocal reloadData];
}


// React to Edit button
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if(self.editing)
    {
        [DataManager saveToFile:tableData];
        [super setEditing:NO animated:NO];
        [tableView setEditing:NO animated:NO];
        [tableView reloadData];
        [self.editButtonItem setTitle:@"Edit"];
        [self.editButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    else
    {
        [super setEditing:YES animated:YES];        
        [tableView setEditing:YES animated:YES];
        [tableView reloadData];
        [self.editButtonItem setTitle:@"Done"];
        [self.editButtonItem setStyle:UIBarButtonItemStyleDone];
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

//ability to Add new cells
- (UITableViewCellEditingStyle)tableView:(UITableView *)aTableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.editing == NO || !indexPath) {
     return UITableViewCellEditingStyleNone;   
    }
    if (self.editing && indexPath.row == [tableData count]) {
		return UITableViewCellEditingStyleInsert;
	} else {
		return UITableViewCellEditingStyleDelete;
	}
    return UITableViewCellEditingStyleNone;
}

@end
