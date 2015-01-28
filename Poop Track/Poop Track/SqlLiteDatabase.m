//
// Created by Raj Sathi on 1/27/15.
// Copyright (c) 2015 RajSathi. All rights reserved.
//

#import "SqlLiteDatabase.h"


#define LOG_SQL_LITE_ERRORS 1
@implementation SqlLiteDatabase
{

}

- (id) initWithDatabaseFileName: (NSString*) databaseFileName
{
    if (self = [super init])
    {
        int result = sqlite3_open([databaseFileName UTF8String], &database_);
        if (result != SQLITE_OK)
        {
            #if LOG_SQL_LITE_ERRORS
                NSLog(@"Sql: Failed to open file");
            #endif
        }
    }

    return self;
}

-(BOOL) beginTransaction
{
    return [self executeSql: @"BEGIN TRANSACTION"];
}

-(void) rollbackTransaction
{
    [self executeSql: @"ROLLBACK TRANSACTION"];
}

-(BOOL) commitTransaction
{
    return [self executeSql: @"COMMIT TRANSACTION"];
}

- (sqlite3_stmt*) getStatement:(NSString*) sqlString
{
    sqlite3_stmt* statement;
    int result = sqlite3_prepare_v2(database_, [sqlString UTF8String], -1,  &statement, NULL);
    if (result != SQLITE_OK)
    {
        #if LOG_SQL_LITE_ERRORS
            NSLog(@"Sql: Failed to create a statement from the string: %@", sqlString);
        #endif

        return nil;
    }

    return statement;
}

-(BOOL) executeSql: (NSString*) sql
{
    int result = sqlite3_exec( database_, [sql UTF8String], NULL, NULL, NULL ) ;
    if (result != SQLITE_OK)
    {
        #if LOG_SQL_LITE_ERRORS
            const char* errorText = database_ != NULL ? sqlite3_errmsg(database_) : NULL ;
            NSString* errorString = errorText != NULL ? [NSString stringWithUTF8String: errorText] : @"Unknown sqllite error";
            NSLog(@"SQL ERROR: %@", errorString);
        #endif

        return NO ;
    }

    return YES ;
}

- (BOOL) executeStatement: (sqlite3_stmt*) statement
{
    if (sqlite3_get_autocommit(database_) == 1)
    {
        #if LOG_SQL_LITE_ERRORS
            NSLog(@"Sql executed without a transaction");
        #endif
        return NO;
    }

    int result = sqlite3_step(statement);
    if (result != SQLITE_DONE)
        return NO;

    return YES;
}

- (NSArray*) executeStatement: (sqlite3_stmt*) statement processorTarget: (id) target processorSelector: (SEL) processor
{
    if (sqlite3_get_autocommit(database_) == 1)
    {
        #if LOG_SQL_LITE_ERRORS
            NSLog(@"Sql executed without a transaction");
        #endif
        return nil;
    }

    NSMutableArray* results = [NSMutableArray array];
    int result = SQLITE_OK;
    while ((result = sqlite3_step(statement)) != SQLITE_DONE)
    {
        if (result != SQLITE_ROW)
            return nil;

        NSObject* rowResult = [target performSelector: processor withObject: (__bridge id)statement];
        if (!rowResult)
            return nil;

        [results addObject: rowResult];
    }

    return results;
}
@end