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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let url = URL(string: "https://ufoodie.com.au")
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

