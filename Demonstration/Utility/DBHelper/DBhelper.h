//
//  DBhelper.h
//  ToDoList
//
//  Created by Alex on 05/09/2012.
//  Copyright 2012 company. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface DBhelper : NSObject {
 
}

/*********************************************************
 函数名称：searchBy
 函数描述：根据ModelName查询记录
 输入参数：ModelEmptyName :数据库表名
 输出参数：查询结果
 返回值：NSMutableArray
 **********************************************************/
+(NSMutableArray*)searchBy:(NSString*)ModelEmptyName;
/*********************************************************
 函数名称：searchBywithEntity
 函数描述：根据FetchRequest名和查询条件查询符合条件的记录
 输入参数：ModelEmptyName：FetchRequest名  subs：查询条件(需要查询的字段作key，值作value)
 输出参数：查询结果
 返回值：NSMutableArray
 **********************************************************/
+(NSMutableArray*)searchWithFetch:(NSString*)fetchName withKeys:(NSDictionary*)subs;
/*********************************************************
 函数名称：searchWithPredicateByEntity
 函数描述：自定义二级查询
 输入参数：modelEntityName：Entity名  predicate：查询条件(NSPredicate对象)
 输出参数：查询结果
 返回值：NSMutableArray
 **********************************************************/
+(NSMutableArray*)searchWithPredicateByEntity:(NSString*)modelEntityName withKeys:(NSPredicate*) predicate;
/*********************************************************
 函数名称：searchWithPredicateByEntity
 函数描述：自定义二级查询
 输入参数：modelEntityName：Entity名  predicate：查询条件(NSPredicate对象) Limit:显示数量
 输出参数：查询结果
 返回值：NSMutableArray
 **********************************************************/
+(NSMutableArray*)searchWithPredicateByEntity:(NSString*)modelEntityName withKeys:(NSPredicate*) predicate Limit:(NSInteger)_limit;
/*********************************************************
 函数名称：searchWithSortByEntity
 函数描述：自定义排序
 输入参数：modelEntityName：Entity名  sort：排序条件(NSSortDescriptor对象)
 输出参数：查询结果
 返回值：NSMutableArray
 **********************************************************/
+(NSMutableArray*)searchWithSortByEntity:(NSString*)modelEntityName withKeys:(NSSortDescriptor*) sort;
/*********************************************************
 函数名称：searchWithPredicateAndSortByEntity
 函数描述：自定义条件排序
 输入参数：modelEntityName：Entity名  sort：排序条件(NSSortDescriptor对象)
 输出参数：查询结果
 返回值：NSMutableArray
 **********************************************************/
+(NSMutableArray *)searchWithPredicateAndSortByEntity:(NSString*)modelEntityName withKeys:(NSPredicate*) predicate withSorts:(NSSortDescriptor *)sort;
/*********************************************************
 函数名称：searchWithPredicateAndSortPagingByEntity
 函数描述：自定义条件排序加分页
 输入参数：modelEntityName：Entity名  sort：排序条件(NSSortDescriptor对象)
 输出参数：查询结果
 返回值：NSMutableArray
 **********************************************************/
+(NSMutableArray *)searchWithPredicateAndSortPagingByEntity:(NSString*)modelEntityName withKeys:(NSPredicate*) predicate withSorts:(NSSortDescriptor *)sort withOffset:(NSInteger)iOffset Limit:(NSInteger)_limit;
/*********************************************************
 函数名称：deleteBy
 函数描述：删除数据库记录
 输入参数：obj:需要删除的数据库记录
 输出参数：无
 返回值：void
 **********************************************************/
+(void)deleteBy:(id)obj;
/*********************************************************
 函数名称：deleteWithOutSaveBy
 函数描述：删除数据库记录，不保存注意下保存
 输入参数：obj:需要删除的数据库记录
 输出参数：无
 返回值：void
 **********************************************************/
+(void)deleteWithOutSaveBy:(id)obj;
/*********************************************************
 函数名称：insertWithEntity
 函数描述：根据Model名称获得一个数据库实例对象
 输入参数：ModelEmptyName:数据库表名
 输出参数：数据库实例对象
 返回值：id
 **********************************************************/
+(id)insertWithEntity:(NSString*)ModelEntityName;

+(Boolean)Save;
@end
