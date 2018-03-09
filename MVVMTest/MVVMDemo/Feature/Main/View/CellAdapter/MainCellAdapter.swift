//
//  MainCellAdapter.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/8.
//  Copyright © 2018年 关伟洪. All rights reserved.
//
/**
 * TableView的Cell适配
 */
import UIKit

class MainCellAdapter:  NSObject, UITableViewDelegate,UITableViewDataSource {
    private weak var tableView:UITableView?
    var models:[MainModel]?
    required convenience init(tableView:UITableView) {
        self.init();
        self.tableView = tableView;
        //TableView注册Cell
        self.tableView?.register(MainCell.self, forCellReuseIdentifier: "MainCell");
        //设置代理
        self.tableView?.delegate = self;
        self.tableView?.dataSource = self;
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models?.count ?? 0;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:MainCell = tableView.dequeueReusableCell(withIdentifier: "MainCell") as! MainCell;
        cell.model = models?[indexPath.row];
        return cell;
    }
    /**刷新TableView*/
    func notifyChange(){
        DispatchQueue.main.async {[weak self] () in
            self?.tableView?.reloadData();
        }
    }
}
