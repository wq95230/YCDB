//
//  DBManager.h
//  OneCarBeauty
//
//  Created by 刘剑锋 on 2022/3/23.
//

#import <Foundation/Foundation.h>
#import <WCDB/WCDB.h>

NS_ASSUME_NONNULL_BEGIN

@protocol DBManagerDelegate <NSObject>

@required //必须实现的方法

//便利构造器
+ (instancetype)shareManager;

@optional

/// 不能纯数字 创建具体的表  如果Model增加了字段 调用这个会自动在表中添加相应的字段，如果删除字段，表中会遗留字段，已经存在表不会继续创建 不用判断表是否存在
/// @param tableName     表名 <<  不能纯数字  >>
/// @param modelClass   对应的model的类
- (BOOL)createTableWithName:(NSString *)tableName
                 modelClass:(Class)modelClass;

#pragma mark
#pragma mark  --  插入数据

/// 判断表格是否存在
/// @param tableName tableName description
- (BOOL)checkTableisExists:(NSString *)tableName;

- (BOOL)deleteTableWithName:(NSString *)tableName;

/// 在某个表里，插入（已经存在该数据，就更新)单个数据
/// @param object        需要插入的数据
- (BOOL)insertOrUpdataWithName:(NSString *)tableName
                        Object:(WCTObject *)object;

/// 插入或更新数组
/// @param tableName tableName description
/// @param objects objects description
- (BOOL)insertOrUpdatasWithName:(NSString *)tableName
                        Objects:(NSArray<WCTObject *>*)objects;

#pragma mark
#pragma mark  --  查询数据
/// 根据条件查找数据
/// @param tableName 表名
/// @param where 条件
/// @param modelClass 对应的model类
- (NSArray *)getObjectWithName:(NSString *)tableName
                    where:(const WCTCondition &)where
               modelClass:(Class)modelClass;

/// 获取全部表内容
/// @param tableName tableName description
/// @param modelClass modelClass description
- (NSArray *)getAllObjectWithName:(NSString *)tableName
                       modelClass:(Class)modelClass;

/// 获取指定条数内容
/// @param tableName tableName description
/// @param modelClass modelClass description
/// @param limit limit description
/// @param order limit description
- (NSArray *)getObjectsWithName:(NSString *)tableName
                  modelClass:(Class)modelClass
                          limit:(const WCTLimit &)limit
                        orderBy:(const WCTOrderByList &)order;

/// 根据条件获取全部表内容
/// @param tableName tableName description
/// @param modelClass modelClass description
- (NSArray *)getObjectWithName:(NSString *)tableName
                  modelClass:(Class)modelClass
                       orderBy:(const WCTOrderByList &)order;

/// 判断表中是否存在某个数据
/// @param tableName tableName description
/// @param modelClass modelClass description
/// @param where where description
- (BOOL)isExiswithTableName:(NSString *)tableName
                 modelClass:(Class)modelClass
                      where:(const WCTCondition &)where;

/// 根据条件获取排序获取相关内容
/// @param tableName tableName description
/// @param modelClass modelClass description
- (NSArray *)getObjectWithName:(NSString *)tableName
                         where:(const WCTCondition &)where
                       orderBy:(const WCTOrderByList &)order
                    modelClass:(Class)modelClass;

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
                          limit:(const WCTLimit &)limit;

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
                       where:(const WCTCondition &)where;

/// 更新某个属性值
/// @param tableName tableName description
/// @param property property description
/// @param value value description
- (BOOL)UpdataAllPropertiesWithName:(NSString *)tableName
                       onProperties:(const WCTProperty &)property
                              value:(WCTValue *)value;
#pragma mark
#pragma mark  --  删除方法

/// 删除表格
/// @param tableName tableName description
- (BOOL)dropTablewithName:(NSString *)tableName;

/// 删除表格所有数据
/// @param tableName tableName description
- (BOOL)deleteAllobjcetWithName:(NSString *)tableName;

/// 删除数据
/// @param tableName tableName description
/// @param where where description
- (BOOL)deleteObjcetWithName:(NSString *)tableName
                       where:(const WCTCondition &)where;

//- (ConversionModel *)getMultiObjecttableOne:(NSString *)converId;

/// 单例销毁数据 不能清空内存
+ (void)disDestory;

@end

@interface DBManager : NSObject

@property(nonatomic, strong) WCTDatabase *database;


@end

NS_ASSUME_NONNULL_END
