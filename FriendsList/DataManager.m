//
//  DataManager.m
//  FriendsList
//
//  Created by Lion User on 02/09/2012.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DataManager.h"

@implementation DataManager



+(NSMutableArray *) defaultData{
    return [NSMutableArray arrayWithObjects:@"Khaleesi", @"Eddard", @"Arya", @"Tyrion", @"Cersei", @"Jon Snow",@"Drogo",nil];
}

+(NSString*) filePath{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectoryPath = [paths objectAtIndex:0];
    NSString *path = [documentsDirectoryPath stringByAppendingPathComponent:@"ListOfNames.plist"];
    return path;
}

+(void)saveToFile:(NSArray *)arrayOfData{
    [arrayOfData writeToFile:[self filePath] atomically:YES];
}

+(NSMutableArray *)loadDataFromFile {
    NSMutableArray* loadedArray = [[NSMutableArray alloc] initWithContentsOfFile:[self filePath]];    
    if (loadedArray == nil || [loadedArray count] == 0){
        loadedArray = [self defaultData];
    }
    
    return loadedArray;
}
@end
