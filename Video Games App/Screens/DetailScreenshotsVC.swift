//
//  DetailScreenshotsVC.swift
//  Video Games App
//
//  Created by Mikail Baykara on 2.06.2023.
//

import UIKit
import WebKit
import SDWebImage

class DetailScreenshotsVC: UIViewController {

    var urlString: String?
    var webView: WKWebView!
    
    override func loadView() {
        webView = WKWebView()
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let urlString = urlString else { return }

        let html = """
         <html>
         <head>
         <meta name="viewport" content="width=device-width, initial-scale=1">
         </head>
         <body>
         <img src="\(urlString)" width="100%" />
         </body>
         </html>
         """

        webView.loadHTMLString(html, baseURL: nil)
         
    }
    
}
