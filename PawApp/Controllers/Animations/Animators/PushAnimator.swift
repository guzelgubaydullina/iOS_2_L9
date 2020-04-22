//
//  PushAnimator.swift
//  PawApp
//
//  Created by Guzel Gubaidullina on 22.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class PushAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 0.7
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let source = transitionContext.viewController(forKey: .from)!
        let destination = transitionContext.viewController(forKey: .to)!
        
        transitionContext.containerView.addSubview(destination.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        let originalPosition = destination.view.layer.position
        destination.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        destination.view.layer.position = CGPoint(x: destination.view.frame.width, y: 0)
        destination.view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        
        UIView.animate(withDuration: animationDuration,
                       animations: {
                        destination.view.transform = .identity
        }) { completed in
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
            destination.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            destination.view.layer.position = originalPosition
        }
    }
}
