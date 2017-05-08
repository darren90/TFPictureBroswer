//
//  TFPictureBroswerAnimator.swift
//  TFPictureBroswer_Swift
//
//  Created by Fengtf on 2017/5/5.
//  Copyright © 2017年 ftf. All rights reserved.
//

import UIKit

protocol PictureBroswerAnimatorPresentedDelegate {
    func startRect(indexPath:IndexPath) -> CGRect
    func endRect(indexPath:IndexPath) -> CGRect
    func imageView(indexPath:IndexPath) -> UIImageView
}

protocol PictureBroswerAnimatorDismissDelegate {
    func indexPathForDismiss() -> IndexPath
    func imageViewForDismiss() -> UIImageView
}


class TFPictureBroswerAnimator: NSObject {

    var isPresented:Bool = false

    var dismissDelegate:PictureBroswerAnimatorDismissDelegate?
    var presentedDelegate:PictureBroswerAnimatorPresentedDelegate?
    var indexPath : IndexPath?

}


extension TFPictureBroswerAnimator : UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = true
        return self
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresented = false
        return self
    }

}

//MARK: -- 遵守了UIViewControllerAnimatedTransitioning协议，必须实现的两个方法
extension TFPictureBroswerAnimator : UIViewControllerAnimatedTransitioning{

    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.5
    }


    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        if isPresented {
            animateForPresentedView(using: transitionContext)
        }else{
            animateForDismissdView(using: transitionContext)
        }
    }

    func animateForPresentedView(using transitionContext: UIViewControllerContextTransitioning){

        guard let presentedDelegate = presentedDelegate , let indexPath = indexPath else{
            return
        }

        let presentedView = transitionContext.view(forKey: .to)!

        transitionContext.containerView.addSubview(presentedView)

        let startRect = presentedDelegate.startRect(indexPath: indexPath)

        let imageView = presentedDelegate.imageView(indexPath: indexPath)
        imageView.frame = startRect
        transitionContext.containerView.addSubview(imageView)

        // start animate
        presentedView.alpha = 0.0
        transitionContext.containerView.backgroundColor = UIColor.black

        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            imageView.frame = presentedDelegate.endRect(indexPath: indexPath)
        }) { (_) in
            imageView.removeFromSuperview()
            transitionContext.containerView.backgroundColor = UIColor.clear
            presentedView.alpha = 1.0
            transitionContext.completeTransition(true)
        }

    }

    func animateForDismissdView(using transitionContext: UIViewControllerContextTransitioning){

        guard let dismissDelegate = dismissDelegate , let presentedDelegate = presentedDelegate else {
             return
        }

        let dismissView = transitionContext.view(forKey: .from)!

        dismissView.removeFromSuperview()

        let imageView = dismissDelegate.imageViewForDismiss()
        transitionContext.containerView.addSubview(imageView)
        let indexPath = dismissDelegate.indexPathForDismiss()

        // start animate
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: { 
            imageView.frame = presentedDelegate.startRect(indexPath: indexPath)
        }) { (_) in
            transitionContext.completeTransition(true)
        }

    }
}
