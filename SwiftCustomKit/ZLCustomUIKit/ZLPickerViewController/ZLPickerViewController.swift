//
//  ZLPickerViewController.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/8.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit

protocol ZLPickerViewControllerDataSource : UIPickerViewDataSource {
    
}

protocol ZLPickerViewControllerDelegate : UIPickerViewDelegate {
    func pickerViewController(pickerViewController : ZLPickerViewController, didSelect index: Int)
}

class ZLPickerViewController: UIViewController {
    public final var defaultColor : UIColor! = UIColor.colorWithHexString("#66B8FF")
    public final var defaultRow : Int! = 0
    public final var defaultComponent : Int! = 0
    public final var dataSource : ZLPickerViewControllerDataSource!
    public final var delegate : ZLPickerViewControllerDelegate!
    
    var isPresent : Bool = false
    private let toolView : UIView = UIView(frame: CGRect(x: 0, y: DeviceHeight(), width: DeviceWidth(), height: 44))
    private let cancelButton : UIButton = UIButton(type: .custom)
    private let confirmButton : UIButton = UIButton(type: .custom)
    let pickerView : UIPickerView = UIPickerView(frame: CGRect(x: 0, y: DeviceHeight(), width: DeviceWidth(), height: 220))
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
        self.transitioningDelegate = self

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @objc private func cancelButton_pressed(_ sender : UIButton){
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func confirmButton_pressed(_ sender : UIButton){
        self.delegate.pickerViewController(pickerViewController: self, didSelect: self.pickerView.selectedRow(inComponent: 0))
        self.dismiss(animated: true, completion: nil)
    }
    
    private func loadUI(){
        self.view.backgroundColor = UIColor.clear
        
        self.toolView.backgroundColor = UIColor.colorWithHexString("#F5F5F5")
        self.view.addSubview(self.toolView)
        
        self.cancelButton.setTitle(TipConfig.ZLCancelBrief, for: .normal)
        self.cancelButton.setTitleColor(self.defaultColor, for: .normal)
        self.cancelButton.addTarget(self, action: #selector(cancelButton_pressed(_:)), for: .touchUpInside)
        self.cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        self.toolView.addSubview(self.cancelButton)
        
        self.confirmButton.setTitle(TipConfig.ZLConfirmBrief, for: .normal)
        self.confirmButton.setTitleColor(self.defaultColor, for: .normal)
        self.confirmButton.addTarget(self, action: #selector(confirmButton_pressed(_:)), for: .touchUpInside)
        self.confirmButton.titleLabel?.font = UIFont.systemFont(ofSize: 16.0)
        self.toolView.addSubview(self.confirmButton)
        
        self.pickerView.backgroundColor = UIColor.white
        self.pickerView.dataSource = self.dataSource
        self.pickerView.delegate = self.delegate
        self.view.addSubview(self.pickerView)
        
        self.pickerView.selectRow(self.defaultRow, inComponent: self.defaultComponent, animated: true)
        
//        self.toolView.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view)
//            make.right.equalTo(self.view)
//            make.bottom.equalTo(self.pickerView.snp.top)
//            make.height.equalTo(44)
//        }
        
        self.cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.toolView).offset(12)
            make.top.equalTo(self.toolView)
            make.bottom.equalTo(self.toolView)
            make.width.lessThanOrEqualTo(60)
        }
        
        self.confirmButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.toolView.snp.right).offset(-12)
            make.top.equalTo(self.toolView)
            make.bottom.equalTo(self.toolView)
            make.width.lessThanOrEqualTo(60)
        }
        
//        self.pickerView.snp.makeConstraints { (make) in
//            make.left.equalTo(self.view)
//            make.right.equalTo(self.view)
//            make.bottom.equalTo(self.view).offset(220)
//            make.height.equalTo(220)
//        }
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

extension ZLPickerViewController : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.isPresent {
            let toVC : ZLPickerViewController = transitionContext.viewController(forKey: .to) as! ZLPickerViewController
            let containerView : UIView = transitionContext.containerView
            let toView : UIView = toVC.view
//            let fromVC : UIViewController = transitionContext.viewController(forKey: .from)!
//            let fromView : UIView = fromVC.view
//            containerView.addSubview(fromView)
            containerView.addSubview(toView)

            self.confirmShowAnimation(transitionContext)
        }
        else{
            let toVC : UIViewController = transitionContext.viewController(forKey: .to)!
            let fromVC : ZLPickerViewController = transitionContext.viewController(forKey: .from) as! ZLPickerViewController
            let containerView : UIView = transitionContext.containerView
            let toView : UIView = toVC.view
            let fromView : UIView = fromVC.view
            containerView.addSubview(toView)
            containerView.bringSubview(toFront: fromView)
            
            self.confirmDismissAnimation(transitionContext)
        }
    }
    
    private func confirmShowAnimation(_ transitionContext : UIViewControllerContextTransitioning){
        UIView.setAnimationCurve(.easeInOut)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { [weak self] in
            self?.toolView.frame = CGRect(x: 0, y: DeviceHeight() - 264, width: DeviceWidth(), height: 44)
            self?.pickerView.frame = CGRect(x: 0, y: DeviceHeight() - 220, width: DeviceWidth(), height: 220)
            self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func confirmDismissAnimation(_ transitionContext : UIViewControllerContextTransitioning){
        UIView.setAnimationCurve(.easeInOut)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { [weak self] in
            self?.toolView.frame = CGRect(x: 0, y: DeviceHeight(), width: DeviceWidth(), height: 44)
            self?.pickerView.frame = CGRect(x: 0, y: DeviceHeight() + 44, width: DeviceWidth(), height: 220)
            self?.view.backgroundColor = UIColor.clear
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
    }
}

extension ZLPickerViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresent = false
        return self
    }
    
}
