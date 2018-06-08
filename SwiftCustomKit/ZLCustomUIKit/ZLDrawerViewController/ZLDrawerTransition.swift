//
//  ZLDrawerTransition.swift
//  SwiftCustomKit
//
//  Created by 周麟 on 2018/6/8.
//  Copyright © 2018年 周麟. All rights reserved.
//

import UIKit

class ZLDrawerTransition: NSObject ,UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate{
    private var isPresent: Bool = false
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.25
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if self.isPresent {
            let toVC : ZLDrawerViewController = transitionContext.viewController(forKey: .to) as! ZLDrawerViewController
            let containerView : UIView = transitionContext.containerView
            let toView : UIView = toVC.view
            let contentView = toVC.contentView
            
            containerView.addSubview(toView)
            //            containerView.bringSubview(toFront: fromView)
            
            UIView.setAnimationCurve(.easeInOut)
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                toView.backgroundColor = UIColor.black.withAlphaComponent(0.6)
                contentView.frame = CGRect(x: DeviceWidth() - 300, y: 0, width: DeviceWidth(), height: DeviceHeight())
            }) { (finish) in
                transitionContext.completeTransition(true)
            }
        }
        else{
            let toVC : UIViewController = transitionContext.viewController(forKey: .to)!
            let fromVC : ZLDrawerViewController = transitionContext.viewController(forKey: .from) as! ZLDrawerViewController
            let containerView : UIView = transitionContext.containerView
            let toView : UIView = toVC.view
            let contentView = fromVC.contentView
            let fromView : UIView = fromVC.view
            containerView.addSubview(toView)
            containerView.bringSubview(toFront: fromView)
            
            UIView.setAnimationCurve(.easeInOut)
            UIView.animate(withDuration: self.transitionDuration(using: transitionContext), animations: {
                fromView.backgroundColor = UIColor.clear
                contentView.frame = CGRect(x: DeviceWidth(), y: 0, width: DeviceWidth(), height: DeviceHeight())
            }) { (finish) in
                transitionContext.completeTransition(true)
            }
        }
    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresent = true
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.isPresent = false
        return self
    }
}
