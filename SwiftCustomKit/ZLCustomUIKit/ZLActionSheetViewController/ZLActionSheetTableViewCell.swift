//
//  ZLActionSheetTableViewCell.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/11.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit

class ZLActionSheetTableViewCell: UITableViewCell {
    public var nameLabel = UILabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.nameLabel.font = UIFont.systemFont(ofSize: 16)
        self.nameLabel.textColor = UIColor.colorWithHexString("#333333")
        self.nameLabel.textAlignment = NSTextAlignment.center
        self.contentView.addSubview(self.nameLabel)
        
        self.nameLabel.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contentView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func setContentWithText(_ text : String!) {
        self.nameLabel.text = text
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
