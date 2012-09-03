//
//  ViewController.h
//  FriendsList
//
//  Created by Lion User on 28/08/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController <UITableViewDelegate, UITableViewDataSource,UITextFieldDelegate>
{
    IBOutlet UITableView *tableView;
    UITextField* newNameField;
}
-(UITextField*) makeTextField:(NSString*)placeholder  ;
    //@property (nonatomic, weak) IBOutlet UITextField *textField;


@end
