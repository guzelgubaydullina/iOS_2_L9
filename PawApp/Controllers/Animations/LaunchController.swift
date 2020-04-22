//
//  LaunchController.swift
//  vk_GuzelGubaydullina
//
//  Created by Guzel Gubaidullina on 15.04.2020.
//  Copyright © 2020 Guzel Gubaidullina. All rights reserved.
//

import UIKit

class LaunchController: UIViewController {
    
    @IBOutlet weak var loadingView1: UIImageView!
    @IBOutlet weak var loadingView2: UIImageView!
    @IBOutlet weak var loadingView3: UIImageView!
    @IBOutlet weak var loadingView4: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        loadingViewAppearing()
    }

    func loadingViewAppearing() {
        UIView.animateKeyframes(withDuration: 7, delay: 0, options: .calculationModeCubic, animations: {
            UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.125) {
                self.loadingView1.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.125, relativeDuration: 0.125) {
                self.loadingView2.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.125) {
                self.loadingView3.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.375, relativeDuration: 0.125) {
                self.loadingView4.alpha = 1.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.125) {
                self.loadingView1.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.625, relativeDuration: 0.125) {
                self.loadingView2.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.125) {
                self.loadingView3.alpha = 0.0
            }
            UIView.addKeyframe(withRelativeStartTime: 0.875, relativeDuration: 0.125) {
                self.loadingView4.alpha = 0.0
            }
        }, completion: { finished in
            self.performSegue(withIdentifier: "segueShowLoginController", sender: self)
        })
    }
}
