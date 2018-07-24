//
//  RequestGetUserDetail.swift
//  Demonstration
//
//  Created by wyj on 2018/5/23.
//  Copyright © 2018年 Alex. All rights reserved.
//

import UIKit

class RequestGetUserDetail: RequestBaseEntity {
    var sUserId:String!
    
    func setUserId(sId:String) -> Void {
        self.sUserId = sId;
        var tempURL:String = "https://api.github.com/users/";
        tempURL += sId
        super.sURL = tempURL
        //print(super.sURL)
    }
}
