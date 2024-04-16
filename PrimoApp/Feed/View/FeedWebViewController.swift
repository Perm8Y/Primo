//
//  FeedWebViewController.swift
//  PrimoApp
//
//  Created by Perm on 15/4/2567 BE.
//

import Foundation
import UIKit
import WebKit

class FeedWebViewController: UIViewController {
    
    var webview = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setWebView(url: URL) {
        self.webview.frame = self.view.bounds
        self.webview.load(URLRequest(url: url))
        self.view.addSubview(self.webview)
    }
}
