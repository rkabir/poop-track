//
// Created by Raj Sathi on 1/27/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PoopDatabase.h"


@interface AppModel : NSObject
{
@private
    PoopDatabase* poopDatabase_;
}

+ (AppModel*) instance;
@end