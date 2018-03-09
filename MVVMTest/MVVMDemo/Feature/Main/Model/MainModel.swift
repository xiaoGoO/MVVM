//
//  MainModel.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/6.
//  Copyright © 2018年 关伟洪. All rights reserved.
//

import Foundation

class MainModel: NSObject {
    
    required init(name:String?,age:Int?,info:String?) {
        super.init();
        self.name = name;
        self.age = age;
        self.info = info;
    }
    
    public var name:String?
    public var age:Int?
    public var info:String?
}
