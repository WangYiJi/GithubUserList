//
//  ResponseGetUserList.swift
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserListItem: ResponseBaseEntity {
    var login:String = ""
    var id:NSNumber!
    var avatar_url:String = ""
    var gravatar_id:String = ""
    var url:String = ""
    var html_url:String = ""
    var followers_url:String = ""
    var following_url:String = ""
    var gists_url:String = ""
    var starred_url:String = ""
    var subscriptions_url:String = ""
    var organizations_url:String = ""
    var repos_url:String = ""
    var events_url:String = ""
    var received_events_url:String = ""
    var type:String = ""
    var site_admin:NSNumber!
    var node_id:String = ""
}

class ResponseGetUserList: NSObject {
    var userList:NSMutableArray!
    
    
    init(json:JSON) {
        super.init()
        self.userList = NSMutableArray();

        for (index,subJson):(String, JSON) in json {
            print(index)
            
            let userItem:UserListItem = UserListItem()
            
            for (key,value):(String, JSON) in subJson {
                switch value.type {
                case .string:
                    userItem.setValue(value.stringValue, forKey: key)
                    break;
                case .number:
                    userItem.setValue(value.number, forKey: key)
                    break;
                default:
                    break;
                }
            }
            self.userList.add(userItem)
        }
    }
}
