//
//  DBhelper.m
//  ToDoList
//
//  Created by Alex on 05/09/2012.
//  Copyright 2012 company. All rights reserved.
//

#import "DBhelper.h"

#import "AppDelegate.h"
#import <CoreData/CoreData.h>
#import "Global.h"

@implementation DBhelper
+(NSMutableArray*)searchBy:(NSString*)ModelEmptyName
{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:ModelEmptyName inManagedObjectContext:context];
    [request setEntity:entityDesc];
    
    NSError* error;
    NSArray* objects = [[NSArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    NSMutableArray* mutableObjects = [[NSMutableArray alloc] initWithArray:objects];
    return mutableObjects;
}
+ (BOOL) isFileExist:(NSString *)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    NSString *filePath = [path stringByAppendingFormat:@"%@",fileName];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    BOOL result = [fileManager fileExistsAtPath:filePath];
    return result;
}
+(NSMutableArray*)searchWithFetch:(NSString*)fetchName withKeys:(NSDictionary*)subs
{
	NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
	NSFetchRequest *request = [[AppDelegateEntity managedObjectModel] fetchRequestFromTemplateWithName:fetchName substitutionVariables:subs];
	NSError* error;
	NSArray* objects = [[NSArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    NSMutableArray* mutableObjects = [[NSMutableArray alloc] initWithArray:objects];
	return mutableObjects;
}

+(NSMutableArray*)searchWithPredicateByEntity:(NSString*)modelEntityName withKeys:(NSPredicate*) predicate
{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:modelEntityName inManagedObjectContext:context];
    [request setEntity:entityDesc];
    [request setPredicate:predicate];
    NSError* error;
    NSArray* objects = [[NSArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    NSMutableArray *resultObjects = [[NSMutableArray alloc] initWithArray:objects];
    return resultObjects;
}
+(NSMutableArray*)searchWithPredicateByEntity:(NSString*)modelEntityName withKeys:(NSPredicate*) predicate Limit:(NSInteger)_limit
{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
	NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:modelEntityName inManagedObjectContext:context];
    [request setEntity:entityDesc];
    [request setPredicate:predicate];
    [request setFetchLimit:_limit];
	NSError* error;
	NSArray* objects = [[NSArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    NSMutableArray *resultObjects = [[NSMutableArray alloc] initWithArray:objects];
    return resultObjects;
}

+(NSMutableArray*)searchWithSortByEntity:(NSString*)modelEntityName withKeys:(NSSortDescriptor*) sort{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
    NSManagedObjectModel   * model = [AppDelegateEntity managedObjectModel];
    NSDictionary *entities = [model entitiesByName];
    NSFetchRequest* fetchRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *entity = [entities objectForKey:modelEntityName];
    [fetchRequest setEntity:entity];
    
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort, nil];
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    NSError *error;
    NSArray *results = [context executeFetchRequest:fetchRequest error:&error];
    
    NSMutableArray *resultObjects = [[NSMutableArray alloc] initWithArray:results];
    return resultObjects;
}

+(NSMutableArray *)searchWithPredicateAndSortByEntity:(NSString*)modelEntityName withKeys:(NSPredicate*) predicate withSorts:(NSSortDescriptor *)sort{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:modelEntityName inManagedObjectContext:context];
    [request setEntity:entityDesc];
    [request setPredicate:predicate];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort, nil];
    [request setSortDescriptors:sortDescriptors];
    NSError* error;
    NSArray* objects = [[NSArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    NSMutableArray *resultObjects = [[NSMutableArray alloc] initWithArray:objects];
    return resultObjects;
}

+(NSMutableArray *)searchWithPredicateAndSortPagingByEntity:(NSString*)modelEntityName withKeys:(NSPredicate*) predicate withSorts:(NSSortDescriptor *)sort withOffset:(NSInteger)iOffset Limit:(NSInteger)_limit{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSEntityDescription* entityDesc = [NSEntityDescription entityForName:modelEntityName inManagedObjectContext:context];
    [request setEntity:entityDesc];
    [request setPredicate:predicate];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sort, nil];
    [request setSortDescriptors:sortDescriptors];
    [request setFetchLimit:_limit];
    [request setFetchOffset:iOffset];
    NSError* error;
    NSArray* objects = [[NSArray alloc] initWithArray:[context executeFetchRequest:request error:&error]];
    NSMutableArray *resultObjects = [[NSMutableArray alloc] initWithArray:objects];
    return resultObjects;
}

+(void)deleteBy:(id)obj
{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
	
	[context deleteObject:obj];
	
	NSError* error = nil;
	if (![context save:&error])
	{
#ifdef TC_HTTP_DEBUG
		NSLog(@"delete error %@, %@", error, [error userInfo]);
#endif
	}
}

+(void)deleteWithOutSaveBy:(id)obj
{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
	
	[context deleteObject:obj];
}

+(id)insertWithEntity:(NSString*)ModelEntityName
{
    NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
    id obj = [NSEntityDescription insertNewObjectForEntityForName:ModelEntityName inManagedObjectContext:context];
	return obj;
}

+(Boolean)Save
{
	NSManagedObjectContext* context = [AppDelegateEntity managedObjectContext];
	
	NSError* error = nil;
	
	if (![context save:&error])
	{
#ifdef TC_HTTP_DEBUG
        NSLog(@"insert error %@, %@", error, [error userInfo]);
#endif
		return NO;
	}
	return YES;
}



@end
