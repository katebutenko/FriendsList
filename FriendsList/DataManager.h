//
//  DataManager.h
//  FriendsList
//
//  Created by Lion User on 02/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataManager : NSObject

    +(NSMutableArray*) defaultData;

    +(NSString *) filePath;
    +(void) saveToFile:(NSArray *) arrayOfData;
    +(NSMutableArray *) loadDataFromFile;

@end
