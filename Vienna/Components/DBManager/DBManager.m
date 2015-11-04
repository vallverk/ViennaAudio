//
//  DBManager.m
//  SqliteTest
//
//  Created by Richard on 15/8/22.
//  Copyright (c) 2015年 Richard. All rights reserved.
//

#import "DBManager.h"

@interface DBManager()

@property (nonatomic) NSString *documentDirectory;
@property (nonatomic) NSString *databaseFilename;

@property (nonatomic) NSMutableArray *arrResults;

-(void)copyDatabaseIntoDocumentsDirectory;
-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable;

@end

@implementation DBManager

-(instancetype)initWithDatabaseFilename:(NSString *)dbFilename{
    
    self = [super init];
    if (self) {
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        self.documentDirectory = [paths objectAtIndex:0];
        
        self.databaseFilename = dbFilename;
        
        [self copyDatabaseIntoDocumentsDirectory];
        
    }
    return self;
}

-(void)copyDatabaseIntoDocumentsDirectory{
    // 检查 document directory 中是否已经存在数据库文件
    NSString *destinationPath = [self.documentDirectory stringByAppendingPathComponent:self.databaseFilename];
    if (![[NSFileManager defaultManager] fileExistsAtPath:destinationPath]) {
        //不存在，所以从 bundle 中拷贝一份过来。
        
        NSString *sourcePath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseFilename];
        NSError *error;
        [[NSFileManager defaultManager] copyItemAtPath:sourcePath toPath:destinationPath error:&error];
        
        // 检查是否有 error 发生
        if (error != nil) {
            NSLog(@"%@",[error localizedDescription]);
            
        }
    }
}

-(void)runQuery:(const char *)query isQueryExecutable:(BOOL)queryExecutable{
    // 创建 SQLite 对象
    sqlite3 *sqlite3Database;
    
    // 设置 数据库文件路径
    NSString *databasePath = [self.documentDirectory stringByAppendingPathComponent:self.databaseFilename];
    
    if (self.arrResults != nil) {
        [self.arrResults removeAllObjects];
        self.arrResults = nil;
    }
    self.arrResults = [[NSMutableArray alloc] init];
    
    if (self.arrColumnNames != nil) {
        [self.arrColumnNames removeAllObjects];
        self.arrColumnNames = nil;
    }
    self.arrColumnNames = [[NSMutableArray alloc] init];
    
    
    // 打开数据库
    BOOL openDatabaseResult = sqlite3_open([databasePath UTF8String], &sqlite3Database);
    if(openDatabaseResult == SQLITE_OK) {

        sqlite3_stmt *compiledStatement;
        
        // 将所有数据有数据库加载到内存中
        BOOL prepareStatementResult = sqlite3_prepare_v2(sqlite3Database, query, -1, &compiledStatement, NULL);
        if(prepareStatementResult == SQLITE_OK) {

            if (!queryExecutable){
                
                // 声明用来存储数据的数组
                NSMutableArray *arrDataRow;
                
                while(sqlite3_step(compiledStatement) == SQLITE_ROW) {

                    arrDataRow = [[NSMutableArray alloc] init];
                    

                    int totalColumns = sqlite3_column_count(compiledStatement);
                    

                    for (int i=0; i<totalColumns; i++){

                        char *dbDataAsChars = (char *)sqlite3_column_text(compiledStatement, i);
                        

                        if (dbDataAsChars != NULL) {

                            [arrDataRow addObject:[NSString  stringWithUTF8String:dbDataAsChars]];
                        }
                        

                        if (self.arrColumnNames.count != totalColumns) {
                            dbDataAsChars = (char *)sqlite3_column_name(compiledStatement, i);
                            [self.arrColumnNames addObject:[NSString stringWithUTF8String:dbDataAsChars]];
                        }
                    }
                    

                    if (arrDataRow.count > 0) {
                        [self.arrResults addObject:arrDataRow];
                    }
                }
            }
            else {

                int executeQueryResults = sqlite3_step(compiledStatement);
                if (executeQueryResults == SQLITE_DONE) {

                    self.affectedRows = sqlite3_changes(sqlite3Database);
                    

                    self.lastInsertedRowID = sqlite3_last_insert_rowid(sqlite3Database);
                }
                else {

                    NSLog(@"DB Error: %s", sqlite3_errmsg(sqlite3Database));
                }
            }
        }
        else {

            NSLog(@"%s", sqlite3_errmsg(sqlite3Database));
        }
        
        // Release the compiled statement from memory.
        sqlite3_finalize(compiledStatement);
        
    }
    
    // Close the database.
    sqlite3_close(sqlite3Database);
}

-(NSArray *)loadDataFromDB:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:NO];
    NSMutableArray*arrAnswer = [[NSMutableArray alloc] init];
    for (NSMutableArray*arr in self.arrResults)
    {
        NSMutableDictionary*dict = [[NSMutableDictionary alloc] init];
        int i = 0;
        for (NSString*s in arr) {
            [dict setObject:s forKey:[self.arrColumnNames objectAtIndex:i]];
            i++;
        }
        [arrAnswer addObject:dict];
    }
    return arrAnswer;
    
}

-(void)executeQuery:(NSString *)query{
    [self runQuery:[query UTF8String] isQueryExecutable:YES];
}

































@end
