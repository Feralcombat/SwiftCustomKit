//
//  ZLDrawerViewController.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/8.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit

class ZLDrawerViewController: UIViewController {

    let contentView : UIView = UIView(frame: CGRect(x: DeviceWidth(), y: 0, width: 300, height: DeviceHeight()))
    var dismissGesture : UITapGestureRecognizer?
    let transition = ZLDrawerTransition()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = UIModalPresentationStyle.custom
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
        self.transitioningDelegate = self.transition
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc private func dismissAciton(){
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadUI(){
        self.contentView.backgroundColor = UIColor.white
        self.view.addSubview(self.contentView)
        
        self.dismissGesture = UITapGestureRecognizer(target: self, action: #selector(dismissAciton))
        self.dismissGesture?.delegate = self
        self.view.addGestureRecognizer(self.dismissGesture!)
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ZLDrawerViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == self.dismissGesture {
            if touch.view == self.view{
                return true
            }
            return false
        }
        return true
    }
}
