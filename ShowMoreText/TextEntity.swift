//
//  TextEntity.swift
//  ShowMoreText
//
//  Created by juanmao on 15/12/8.
//  Copyright © 2015年 juanmao. All rights reserved.
//

import UIKit

class TextEntity: NSObject {
    var textId:Int!
    var textName:String!
    var textContent:String!
    var isShowText:Bool!
    
    init(dict:NSDictionary){
        super.init()
        self.textId = (dict["textId"]) as? Int
        self.textName = dict["textName"] as? String
        self.textContent = dict["textContent"]as? String
        self.isShowText = false
    }

}
