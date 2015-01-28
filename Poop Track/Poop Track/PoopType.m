//
// Created by Raj Sathi on 1/28/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import "PoopType.h"


@implementation PoopType
{

}

- (id) initWith: (int) id desc: (NSString*) desc deleted: (int) deleted
{
    if (self = [super init])
    {
        self.id = id;
        self.description = desc;
        self.deleted = deleted == 1;
    }

    return self;
}

@synthesize id = id_;
@synthesize description = description_;
@synthesize deleted = deleted_;
@end