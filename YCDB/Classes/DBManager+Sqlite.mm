//
//  DBManager+Sqlite.m
//  OneCarBeauty
//
//  Created by 刘剑锋 on 2022/3/23.
//

#import "DBManager+Sqlite.h"

@implementation DBManager (Sqlite)

static dispatch_once_t _onceToken;
static DBManager *_manager = nil;

+ (instancetype)shareManager
{
    dispatch_once(&_onceToken, ^{
        // 要使用self来调用
        _manager = [[self alloc] init];
        [_manager creatDatabase];
    });
    return _manager;
}

//创建数据库
- (BOOL)creatDatabase
{
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    NSString *obectid = @"userid"; //设置用户id作为路径
    NSString *path = [NSString stringWithFormat:@"MerchantDB/%@.sqlite",obectid];
    NSString *dbPath = [documentPath stringByAppendingString:path];
//    NSLog(@"数据库路径:\n%@\n",dbPath)

    self.database = [[WCTDatabase alloc] initWithPath:dbPath];
//    self.database.tag = 0;
    if ([self.database canOpen])
    {
//        NSLog(@"创建数据库成功");
//        NSLog(@"path = %@",dbPath)
    }else{
        NSLog(@"创建数据库失败");
        return NO;
    }
    return YES;
}

-(BOOL)createTableWithName:(NSString *)tableName
                modelClass:(Class)modelClass
{
    //创建表  注：该接口使用的是IF NOT EXISTS的SQL，因此可以用重复调用。不需要在每次调用前判断表或索引是否已经存在。
    BOOL result = [self.database createTableAndIndexesOfName:tableName withClass:modelClass];
    if (!result)
    {
        NSLog(@"创建表失败");
        return NO;
    }
//    NSLog(@"创建表成功");
    return YES;
}

- (BOOL)deleteTableWithName:(NSString *)tableName
{
    BOOL result = [self.database dropTableOfName:tableName];
    return result;
}


/// 判断表格是否存在
/// @param tableName tableName description
- (BOOL)checkTableisExists:(NSString *)tableName
{
    return [self.database isTableExists:tableName];
}

#pragma mark
#pragma mark  --  插入 方法
- (BOOL)insertOrUpdataWithName:(NSString *)tableName Object:(WCTObject *)object
{
    if (!object) {
        NSLog(@"插入内容为空");
        return NO;
    }
    
    BOOL result = [self.database insertOrReplaceObject:object into:tableName];
    //关闭数据库,_database如果能自己释放的话,会自动关闭,就不用手动调用关闭了
    if (!result) {
        NSLog(@"插入失败");
        return NO;
    }else{
//        NSLog(@"插入成功");
        return YES;
    }
}

/// 插入或更新数组
/// @param tableName tableName description
/// @param objects objects description
- (BOOL)insertOrUpdatasWithName:(NSString *)tableName
                        Objects:(NSArray<WCTObject *>*)objects
{
    if (objects.count == 0) {
        NSLog(@"插入的数组内容为空 - %@",tableName);
        return NO;
    }

    BOOL result = [self.database insertOrReplaceObjects:objects into:tableName];
    if (result) {
//        NSLog(@"更新字段成功")
    }else{
        NSLog(@"更新字段失败");
    }
    return result;
}

#pragma mark
#pragma mark  --  查询方法
/// 根据条件获取数据
/// @param tableName 表名
/// @param where where description
/// @param modelClass modelClass description
- (NSArray *)getObjectWithName:(NSString *)tableName
                         where:(const WCTCondition &)where
                    modelClass:(Class)modelClass
{
    NSArray *result = [self.database getObjectsOfClass:modelClass fromTable:tableName where:where];
    return result;
}

/// 获取全部表内容
/// @param tableName tableName description
/// @param modelClass modelClass description
- (NSArray *)getAllObjectWithName:(NSString *)tableName
                  modelClass:(Class)modelClass
{
    NSArray *result = [self.database getAllObjectsOfClass:modelClass fromTable:tableName];
    return result;
}


/// 获取指定条数内容
/// @param tableName tableName description
/// @param modelClass modelClass description
/// @param limit limit description
/// @param order limit description
- (NSArray *)getObjectsWithName:(NSString *)tableName
                  modelClass:(Class)modelClass
                          limit:(const WCTLimit &)limit
                        orderBy:(const WCTOrderByList &)order
{
//    NSArray *result = [self.database getObjectsOfClass:modelClass fromTable:tableName limit:limit];
    NSArray *result = [self.database getObjectsOfClass:modelClass fromTable:tableName orderBy:order limit:limit];
    return result;;
}

/// 获取指定条数内容 一般翻页查找
/// @param tableName tableName description
/// @param modelClass modelClass description
/// @param where where description
/// @param order order description
/// @param limit limit description
- (NSArray *)getObjectsWithName:(NSString *)tableName
                     modelClass:(Class)modelClass
                          where:(const WCTCondition &)where
                        orderBy:(const WCTOrderByList &)order
                          limit:(const WCTLimit &)limit
{
    NSArray *result = [self.database getObjectsOfClass:modelClass fromTable:tableName where:where orderBy:order limit:limit];
    return result;
}


/// 根据条件获取全部表内容
/// @param tableName tableName description
/// @param modelClass modelClass description
- (NSArray *)getObjectWithName:(NSString *)tableName
                  modelClass:(Class)modelClass
                       orderBy:(const WCTOrderByList &)order
{
    NSArray *result = [self.database getObjectsOfClass:modelClass fromTable:tableName orderBy:order];
    return result;
}

/// 根据条件获取排序获取相关内容
/// @param tableName tableName description
/// @param modelClass modelClass description
- (NSArray *)getObjectWithName:(NSString *)tableName
                         where:(const WCTCondition &)where
                       orderBy:(const WCTOrderByList &)order
                    modelClass:(Class)modelClass
{
    NSArray *result = [self.database getObjectsOfClass:modelClass fromTable:tableName where:where orderBy:order];
    return result;
}


/// 判断表中是否存在某个数据
/// @param tableName tableName description
/// @param modelClass modelClass description
/// @param where where description
- (BOOL)isExiswithTableName:(NSString *)tableName
                 modelClass:(Class)modelClass
                      where:(const WCTCondition &)where
{
    id result = [self.database getOneObjectOfClass:modelClass fromTable:tableName where:where];
    if (result) {
        return YES;
    }
    return NO;
}

#pragma mark
#pragma mark  --  更新方法

/// 更新model部分属性
/// @param tableName tableName description
/// @param object object description
/// @param propertyList propertyList description
/// @param where where description
- (BOOL)UpdataObjectWithName:(NSString *)tableName
                      Object:(WCTObject *)object
                onProperties:(const WCTPropertyList &)propertyList
                       where:(const WCTCondition &)where
{
    BOOL result = [self.database updateRowsInTable:tableName onProperties:propertyList withObject:object where:where];
    if (result) {
//        NSLog(@"更新字段成功")
    }else{
        NSLog(@"更新字段失败");
    }
    return result;
}


/// 更新全部属性值
/// @param tableName tableName description
/// @param property property description
/// @param value value description
- (BOOL)UpdataAllPropertiesWithName:(NSString *)tableName
                       onProperties:(const WCTProperty &)property
                              value:(WCTValue *)value
{
    BOOL result = [self.database updateAllRowsInTable:tableName onProperty:property withValue:value];
    if (result) {
//        NSLog(@"更新字段成功")
    }else{
        NSLog(@"更新字段失败");
    }
    return result;
}


#pragma mark  --  删除
- (BOOL)dropTablewithName:(NSString *)tableName
{
    BOOL result = [self.database dropTableOfName:tableName];
    if (!result) {
        NSLog(@"表格删除失败");
    }
    return result;
}

/// 删除表格所有数据
/// @param tableName tableName description
- (BOOL)deleteAllobjcetWithName:(NSString *)tableName
{
    BOOL result = [self.database deleteAllObjectsFromTable:tableName];
    if (result) {
//        NSLog(@"已删除表格所有数据")
    }else{
        NSLog(@"删除表格失败");
    }
    return result;
}

/// 删除数据
/// @param tableName tableName description
/// @param where where description
- (BOOL)deleteObjcetWithName:(NSString *)tableName
                       where:(const WCTCondition &)where
{
    BOOL result = [self.database deleteObjectsFromTable:tableName where:where];
    if (result) {
//        NSLog(@"删除数据成功")
    }else{
        NSLog(@"删除数据失败");
    }
    return result;
}

/*
- (WCTObject *)getMultiObjecttableOne:(NSString *)converId
{
    WCTResultList results =
    {
        ConversionModel.AllProperties.inTable(TabName_ConversionModel),
        FriendModel.AllProperties.inTable(TabName_FriendModel)
    };
    
    WCTMultiSelect *multiSelect = [self.database prepareSelectMultiObjectsOnResults:results fromTables:@[TabName_ConversionModel,TabName_FriendModel]];
    [multiSelect where:ConversionModel.conversationId.inTable(TabName_ConversionModel) == converId && FriendModel.conversationId.inTable(TabName_FriendModel) == converId];
    WCTMultiObject *Mobject;
    while ((Mobject = [multiSelect nextMultiObject]))
    {
        ConversionModel *obj1 = (ConversionModel *)[Mobject objectForKey:TabName_ConversionModel];
        FriendModel *obj2 = (FriendModel *)[Mobject objectForKey:TabName_FriendModel];
        obj1.url = obj2.friendUser.iconFile.url;
        obj1.name = obj2.friendAlias?:obj2.friendUser.nickname;
        return obj1;
    }
    return nil;
}

*/

/*
//联表查询
{
    
}
*/

/// 数据清空
+ (void)disDestory
{
    _onceToken = 0;
    _manager = nil;
}

@end
