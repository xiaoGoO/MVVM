//
//  MainViewModel.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/6.
//  Copyright © 2018年 关伟洪. All rights reserved.
//
/**
 * Main的ViewModel 处理业务逻辑
 */
import Foundation
class MainViewModel: ViewModelProtocol {
    
    
    /// 绑定是否登录的数据，当属性改变是会执行回调机制
    var isLogin:BingModel<Bool> = BingModel<Bool>(false);
    //数据列表
    var models:BingModel<[MainModel]> = BingModel<[MainModel]>();
    
    private var service:MainService?
    init() {
        service = MainService();
    }
    
    
    
    
    /// 登录
    ///
    /// - Parameters:
    ///   - userName: 名称
    ///   - password: 密码
    ///   - before: 加载数据之前
    ///   - failBack: 失败
    ///   - success: 成功
    public func login(userName:String?,password:String?,before:(()->Void)?,failBack:((String) -> Void)?,success:((MainModel) -> Void)?){
        if (userName?.isEmpty ?? true){
            failBack?("账号不能为空");
            return ;
        }
        if (password?.isEmpty ?? true){
            failBack?("密码为空");
            return;
        }
        before?();
        service?.login(userName: userName!, passWord: password!, successCallBack: { (result) in
            //处理result 比如报错登录后的用户信息 等逻辑 
            self.isLogin.value = true;
            //然后回调 给View处理
            success?(result);
        }, failCallBack: { (msg) in
            failBack?(msg);
        })
    }
    
    public func loadList(failBack:((String) -> Void)?,success:(([MainModel]) -> Void)?){
        self.service?.loadList(successCallBack: {[weak self] (list) in
            self?.models.value = list;
            success?(list);
        }, failCallBack: { (msg) in
            //失败
            failBack?(msg);
        });
    }
    
}
