//
//  NetworkCenter.h
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"


//Success Callback
typedef void (^HttpSuccess)(NSObject *json);
//Fail Callback
typedef void (^HttpFailure)(NSError *error);

//Request Base Class
@interface BaseRequest : NSObject

@property (nonatomic,strong) NSString *sURL;

-(void)startRequestWithBlock:(HttpSuccess)successBlack Fail:(HttpFailure)failBlack;
-(void)startRequest:(HttpSuccess)successBlack;

@end

@interface NetworkCenter : NSObject

+ (void)postRequestWithEntity:(BaseRequest *)entity success:(HttpSuccess)success fail:(HttpFailure)fail;

+ (NSMutableDictionary *)objectToDictionary:(id)obj;
+ (NSMutableArray *)arrayWithObject:(id)obj;
@end
