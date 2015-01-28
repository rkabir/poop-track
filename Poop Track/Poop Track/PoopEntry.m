//
// Created by Raj Sathi on 1/28/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import "PoopEntry.h"


@implementation PoopEntry
{

}

- (id) initWith: (int) id type: (int) type date: (int) date time: (NSDate*) time comment: (NSString*) comment deleted: (int) deleted
{
    if (self = [super init])
    {
        self.id = id;
        self.type = type;
        self.date = date;
        self.time = time;
        self.comment = comment;
        self.deleted = deleted == 1;
    }

    return self;
}

@synthesize id = id_;
@synthesize type = type_;
@synthesize date = date_;
@synthesize time = time_;
@synthesize comment = comment_;
@synthesize deleted = deleted_;
@end