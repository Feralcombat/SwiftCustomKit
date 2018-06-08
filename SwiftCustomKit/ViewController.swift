//
//  ViewController.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/8.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit
import SnapKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let button : UIButton = UIButton(type: .custom)
        button.setTitle("点我", for: .normal)
        button.setTitleColor(UIColor.blue, for: .normal)
        button.addTarget(self, action: #selector(button_pressed(_:)), for: .touchUpInside)
        self.view.addSubview(button)
        
        button.snp.makeConstraints { (make) in
            make.center.equalTo(self.view);
            make.width.equalTo(40)
            make.height.equalTo(24)
        }
        
    }

    @objc private func button_pressed(_ sender: UIButton){
//        let vc = ZLDrawerViewController()
//        self.present(vc, animated: true, completion: nil)
        
        let vc = ZLPickerViewController()
        vc.dataSource = self as ZLPickerViewControllerDataSource
        vc.delegate = self as ZLPickerViewControllerDelegate
        self.present(vc, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
//
//extension ViewController : BZTActionSheetViewControllerDelegate{
//    func numberOfRows(actionSheetViewController: BZTActionSheetViewController) -> Int {
//        return 1
//    }
//
//    func actionSheetViewController(actionSheetViewController: BZTActionSheetViewController, titleForRow: Int) -> String {
//        return "测试"
//    }
//
//    func actionSheetViewController(actionSheetViewController: BZTActionSheetViewController, didSelectRowAtIndex: Int) {
//
//    }
//
//    func actionSheetViewController(actionSheetViewController: BZTActionSheetViewController, allowSelectRowAtIndex: Int) -> Bool {
//        return true
//    }
//}

extension ViewController : ZLPickerViewControllerDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 5
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "123"
    }
}

extension ViewController : ZLPickerViewControllerDelegate{
    func pickerViewController(pickerViewController: ZLPickerViewController, didSelect index: Int) {
        
    }
    
    
}
