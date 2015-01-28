//
// Created by Raj Sathi on 1/27/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import "AppModel.h"


@implementation AppModel
{

}

+ (AppModel*) instance
{
    static AppModel* instance = nil;
    if (instance == nil)
        instance = [[AppModel alloc] init];
    return instance;
}

-(id) init
{
    if (self = [super init])
    {
         poopDatabase_ = [[PoopDatabase alloc] init];
    }

    return self;
}
@end