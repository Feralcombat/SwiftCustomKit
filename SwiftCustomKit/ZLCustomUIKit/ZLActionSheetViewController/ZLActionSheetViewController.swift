//
//  ZLActionSheetViewController.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/11.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit

@objc protocol ZLActionSheetViewControllerDelegate {
    func numberOfRows(actionSheetViewController : ZLActionSheetViewController) -> Int
    func actionSheetViewController(actionSheetViewController : ZLActionSheetViewController, titleForRow : Int) -> String
    func actionSheetViewController(actionSheetViewController : ZLActionSheetViewController, didSelectRowAtIndex : Int)
    func actionSheetViewController(actionSheetViewController : ZLActionSheetViewController, allowSelectRowAtIndex : Int) ->Bool
}

class ZLActionSheetViewController: UIViewController {

    var tag : Int! = 0
    var maxRow : Int! = 5
    weak var delegate : ZLActionSheetViewControllerDelegate!
    
    private var rows : Int! = 0
    private var isPresent : Bool = false
    
    private let tableView = UITableView.init(frame: CGRect(x: 0, y: DeviceHeight(), width: DeviceWidth(), height: 0), style: UITableViewStyle.plain)
    private let bottomView = UIView()
    private let cancelButton = UIButton()
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        self.modalPresentationStyle = UIModalPresentationStyle.overFullScreen
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadUI()
        self.resizeSubView()
        self.transitioningDelegate = self;
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func resizeSubView(){
        self.rows = self.delegate.numberOfRows(actionSheetViewController: self)
        if self.rows > self.maxRow {
            self.tableView.frame = CGRect(x: 0.0, y: DeviceHeight(), width: DeviceWidth(), height: CGFloat(self.maxRow) * 44 + 56)
        }
        else {
            self.tableView.frame = CGRect(x: 0.0, y: DeviceHeight(), width: DeviceWidth(), height: CGFloat(self.rows) * 44 + 56)
        }
    }
    
    @objc private func cancelButton_pressed(_ : UIButton){
        self.dismiss(animated: true, completion: nil);
    }
    
    private func loadUI(){
        
        self.bottomView.frame = CGRect(x: 0, y: 0, width: DeviceWidth(), height: 56)
        self.bottomView.backgroundColor = UIColor.colorWithHexString("#F5F5F5")
        
        self.cancelButton.frame = CGRect(x: 0, y: 12, width: DeviceWidth(), height: 44)
        self.cancelButton.setTitle(TipConfig.ZLCancelBrief, for: .normal)
        self.cancelButton.setTitleColor(UIColor.colorWithHexString("#BDBDBD"), for: .normal)
        self.cancelButton.backgroundColor = UIColor.white
        self.cancelButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        self.cancelButton.addTarget(self, action: #selector(cancelButton_pressed(_:)), for: .touchUpInside)
        self.bottomView.addSubview(self.cancelButton)
        
        self.tableView.register(ZLActionSheetTableViewCell.self, forCellReuseIdentifier: "ZLActionSheetTableViewCell")
        self.tableView.delegate = (self as UITableViewDelegate)
        self.tableView.dataSource = (self as UITableViewDataSource)
        self.tableView.bounces = false
        self.tableView.separatorInset = UIEdgeInsets.zero
        self.tableView.tableFooterView = self.bottomView
        if #available(iOS 9.0, *) {
            self.tableView.cellLayoutMarginsFollowReadableWidth = false
        }
        self.view.addSubview(self.tableView)
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

extension ZLActionSheetViewController : UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.delegate.numberOfRows(actionSheetViewController: self)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZLActionSheetTableViewCell", for: indexPath) as! ZLActionSheetTableViewCell
        let text = self.delegate.actionSheetViewController(actionSheetViewController: self, titleForRow: indexPath.row)
        cell.setContentWithText(text)
        if self.delegate.actionSheetViewController(actionSheetViewController: self, allowSelectRowAtIndex: indexPath.row) {
            cell.nameLabel.textColor = UIColor.colorWithHexString("#333333")
        }
        else {
            cell.nameLabel.textColor = UIColor.colorWithHexString("#BDBDBD")
        }
        return cell
    }
}

extension ZLActionSheetViewController : UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if self.delegate.actionSheetViewController(actionSheetViewController: self, allowSelectRowAtIndex: indexPath.row) {
            self.dismiss(animated: true, completion: nil);
        }
        self.delegate.actionSheetViewController(actionSheetViewController: self, didSelectRowAtIndex: indexPath.row)
    }
}

extension ZLActionSheetViewController : UIViewControllerAnimatedTransitioning{
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.isPresent {
            let toVC : ZLActionSheetViewController = transitionContext.viewController(forKey: .to) as! ZLActionSheetViewController
            let containerView : UIView = transitionContext.containerView
            let toView : UIView = toVC.view
            containerView.addSubview(toView)
            self.confirmShowAnimation(transitionContext)
        }
        else{
            self.confirmDismissAnimation(transitionContext)
        }
    }
    
    private func confirmShowAnimation(_ transitionContext : UIViewControllerContextTransitioning){
        UIView.setAnimationCurve(.easeInOut)
        
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { [weak self] in
            if (self!.rows) > (self!.maxRow) {
                self?.tableView.frame = CGRect(x:0, y:DeviceHeight() - 56 - CGFloat(self!.maxRow) * 44, width: DeviceWidth(), height: CGFloat(self!.maxRow) * 44 + 56);
            }
            else{
                self?.tableView.frame = CGRect(x:0, y:DeviceHeight() - 56 - CGFloat(self!.rows) * 44, width:DeviceWidth(), height:CGFloat(self!.rows) * 44 + 56);
            }
            self?.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
    }
    
    private func confirmDismissAnimation(_ transitionContext : UIViewControllerContextTransitioning){
        UIView.setAnimationCurve(.easeInOut)
        UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: { [weak self] in
            self?.tableView.frame = CGRect(x: 0, y: DeviceHeight(), width: DeviceWidth(), height: (self?.tableView.frame.size.height)!)
            self?.view.backgroundColor = UIColor.clear
        }) { (finish) in
            transitionContext.completeTransition(true)
        }
    }
}

extension ZLActionSheetViewController : UIViewControllerTransitioningDelegate{
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresent = false
        return self
    }
    
}
