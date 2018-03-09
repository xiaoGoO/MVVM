//
//  MainCell.swift
//  MVVMDemo
//
//  Created by 关伟洪 on 2018/3/8.
//  Copyright © 2018年 关伟洪. All rights reserved.
//

import UIKit

class MainCell: UITableViewCell {
    
    public var model:MainModel?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func layoutSubviews() {
        super.layoutSubviews();
        //处理逻辑
        self.textLabel?.text = model?.name ?? "????";
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
