//
//  ViewController.swift
//  Ufoodie 2.0
//
//  Created by 刘雨豪 on 08/06/2018.
//  Copyright © 2018 AUFOOD PTY LTD. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var ufoodProgress: UIProgressView!
    @IBOutlet weak var ufoodWebview: WKWebView!
    @IBOutlet weak var viewConstraint: NSLayoutConstraint!
    @IBOutlet weak var blurView: UIVisualEffectView!
    @IBOutlet weak var sideView: UIView!
    @IBOutlet weak var sideViewConstraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blurView.layer.cornerRadius = 15
        
        sideViewConstraint.constant = -175
        
        
        let url = URL(string: "https://ufoodie.com.au/price_plan/basic/")
        let request = URLRequest(url: url!)
        ufoodWebview.load(request)
        ufoodProgress.sizeToFit()
        ufoodWebview.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            ufoodProgress.progress = Float (ufoodWebview.estimatedProgress)
        }
        
        if (ufoodProgress.progress == 1) {
            self.ufoodProgress.setProgress(0, animated: false)
        }
    }

    @IBAction func panPerformed(_ sender: UIPanGestureRecognizer) {

            if sender.state == .began || sender.state == .changed {
                
                let translation = sender.translation(in: self.view).x
                
                if translation > 0 { // Swipe Right
                    if sideViewConstraint.constant < 20 {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.sideViewConstraint.constant += translation
                            self.view.layoutIfNeeded()
                        })
                                            }
                } else {             // Swipe Left
                    
                    if sideViewConstraint.constant > -175 {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.sideViewConstraint.constant += translation
                            self.view.layoutIfNeeded()
                        })
                    }
                    
                }
                
            } else if sender.state == .ended {
                
                if sideViewConstraint.constant < -100 {
                    UIView.animate(withDuration: 0.2, animations: {
                        self.sideViewConstraint.constant = -175
                        self.view.layoutIfNeeded()
                    })
                } else {
                    if sideViewConstraint.constant > -175 {
                        UIView.animate(withDuration: 0.2, animations: {
                            self.sideViewConstraint.constant = 0
                            self.view.layoutIfNeeded()
                        })
                    }
                }
            }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

