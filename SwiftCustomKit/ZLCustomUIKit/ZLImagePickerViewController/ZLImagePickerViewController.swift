//
//  ZLImagePickerViewController.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/8.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit
import AVFoundation

class ZLImagePickerViewController: UIImagePickerController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.configAuthorization()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func configAuthorization(){
        let authStatus : AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        if authStatus == .denied || authStatus == .restricted {
            let alert = UIAlertView(title: "没有相机权限", message: "请去设置-隐私-相机中对应用授权", delegate: self, cancelButtonTitle: "好的");
            alert.show()
        }
    }
    
    override var prefersStatusBarHidden: Bool{
        return true
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

extension ZLImagePickerViewController : UIAlertViewDelegate{
    func alertView(_ alertView: UIAlertView, clickedButtonAt buttonIndex: Int) {
        let url : URL! = URL(string: UIApplicationOpenSettingsURLString)
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.openURL(url)
        }
    }
}
