//
//  BaseViewModel.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/8.
//  Copyright © 2018年 关伟洪. All rights reserved.
//
/**
 * 数据绑定模型，当数据被改变时可以被监听变化并且回调
 *
 */
import Foundation

class BingModel<T>: NSObject {
    
    public var value:T?{
        didSet{
            if (blocks != nil){
                for block in blocks!{
                    block(value);
                }
            }
        }
    };
    deinit {
        blocks?.removeAll();
        blocks = nil
        value = nil;
    }
    
    
    required convenience init(_ obj:T?) {
        self.init();
        self.value = obj;
    }
    
    private var blocks:[((T?)->Void)]? = [];
    
    public func addChangeCallBack(_ block:@escaping ((T?)->Void)){
        blocks?.append(block);
    }
    
}
