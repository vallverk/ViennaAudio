//
//  DBManager.h
//  SqliteTest
//
//  Created by Richard on 15/8/22.
//  Copyright (c) 2015年 Richard. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>

@interface DBManager : NSObject

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename;

@property (nonatomic) NSMutableArray *arrColumnNames;
@property (nonatomic) int affectedRows;
@property (nonatomic) long long lastInsertedRowID;

-(void)executeQuery:(NSString *)query;
-(NSArray *)loadDataFromDB:(NSString *)query;


@end
