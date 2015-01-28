//
// Created by Raj Sathi on 1/27/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import "PoopDatabase.h"
#import "PoopType.h"
#import "SqlLite3Statement.h"
#import "PoopEntry.h"


@implementation PoopDatabase
{

}

- (id) init
{
    if (self = [super initWithDatabaseFileName: @"PoopDatabase.sqlite"])
    {

    }

    return self;
}

- (NSArray*) getPoopEntriesForDate: (int) date
{
    NSString* sql = @"Select id, type, date, time, comment, deleted FROM PoopEntries WHERE date = ?";
    sqlite3_stmt* statement = [self getStatement: sql];

    int colIndex = 1;
    [self bindInt: date forStatement: statement atIndex: colIndex++];

    NSArray* poopTypes = [self executeStatement: statement processorTarget: self processorSelector: @selector(processPoopEntry:)];
    [self finalizeStatement: statement];

    return poopTypes;
}

- (NSArray*) getPoopTypes
{
    NSString* sql = @"Select id, desc, deleted FROM PoopTypes";
    sqlite3_stmt* statement = [self getStatement: sql];

    NSArray* poopTypes = [self executeStatement: statement processorTarget: self processorSelector: @selector(processPoopType:)];
    [self finalizeStatement: statement];

    return poopTypes;
}

- (NSObject*) processPoopType: (id) statement
{
    SqlLite3Statement* statementObject = (SqlLite3Statement*) statement;
    sqlite3_stmt* sqlLiteStatement = statementObject.statement;

    int colIndex = 0 ;
    int id = sqlite3_column_int(sqlLiteStatement, colIndex++);

    const char* value = (const char*)sqlite3_column_text(sqlLiteStatement, colIndex++);
    NSString* desc = [[NSString alloc] initWithUTF8String: value] ;

    int deleted = sqlite3_column_int(sqlLiteStatement, colIndex++);

    return [[PoopType alloc] initWith: id desc: desc deleted: deleted];
}

- (NSObject*) processPoopEntry: (id) statement
{
    SqlLite3Statement* statementObject = (SqlLite3Statement*) statement;
    sqlite3_stmt* sqlLiteStatement = statementObject.statement;

    int colIndex = 0 ;
    int id = sqlite3_column_int(sqlLiteStatement, colIndex++);
    int type = sqlite3_column_int(sqlLiteStatement, colIndex++);
    int date = sqlite3_column_int(sqlLiteStatement, colIndex++);

    // time
    colIndex++;

    const char* value = (const char*)sqlite3_column_text(sqlLiteStatement, colIndex++);
    NSString* comment = [[NSString alloc] initWithUTF8String: value] ;

    int deleted = sqlite3_column_int(sqlLiteStatement, colIndex++);

    return [[PoopEntry alloc] initWith: id type: type date: date time: [NSDate date] comment: comment deleted: deleted];
}
@end