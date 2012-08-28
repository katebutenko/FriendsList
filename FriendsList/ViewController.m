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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData objectAtIndex:indexPath.row];
    return cell;
}

/* row removed on swipe */
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableData removeObjectAtIndex:indexPath.row];
    
    [tableView reloadData];
}

@end
