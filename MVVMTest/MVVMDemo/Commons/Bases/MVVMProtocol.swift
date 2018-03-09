//
//  MVVMViewControllerProtocol.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/6.
//  Copyright © 2018年 关伟洪. All rights reserved.
//

protocol MVVMProtocol {
    //任何继承 ViewModelProtocol 协议的类
    associatedtype ViewModel:ViewModelProtocol;
    //ViewModel
    var viewModel: ViewModel { get set }
    //初始化
    init (viewModel:ViewModel);
}
