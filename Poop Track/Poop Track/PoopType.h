//
// Created by Raj Sathi on 1/28/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PoopType : NSObject
{
@private
    int id_;
    NSString* description_;
    bool deleted_;
}
- (id) initWith: (int) id desc: (NSString*) desc deleted: (int) deleted;

@property (nonatomic, assign) int id;
@property (copy) NSString* description;
@property (nonatomic, assign) bool deleted;

@end