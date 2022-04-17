//
//  DBManager.m
//  BaseDemo
//
//  Created by 刘剑锋 on 2022/4/17.
//

#import "DBManager.h"
#import "AGDatabase+Sqlite.h"

@implementation DBManager

+ (BOOL)createTableWithName:(NSString *)tableName modelClass:(Class)modelClass
{
    return [[AGDatabase shareManager]createTableWithName:tableName modelClass:modelClass];
}


#pragma mark
#pragma mark  ———— 🥬🔸🍎  插入数据

/// 判断表格是否存在
/// @param tableName tableName description
+ (BOOL)checkTableisExists:(NSString *)tableName
{
    return [[AGDatabase shareManager] checkTableisExists:tableName];
}

+ (BOOL)deleteTableWithName:(NSString *)tableName
{
    return [[AGDatabase shareManager] deleteTableWithName:tableName];
}

/// 在某个表里，插入（已经存在该数据，就更新)单个数据
/// @param object        需要插入的数据
+ (BOOL)insertOrUpdataWithName:(NSString *)tableName
                        Object:(WCTObject *)object
{
    return [[AGDatabase shareManager] insertOrUpdataWithName:tableName Object:object];
}

/// 插入或更新数组
/// @param tableName tableName description
/// @param objects objects description
+ (BOOL)insertOrUpdatasWithName:(NSString *)tableName
                        Objects:(NSArray<WCTObject *>*)objects
{
    return [[AGDatabase shareManager] insertOrUpdatasWithName:tableName Objects:objects];
}

#pragma mark
#pragma mark  ———— 🥬🔸🍎  查询数据
/// 根据条件查找数据
/// @param tableName 表名
/// @param where 条件
/// @param modelClass 对应的model类
+ (NSArray *)getObjectWithName:(NSString *)tableName
                    where:(const WCTCondition &)where
               modelClass:(Class)modelClass
{
    return [[AGDatabase shareManager] getObjectWithName:tableName where:where modelClass:modelClass];
}

/// 获取全部表内容
/// @param tableName tableName description
/// @param modelClass modelClass description
+ (NSArray *)getAllObjectWithName:(NSString *)tableName
                       modelClass:(Class)modelClass
{
    return [[AGDatabase shareManager] getAllObjectWithName:tableName modelClass:modelClass];
}

/// 获取指定条数内容
/// @param tableName tableName description
/// @param modelClass modelClass description
/// @param limit limit description
/// @param order limit description
+ (NSArray *)getObjectsWithName:(NSString *)tableName
                  modelClass:(Class)modelClass
                          limit:(const WCTLimit &)limit
                        orderBy:(const WCTOrderByList &)order
{
    return [[AGDatabase shareManager] getObjectsWithName:tableName modelClass:modelClass limit:limit orderBy:order];
}

/// 根据条件获取全部表内容
/// @param tableName tableName description
/// @param modelClass modelClass description
+ (NSArray *)getObjectWithName:(NSString *)tableName
                  modelClass:(Class)modelClass
                       orderBy:(const WCTOrderByList &)order
{
    return [[AGDatabase shareManager] getObjectWithName:tableName modelClass:modelClass orderBy:order];
}

/// 判断表中是否存在某个数据
/// @param tableName tableName description
/// @param modelClass modelClass description
/// @param where where description
+ (BOOL)isExiswithTableName:(NSString *)tableName
                 modelClass:(Class)modelClass
                      where:(const WCTCondition &)where
{
    return [[AGDatabase shareManager] isExiswithTableName:tableName modelClass:modelClass where:where];
}

/// 根据条件获取排序获取相关内容
/// @param tableName tableName description
/// @param modelClass modelClass description
+ (NSArray *)getObjectWithName:(NSString *)tableName
                         where:(const WCTCondition &)where
                       orderBy:(const WCTOrderByList &)order
                    modelClass:(Class)modelClass
{
    return [[AGDatabase shareManager] getObjectWithName:tableName where:where orderBy:order modelClass:modelClass];;
}

/// 获取指定条数内容 一般翻页查找
/// @param tableName tableName description
/// @param modelClass modelClass description
/// @param where where description
/// @param order order description
/// @param limit limit description
+ (NSArray *)getObjectsWithName:(NSString *)tableName
                     modelClass:(Class)modelClass
                          where:(const WCTCondition &)where
                        orderBy:(const WCTOrderByList &)order
                          limit:(const WCTLimit &)limit
{
    return [[AGDatabase shareManager] getObjectsWithName:tableName
                                              modelClass:modelClass
                                                   where:where
                                                 orderBy:order
                                                   limit:limit];;
}

#pragma mark
#pragma mark  ———— 🥬🔸🍎 更新数据

/// 更新model部分属性
/// @param tableName tableName description
/// @param object object description
/// @param propertyList propertyList description
/// @param where where description
+ (BOOL)UpdataObjectWithName:(NSString *)tableName
                      Object:(WCTObject *)object
                onProperties:(const WCTPropertyList &)propertyList
                       where:(const WCTCondition &)where
{
    return [[AGDatabase shareManager] UpdataObjectWithName:tableName Object:object onProperties:propertyList where:where];
}

/// 更新某个属性值
/// @param tableName tableName description
/// @param property property description
/// @param value value description
+ (BOOL)UpdataAllPropertiesWithName:(NSString *)tableName
                       onProperties:(const WCTProperty &)property
                              value:(WCTValue *)value
{
    return [[AGDatabase shareManager] UpdataAllPropertiesWithName:tableName onProperties:property value:value];
}
#pragma mark
#pragma mark  ———— 🥬🔸🍎  删除数据

/// 删除表格
/// @param tableName tableName description
+ (BOOL)dropTablewithName:(NSString *)tableName
{
    return [[AGDatabase shareManager] dropTablewithName:tableName];
}

/// 删除表格所有数据
/// @param tableName tableName description
+ (BOOL)deleteAllobjcetWithName:(NSString *)tableName
{
    return [[AGDatabase shareManager] deleteAllobjcetWithName:tableName];
}

/// 删除数据
/// @param tableName tableName description
/// @param where where description
+ (BOOL)deleteObjcetWithName:(NSString *)tableName
                       where:(const WCTCondition &)where
{
    return [[AGDatabase shareManager]deleteObjcetWithName:tableName where:where];
}

//- (ConversionModel *)getMultiObjecttableOne:(NSString *)converId;

+ (NSString *)getDatabasePath
{
    return [AGDatabase shareManager].dbPath;
}

/// 单例销毁数据 不能清空内存
+ (void)destory
{
    [AGDatabase destory];
}



@end
