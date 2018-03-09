//
//  MainService.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/7.
//  Copyright © 2018年 关伟洪. All rights reserved.
//
import Dispatch
/**
 * Main的数据服务类
 */
class MainService {
    
    //登录接口地址
    private var loginUrl:String = "host+xxx/xxx";
    
    /// 登录插件
    ///
    /// - Parameters:
    ///   - userName: 用户名
    ///   - passWord: 密码
    ///   - successCallBack: 成功回调
    ///   - failCallBack: 失败回调
    public func login(userName:String,passWord:String, successCallBack:@escaping ((MainModel) -> Void),failCallBack:@escaping ((String) -> Void)){
        //调用网络请求执行登录  下面的方法是模拟网络请求的延迟
        DispatchQueue.init(label: "load").asyncAfter(wallDeadline: DispatchWallTime.now() + 2) {
            DispatchQueue.main.async {
                
                let data = ["code":1,"msg":"登录成功","result":["name":"小关","age":1,"info":"好男人"]] as [String : Any];
                let code:Int = (data["code"] as? Int) ?? 0;
                if(code == 1){
                    let result = data["result"] as! [String:Any];
                    let model:MainModel = MainModel(name: result["name"] as? String, age: result["age"] as? Int, info: result["info"] as? String);
                    successCallBack(model);
                }else{
                    failCallBack((data["msg"] as? String) ?? "网络加载失败");
                }
                
            }
        }
    }
    
    /// 加载数据列表
    ///
    /// - Parameters:
    ///   - successCallBack: 成功回调
    ///   - failCallBack: 失败回调
    public func loadList(successCallBack:@escaping (([MainModel]) -> Void),failCallBack:@escaping ((String) -> Void)){
        
        DispatchQueue.init(label: "load").asyncAfter(wallDeadline: DispatchWallTime.now() + 2) {
            DispatchQueue.main.async {
                
                let data = ["code":1,"msg":"登录成功","result":["name":"小关","age":1,"info":"好男人"]] as [String : Any];
                let code:Int = (data["code"] as? Int) ?? 0;
                if(code == 1){
//                    let result = data["result"] as! [String:Any];
                    successCallBack([MainModel(name: "小关", age: 18, info: "好男人"),MainModel(name: "小关1", age: 18, info: "好男人"),MainModel(name: "小关2", age: 18, info: "好男人")]);
                }else{
                    failCallBack((data["msg"] as? String) ?? "网络加载失败");
                }
                
            }
        }
    }
    
}
