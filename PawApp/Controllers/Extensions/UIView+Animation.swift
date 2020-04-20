//
//  UIView+Animation.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 16.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

extension UIView {
    func pulsate() {
        let pulse = CASpringAnimation(keyPath: "transform.scale")
        pulse.duration = 0.1
        pulse.fromValue = 1.0
        pulse.toValue = 0.5
        pulse.autoreverses = true
        pulse.repeatCount = 1
        pulse.initialVelocity = 0.5
        pulse.damping = 0.5
        
        layer.add(pulse, forKey: nil)
    }
}
