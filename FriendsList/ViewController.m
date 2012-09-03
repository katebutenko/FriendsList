//
//  ViewController.m
//  FriendsList
//
//  Created by Lion User on 28/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "DataManager.h"


@implementation ViewController

NSMutableArray *tableData;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Initialize table data with names from "Game of Thrones"    
    tableData = [DataManager loadDataFromFile];

    // Add an Edit button to navigation bar
	self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self setTitle:@"Game of Thrones"];

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
    //for most of the cells, simply create them
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableViewLocal dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    //if we are in editing mode, add last editable cell to the table
    
    if(indexPath.row == ([tableData count]) && self.editing){
        //check if we do not already have editable field. If yes - reuse it.
        if (newNameField==nil) {
            newNameField = [self makeTextField:@"Enter new name here" ];
        }
        
        [cell addSubview:newNameField];
        // Textfield dimensions
        newNameField.frame = CGRectMake(40, 6, 270, 30);
        
        // dismiss keyboard when Done/Return is tapped
        [newNameField addTarget:self action:@selector(textFieldFinished:) forControlEvents:UIControlEventEditingDidEndOnExit];	
        
        // We want to handle textFieldDidEndEditing
        newNameField.delegate = self;
        
        // This cell should display no text, just a placeholder
        cell.textLabel.text = @"";
		return cell;
	}
    //if the cell was a simple cell, fill it with data from source
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
        
    return cell;
}

/* row removed on swipe */
- (void)tableView:(UITableView *)tableViewLocal commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [tableData removeObjectAtIndex:indexPath.row];
    }
    
    [tableViewLocal reloadData];
}

// React to Edit button
- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    if(self.editing)
    {
        //add object to the table only if user has entered something
        if ([newNameField.text length]!=0) {
            [tableData addObject:newNameField.text];
        }
        [DataManager saveToFile:tableData];
        [newNameField removeFromSuperview];
        [super setEditing:NO animated:NO];
        [tableView setEditing:NO animated:NO];
        [tableView reloadData];
        [self.editButtonItem setTitle:@"Edit"];
        [self.editButtonItem setStyle:UIBarButtonItemStylePlain];
    }
    else
    { 
        //clear editable cell
        if (newNameField !=nil) newNameField.text=@"";
        [super setEditing:YES animated:YES];        
        [tableView setEditing:YES animated:YES];
        [tableView reloadData];
        [self.editButtonItem setTitle:@"Done"];
        [self.editButtonItem setStyle:UIBarButtonItemStyleDone];
    }
}

//Resolve the possibility to move
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row >= [tableData count]) return NO;
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *stringToMove = [tableData objectAtIndex:sourceIndexPath.row];
    [tableData removeObjectAtIndex:sourceIndexPath.row];
    [tableData insertObject:stringToMove atIndex:destinationIndexPath.row];
    
}

- (NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {
    // Do not allow to move items over editable cell
    if (proposedDestinationIndexPath.row>=[tableData count]) {
        return sourceIndexPath;
    }
    return proposedDestinationIndexPath;
}

//ability to add new cells
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
//create text field for editable cell
-(UITextField*) makeTextField:(NSString*)placeholderText {
	UITextField *tf = [[UITextField alloc] init];
    tf.placeholder = placeholderText;         
	tf.autocorrectionType = UITextAutocorrectionTypeNo ;
	tf.autocapitalizationType = UITextAutocapitalizationTypeNone;
	tf.adjustsFontSizeToFitWidth = YES;
    tf.borderStyle = UITextBorderStyleRoundedRect;
    tf.textAlignment = UITextAlignmentLeft;
    tf.font = [UIFont boldSystemFontOfSize:20.0];
    
	return tf ;
}

//override what is done on pressing Return button on keyboard
- (IBAction)textFieldFinished:(id)sender {
   
}
@end
