//
//  MainComponent.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/8.
//  Copyright © 2018年 关伟洪. All rights reserved.
//

import UIKit

class MainComponent: NSObject {
    
    
    /// 展示Main页面
    ///
    /// - Parameter window: 所展示的window
    public func showMainForm(window:UIWindow){
        //MainViewController 实例化
        let mainView =  MainViewController();
        mainView.viewModel.isLogin.value = false;
        window.rootViewController = mainView;
        window.makeKeyAndVisible();
    }
    
}
