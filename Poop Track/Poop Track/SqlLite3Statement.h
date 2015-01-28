//
// Created by Raj Sathi on 1/28/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

// Used as bridge to allow for easily using performSelector withObject (__bridge doesn't seem happy)
@interface SqlLite3Statement : NSObject
{
    sqlite3_stmt* statement_;
}
-(id) init: (sqlite3_stmt*) statement;
@property (nonatomic, readonly) sqlite3_stmt* statement;
@end