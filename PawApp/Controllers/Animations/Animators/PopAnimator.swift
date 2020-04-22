//
//  PopAnimator.swift
//  PawApp
//
//  Created by Guzel Gubaidullina on 22.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class PopAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    private let animationDuration: TimeInterval = 0.7
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        let source = transitionContext.viewController(forKey: .from)!
        let destination = transitionContext.viewController(forKey: .to)!
        
        transitionContext.containerView.addSubview(destination.view)
        transitionContext.containerView.bringSubviewToFront(source.view)
        
        source.view.frame = transitionContext.containerView.frame
        destination.view.frame = transitionContext.containerView.frame
        
        let originalPosition = source.view.layer.position
        source.view.layer.anchorPoint = CGPoint(x: 1, y: 0)
        source.view.layer.position = CGPoint(x: source.view.frame.width, y: 0)
        
        UIView.animate(withDuration: animationDuration,
                       animations: {
                        source.view.transform = CGAffineTransform(rotationAngle: -CGFloat.pi/2)
        }) { completed in
            transitionContext.completeTransition(completed && !transitionContext.transitionWasCancelled)
            source.view.transform = .identity
            source.view.layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            source.view.layer.position = originalPosition
        }
    }
}
