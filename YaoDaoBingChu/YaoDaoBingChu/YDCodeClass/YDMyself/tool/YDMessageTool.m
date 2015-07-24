
//
//  YDMessageTool.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/22.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDMessageTool.h"
#import "YDEmotionPlaceholderTextView.h"
#import "YDMessagePhonesView.h"
#import "YDMessage.h"
#import <sqlite3.h>

@interface YDMessageTool ()

//  数据库实例
@property(nonatomic,assign)sqlite3 * db ;

@end

@implementation YDMessageTool

//  1.插入数据
- (void)insertDataWithEmotionPlaceholderTextView:(YDEmotionPlaceholderTextView *)emotionPlaceholderTextView messagePhonesView:(YDMessagePhonesView *)messagePhonesView
{
    //  打开数据库
    [self openDB] ;
    
    //  1.创建SQL语句
    NSString * sqlStr = [NSString stringWithFormat:@"INSERT INTO t_message(message,author,image) VALUEs(?,?,?) ;"] ;
    //  2.创建指令集
    sqlite3_stmt * stmt = nil ;
    //  3.创建语句对象
    NSInteger flag = sqlite3_prepare_v2(_db, sqlStr.UTF8String, -1, &stmt, nil) ;
    
    if (flag == SQLITE_OK) {
        //  5.绑定
        NSString * fullText = emotionPlaceholderTextView.fullText ;
        sqlite3_bind_text(stmt, 1, fullText.UTF8String, -1, nil) ;
        sqlite3_bind_text(stmt, 2, "小圆子", -1, nil) ;
        UIImage * image = [messagePhonesView.phones  firstObject] ;
        NSData * imageData = UIImagePNGRepresentation(image) ;
        sqlite3_bind_blob(stmt, 3, imageData.bytes, (int)(imageData.length), nil);
        //  6.执行指令集
        sqlite3_step(stmt);
        //  7.释放指令集
        sqlite3_finalize(stmt) ;
        NSLog(@"插入数据成功");
    }
}

//  2.取出全部数据
- (NSArray *)messages
{
    //  1.打开数据库
    [self openDB] ;
    //  2.创建指令集
    sqlite3_stmt * stmt  = nil;
    //  3.创建SQL语句
    NSString * sqlString = [NSString stringWithFormat:@"select * from t_message"];
    
    //  4.创建语句对象
    NSInteger flag = sqlite3_prepare_v2(_db, [sqlString UTF8String], -1, &stmt, nil);
    //  创建一个 装 model 的数组
    NSMutableArray * messageArray = [NSMutableArray array] ;
    //  如果SQL语句正确 则执行
    if (flag == SQLITE_OK)
    {
        while (SQLITE_ROW == sqlite3_step(stmt))
        {
            YDMessage * message = [[YDMessage alloc]init] ;
            //  每一行的第 0 列   ID
            NSInteger ID = sqlite3_column_int(stmt, 0) ;
            //  每一行的第 1 列   messageContect
            const unsigned char * messageContect = sqlite3_column_text(stmt, 1) ;
            //  每一行的第 2 列   messageAuthor
            const unsigned char * messageAuthor = sqlite3_column_text(stmt, 2) ;
            //  每一行的第 3 列   image
            NSData * imageData = [NSData dataWithBytes:sqlite3_column_blob(stmt, 3) length:sqlite3_column_bytes(stmt, 3)] ;
            
            //  把取出来的值 赋值 给 model的属性
            message.ID = ID ;
            message.message = [NSString stringWithUTF8String:(const char *)messageContect] ;
            message.author = [NSString stringWithUTF8String:(const char *)messageAuthor] ;
            message.image = [UIImage imageWithData:imageData] ;
            //NSLog(@"%@---------%@-------%@",message.message,message.author,message.image);
            [messageArray addObject:message] ;
        }
        NSLog(@"读取数据成功");
    }
    
    
    //  释放指令集
    sqlite3_finalize(stmt) ;
    
    return messageArray ;
}

//   3.取出数据的全部ID
- (NSArray *)messageIDs
{
    //  1.打开数据库
    [self openDB] ;
    //  2.创建指令集
    sqlite3_stmt * stmt  = nil;
    //  3.创建SQL语句
    NSString * sqlString = [NSString stringWithFormat:@"select ID from t_message"];
    //  4.创建语句对象
    NSInteger flag = sqlite3_prepare_v2(_db, [sqlString UTF8String], -1, &stmt, nil);
    //  创建一个 装 ID 的数组
    NSMutableArray * IDs = [NSMutableArray array] ;
    //  如果SQL语句正确 则执行
    if (flag == SQLITE_OK)
    {
        while (SQLITE_ROW == sqlite3_step(stmt))
        {
            //  每一行的第 0 列   ID
            NSInteger ID = sqlite3_column_int(stmt, 0) ;
            [IDs addObject:@(ID)] ;
        }
        NSLog(@"读取数据成功");
    }
    //  释放指令集
    sqlite3_finalize(stmt) ;
    return IDs ;
}

//  根据ID查询某一人
- (YDMessage *)messagelWithID:(NSInteger)ID
{
    //  1.打开数据库
    [self openDB] ;
    //  2.创建指令集
    sqlite3_stmt * stmt = nil;
    //  3.创建 SQL语句
    NSString * sqlString = [NSString stringWithFormat:@"select * from t_message  where ID = ?"];
    //  4.创建 语句对象
    NSInteger flag = sqlite3_prepare_v2(_db, [sqlString UTF8String], -1, &stmt, nil) ;
    YDMessage * message = [[YDMessage alloc]init] ;
    
    //  如果SQL语句正确
    if (flag == SQLITE_OK)    {
        //  5.为SQL语句中的 ？ 绑定内容
        sqlite3_bind_int(stmt, 1, (int)ID) ;
        //  6.执行SQL 语句
        while (SQLITE_ROW == sqlite3_step(stmt))
        {
            //  第 0 列   ID
            NSInteger ID = sqlite3_column_int(stmt, 0) ;
            //  第 1 列   messageContect
            const unsigned char * messageContect = sqlite3_column_text(stmt, 1) ;
            //  第 2 列   messageAuthor
            const unsigned char * messageAuthor = sqlite3_column_text(stmt, 2) ;
            //  第 3 列   image
            NSData * imageData = [NSData dataWithBytes:sqlite3_column_blob(stmt, 3) length:sqlite3_column_bytes(stmt, 3)] ;
            
            message.ID = ID ;
            message.message = [NSString  stringWithUTF8String:(const char *)messageContect];
            message.author = [NSString  stringWithUTF8String:(const char *)messageAuthor];
            message.image = [UIImage imageWithData:imageData] ;
        }
    }
    return message ;
}





#pragma mark -  连接数据库
- (void)openDB
{
    int linkStatu = sqlite3_open([self domainsPath].UTF8String, &_db) ;
    if (linkStatu == SQLITE_OK) {
        NSLog(@"数据库链接成功");
        //  2.创表
        const char * sqlStr = "CREATE TABLE IF NOT EXISTS t_message(id integer PRIMARY KEY ,message text NOT NULL,author text,image blob) ;" ;
        char * error = nil ;
        sqlite3_exec(_db, sqlStr, nil, nil, &error);
        if (error) {
            NSLog(@"创建表格失败");
            NSLog(@"--%s",error);
        }
    }else{
        NSLog(@"数据库链接失败");
    }
}



#pragma mark - 获得数据库文件路径
- (NSString *)domainsPath
{
    NSString * domainsPath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"message.sqlite"];
    NSLog(@"%@",domainsPath) ;
    return domainsPath ;
}


+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static YDMessageTool * message ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        message = [super allocWithZone:zone] ;
    });
    return message ;
}


+ (instancetype)shareMessageTool
{
    return [[self alloc]init ] ;
}
@end
