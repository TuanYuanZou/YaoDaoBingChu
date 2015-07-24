//
//  YDToll.m
//  YaoDaoBingChu
//
//  Created by lanou3g on 15/7/23.
//  Copyright (c) 2015年 zlwz. All rights reserved.
//

#import "YDToll.h"
#import "FMDB.h"
@implementation YDToll
static FMDatabase *_db;

+ (void)initialize {
   //打开数据库
    NSString *file = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"tool.sqlite"];
    _db = [FMDatabase databaseWithPath:file];
    if (![_db open]) return;
    
    //创表
    /**
     *  表 id
     *
     *  模型
     *
     *  模型 id
     *
     */
    [_db executeUpdate:@"CREATE IF NOT EXISTS TABLE t_collect(id integer PRIMARY KEY, model blob NOT NULL, _id integer NOT NUlL)"];
}



/**
 *  返回第page业的收藏模型数据 : page从1开始
 */
+ (NSArray *)collectModel:(int)page {
    int size = 20; //每次取的个数
    int pos = (page - 1) * size;
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT * FROM t_collect ORDER BY id DESC LIMTIT %d,%d",pos, size];
    
    NSMutableArray *models = [NSMutableArray array];
    while (set.next) {
        YDInstructionsModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:[set objectForColumnName:@"model"]];
        
        [models addObject:model];
    }
   
    return models;
}

/**
 *  收藏
 */
+ (void)addCollectModel:(YDInstructionsModel *)model {
    NSData *data = [NSKeyedArchiver archivedDataWithRootObject:model];
    [_db executeUpdateWithFormat:@"INSERT INTO t_collect(model, _id) VALUES(%@, %ld);",data, model._id];
}

/**
 *  取消收藏
 */
+ (void)removeCollectModel:(YDInstructionsModel *)model {
    [_db executeUpdateWithFormat:@"DELETE FROM t_collect WHERW _id = %ld",model._id];
}

/**
 *  * 代表全部, count(*) 算有多少个
 */
+ (BOOL)isCollected:(NSString *)model_id {
    // 指定字段, 通过字段查找个数
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS model.count FROM t_collect WHERE _id = %@",model_id]; //查询_id的个数, 返回就一列
    
    [set next]; //要先调一下next,才能指向要查询的那条数据, 因为count一定会返回数据,没有数据也是返回0
    
    return [set intForColumn:@"model.count"] == 1; //索引从1开始
}

+ (int)collectCount {
    FMResultSet *set = [_db executeQueryWithFormat:@"SELECT count(*) AS model_count FROM t_collect"];
    [set next];
    return [set intForColumn:@"model_count"];
}
@end
