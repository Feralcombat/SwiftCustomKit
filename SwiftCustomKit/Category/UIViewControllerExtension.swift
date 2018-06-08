//
//  UIViewControllerExtension.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/8.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit

extension UIViewController{
    
    public func setBackItemTitle(title : String?) -> Void {
        let backItem = UIBarButtonItem()
        backItem.title = title
        self.navigationItem.backBarButtonItem = backItem
    }
}
