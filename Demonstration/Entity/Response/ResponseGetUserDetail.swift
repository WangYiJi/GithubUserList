//
//  ResponseGetUserDetail.swift
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

import UIKit
import SwiftyJSON

class ResponseGetUserDetail: ResponseBaseEntity {
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
    var name:String = ""
    var company:String = ""
    var blog:String = ""
    var location:String = ""
    var email:String = ""
    var hireable:String = ""
    var bio:String = ""
    var public_gists:NSNumber!
    var public_repos:NSNumber!
    var followers:NSNumber!
    var following:NSNumber!
    var created_at:NSNumber!
    var updated_at:NSNumber!
    var node_id:String = ""
    
    init(json:JSON) {
        super.init()

        for (key,value):(String, JSON) in json {
            
            print("key"+key)
            switch value.type {
            case .string:
                self.setValue(value.stringValue, forKey: key)
                break;
            case .number:
                
                self.setValue(value.numberValue, forKey: key)
                break;
            default:
                break;
            }
            
        }
        
//        for sKey in (json as! Dictionary<String, Any>).keys {
//            self.setValue(json[sKey], forKey: sKey);
//        }
    }
    
}
