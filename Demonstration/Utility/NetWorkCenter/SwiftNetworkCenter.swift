//
//  SwiftNetworkCenter.swift
//  Demonstration
//
//  Created by wyj on 2018/5/24.
//  Copyright © 2018年 Alex. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

//无参无返回值
typealias funcBlock = () -> () //或者 () -> Void
//返回值是String
typealias funcBlockA = (Int,Int) -> String
//返回值是一个函数指针，入参为String
typealias funcBlockB = (Int,Int) -> (String)->()
//返回值是一个函数指针，入参为String 返回值也是String
typealias funcBlockC = (Int,Int) -> (String)->String

typealias requestSuccess = (NSObject) -> ()
typealias requestFail = (NSError) -> ()

class RequestBaseEntity: NSObject {
    var sURL:String = ""
    
    func startRequestWithBlock(successBlock:@escaping requestSuccess,failBlock:@escaping requestFail) -> Void {
        SwiftNetworkCenter.startRequest(requestObj:self, successBlock: successBlock, failBlock: failBlock)
    }
}

class ResponseBaseEntity: NSObject {
    
    func keyValueCode(item:Dictionary<AnyHashable,Any>) -> Void {
        for sKey in item.keys {
            self.setValue(item[sKey], forKey: sKey as! String)
        }
    }
}

class SwiftNetworkCenter: NSObject {
    
    static func startRequest(requestObj:RequestBaseEntity, successBlock:@escaping requestSuccess, failBlock:@escaping requestFail) -> Void {
        Alamofire.request(requestObj.sURL).responseJSON { (response) in
            let dataResponse:DataResponse = response as DataResponse
            if dataResponse.result.isSuccess {
                //success
                let response = SwiftNetworkCenter.createResponseFromJson(request: requestObj,responseJSON: JSON(dataResponse.result.value!))

                successBlock(response)
            } else {
                //fail
                
                
            }
            
            }.responseString { (strResponse) in
                //check stream
                print(strResponse.result.value ?? "Default")
                //check error
                print(strResponse.result.error ?? "Default")
        }

    }
    
    static func createResponseFromJson(request:RequestBaseEntity, responseJSON:JSON) -> NSObject {
        
        if request is RequestGetUserList {
            let userList:ResponseGetUserList = ResponseGetUserList(json: responseJSON)
            return userList
        }
        else if request is RequestGetUserDetail {
            let userDetail:ResponseGetUserDetail = ResponseGetUserDetail(json: responseJSON)
            return userDetail
        }
        else {
            return NSNull.init()
        }
    }
    
//    static func getResponseFromJson(request:RequestBaseEntity, responseJSON:JSON) -> NSObject {
//        let typeName = type(of: request)
//        //Get request class name
//        let requestClassName:String = typeName.description()
//        //Create response class name
//        let responseCalssName = requestClassName.replacingOccurrences(of: "Request", with: "Response")
//
//        //Create response object
//        let responseType = NSClassFromString(responseCalssName) as! NSObject.Type
//        let responseObj = responseType.init()
//
//        return responseObj
//    }
    
    
}
