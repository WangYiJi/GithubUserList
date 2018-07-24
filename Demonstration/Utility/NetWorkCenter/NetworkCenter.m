//
//  NetworkCenter.m
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

#import "NetworkCenter.h"
#import <objc/runtime.h>
#import "Demonstration-Swift.h"
#import <CommonCrypto/CommonDigest.h>

@implementation BaseRequest
@synthesize sURL;

-(void)startRequestWithBlock:(HttpSuccess)successBlack Fail:(HttpFailure)failBlack
{
    [NetworkCenter postRequestWithEntity:self success:successBlack fail:failBlack];
}

-(void)startRequest:(HttpSuccess)successBlack
{
    [NetworkCenter postRequestWithEntity:self success:successBlack fail:nil];
}

@end

@implementation NetworkCenter


+ (void)postRequestWithEntity:(BaseRequest *)entity success:(HttpSuccess)success fail:(HttpFailure)fail
{
    //create parament
    //NSMutableDictionary *parameters = [NetworkCenter objectToDictionary:entity];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    [manager GET:entity.sURL parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        if (success) {
            //kvc
            id objFinal = [NetworkCenter getObjectFromJson:responseObject request:entity];
            success(objFinal);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"");
    }];
    
}

+ (NSObject*)getObjectFromJson:(id)responseObject request:(id)requestObj
{
    if ([requestObj isKindOfClass:[RequestGetUserList class]]) {
        ResponseGetUserList *userObj = nil;// [[ResponseGetUserList alloc] initWithJson:responseObject];
        return userObj;
    }
    else if ([requestObj isKindOfClass:[RequestGetUserDetail class]]) {
//        ResponseGetUserDetail *userDetail = [[ResponseGetUserDetail alloc] initWithJson:responseObject];
//
//        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//        //Security check！！！！！！！！！！！！！！！！！！
//        //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
//        RequestGetUserDetail *tempRequest = (RequestGetUserDetail*)requestObj;
//        NSString *sMD5Request = [NetworkCenter md5:tempRequest.sUserId];
//        NSString *sMD5Response = [NetworkCenter md5:userDetail.login];
//        if ([sMD5Request isEqualToString:sMD5Response]) {
//            //success
//            NSLog(@"Pass");
//        } else {
//            //fail
//            NSLog(@"not the same user");
//        }
//
//        return userDetail;
        return nil;
    }
    else {
        return nil;
    }
    
}

+ (NSString *) md5:(NSString *) input {
    
    const char *cStr = [input UTF8String];
    
    unsigned char digest[CC_MD5_DIGEST_LENGTH];
    
    CC_MD5( cStr, (CC_LONG)strlen(cStr), digest ); // This is the md5 call
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_MD5_DIGEST_LENGTH * 2];
    
    
    for(int i = 0; i < CC_MD5_DIGEST_LENGTH; i++)
        
        [output appendFormat:@"%02x", digest[i]];
    
    return  output;
    
}


//runtime
+ (NSMutableDictionary *)objectToDictionary:(id)obj
{
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    Class requestClass = [obj class];
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList(requestClass, &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propName = [NSString stringWithUTF8String:property_getName(property)];
        if ([obj valueForKey:propName]) {
            id item = [obj valueForKey:propName];
            if (item) {
                id value = nil;
                if ([item isKindOfClass:[NSObject class]]) {
                    if ([item isKindOfClass:[NSArray class]]) {
                        value = [NetworkCenter arrayWithObject:item];
                    }
                    else if ([item isKindOfClass:[NSNumber class]] ||
                             [item isKindOfClass:[NSString class]] ||
                             [item isKindOfClass:[NSDictionary class]]) {
                        value = item;
                    }else {
                        value = [NetworkCenter objectToDictionary:item];
                    }
                }
                [dic setValue:value forKey:propName];
            }
            
        }else {
            [dic setValue:@"" forKey:propName];
        }
    }
    return dic;
}

+ (NSMutableArray *)arrayWithObject:(id)obj
{
    NSMutableArray *arrObject = [[NSMutableArray alloc] init];
    if ([obj isKindOfClass:[NSArray class]]) {
        NSMutableArray *arr = (NSMutableArray *)obj;
        for (int i = 0; i < arr.count; i++) {
            id item = [arr objectAtIndex:i];
            NSMutableDictionary *dic = [NetworkCenter objectToDictionary:item];
            [arrObject addObject:dic];
        }
    }
    
    return arrObject;
}

@end
