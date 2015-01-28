//
// Created by Raj Sathi on 1/28/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import "SqlLite3Statement.h"

@implementation SqlLite3Statement

-(id) init: (sqlite3_stmt*) statement
{
    if ( self = [super init] )
    {
        statement_ = statement;
    }
    return self ;
}

@synthesize statement = statement_;

@end