//
// Created by Raj Sathi on 1/28/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PoopEntry : NSObject
{
@private
    int id_;
    int type_;
    int date_;
    NSDate* time_;
    NSString* comment_;
    bool deleted_;
}

- (id) initWith: (int) id type: (int) type date: (int) date time: (NSDate*) time comment: (NSString*) comment deleted: (int) deleted;

@property (nonatomic, assign) int id;
@property (nonatomic, assign) int type;
@property (nonatomic, assign) int date;
@property (copy) NSDate* time;
@property (copy) NSString* comment;
@property (nonatomic, assign) bool deleted;

@end