//
//  ViewController.swift
//  EPS8266_LED_iOS
//
//  Created by Jacey Chun on 2/9/20.
//  Copyright © 2020 Jacey Chun. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController {

    @IBOutlet weak var WebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
var led1on_URL = "http://192.168.0.6/setleds?led1=ON"
    @IBAction func LED1(_ sender: Any) {
        let requestURL = NSURL(string: led1on_URL)
        let request = NSURLRequest(url: requestURL! as URL)
        WebView.load(request as URLRequest)
    }
    
var led2on_URL = "http://192.168.0.6/setleds?led2=ON"
    @IBAction func LED2(_ sender: Any) {
        let requestURL = NSURL(string: led2on_URL)
        let request = NSURLRequest(url: requestURL! as URL)
        WebView.load(request as URLRequest)
    }
}

