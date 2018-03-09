//
//  MainViewController.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/6.
//  Copyright © 2018年 关伟洪. All rights reserved.
//

import UIKit
import MBProgressHUD
import MJRefresh

class MainViewController: BaseViewController,MVVMProtocol {
    
    typealias ViewModel = MainViewModel;
    var viewModel: ViewModel;
    /// tableView适配器
    var tableCellAdapter:MainCellAdapter?;
    
    private let userNameTF:UITextField = UITextField();
    private let passWordTF:UITextField = UITextField();
    private let button:UIButton = UIButton(type: UIButtonType.custom);
    private let tableView:UITableView = UITableView();
    
    required  init(viewModel: ViewModel) {
        self.viewModel = viewModel;
        super.init(nibName: nil, bundle: nil);
    }
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.viewModel = MainViewModel();
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil);
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        viewModel = MainViewModel();
        super.init(coder: aDecoder);
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView();
        initBing();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }
    
    
    /// 初始化UI
    private func initView(){
        self.tableCellAdapter = MainCellAdapter(tableView: tableView);
        self.view.addSubview(tableView);
        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: {[weak self] () in
            //调用数据加载
            self?.viewModel.loadList(failBack: { (msg) in
                //停止刷新
                self?.tableView.mj_header.endRefreshing();
                self?.showToast(msg);
                
            }, success: { (models) in
                //停止刷新
                self?.tableView.mj_header.endRefreshing();
            });
        });
        
        setUpLoginView();
        setUpTableView();
    }
    /// 初始化绑定
    private func initBing(){
        //绑定数据列表属性
        self.viewModel.models.addChangeCallBack {[weak self] (models) in
            //刷新TableView的Cell适配
            self?.tableCellAdapter?.models = models;
            self?.tableCellAdapter?.notifyChange();
        }
        //绑定是否登录属性
        self.viewModel.isLogin.addChangeCallBack {[weak self] (isLogin) in
            //登录成功
            self?.setUpLoginView();
            self?.setUpTableView();
            self?.tableView.mj_header.beginRefreshing();
        }
    }
    
    /// 刷新登录页面
    private func setUpLoginView(){
        if !(viewModel.isLogin.value ?? false){
            self.view.backgroundColor = UIColor.white;
            userNameTF.frame = CGRect(x: (UIScreen.main.bounds.width - 150) / 2.0, y: 50, width: 150, height: 40);
            userNameTF.layer.borderWidth = 1;
            userNameTF.layer.borderColor = UIColor.black.cgColor;
            userNameTF.placeholder = "请输入账号";
            self.view.addSubview(userNameTF);
            
            passWordTF.frame = CGRect(x: userNameTF.frame.origin.x, y: userNameTF.frame.origin.y + userNameTF.frame.size.height + 10, width: userNameTF.frame.size.width, height: userNameTF.frame.size.height);
            passWordTF.placeholder = "请输入密码";
            passWordTF.layer.borderWidth = 1;
            passWordTF.layer.borderColor = UIColor.black.cgColor;
            self.view.addSubview(passWordTF);
            
            button.frame = CGRect(x:userNameTF.frame.origin.x, y: passWordTF.frame.origin.y + passWordTF.frame.size.height + 10, width:  passWordTF.frame.size.width, height: passWordTF.frame.size.height);
            button.setTitle("登录", for: .normal);
            button.backgroundColor = UIColor.red;
            self.view.addSubview(button);
            button.addTarget(self, action: #selector(onLogin(_:)), for: .touchUpInside);
        }else{
            userNameTF.removeFromSuperview();
            passWordTF.removeFromSuperview();
            button.removeFromSuperview();
        }
    }
    //刷新列表结构
    private func setUpTableView(){
        let offy = (self.viewModel.isLogin.value ?? false) ? 0:button.frame.origin.y
        tableView.frame = CGRect(origin: CGPoint(x: 0, y: offy), size: CGSize(width: self.view.frame.size.width, height: self.view.frame.size.height - offy));
    }
    
    //MARK: Action
    @objc private func onLogin(_ btn:UIButton){
        viewModel.login(userName: userNameTF.text, password: passWordTF.text, before: {[weak self] () in
            //打开网络请求加载提示框
            MBProgressHUD.showAdded(to: self!.view, animated: true);
        }, failBack: {[weak self] (msg) in
            //失败提示语
            self?.showToast(msg);
        }) {[weak self] (model) in
            //登录成功
            self?.showToast("登录成功");
        }
    }
    
    
    /// toast提示语
    ///
    /// - Parameter msg: 提升内容
    public func showToast(_ msg:String){
        MBProgressHUD.hide(for: self.view, animated: true);
        DispatchQueue.main.async {
            let mb = MBProgressHUD.showAdded(to: self.view, animated: true);
            mb.label.text = msg;
            mb.hide(animated: true, afterDelay: 0.5);
        }
        
    }
    
}
