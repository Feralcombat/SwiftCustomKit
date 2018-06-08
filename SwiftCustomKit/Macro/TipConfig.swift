//
//  TipConfig.swift
//  IntelligentTextbook
//
//  Created by 周麟 on 2018/5/4.
//  Copyright © 2018年 苏州百智通信息技术有限公司. All rights reserved.
//

import UIKit

class TipConfig: NSObject {
    static let ZLCancelBrief = ZLLocalizedString("cancel")
    static let ZLConfirmBrief = ZLLocalizedString("confirm")
    
    static private func ZLLocalizedString(_ string: String!) -> String{
        return Bundle.main.localizedString(forKey: string, value: nil, table: "StringConfig")
    }
}
