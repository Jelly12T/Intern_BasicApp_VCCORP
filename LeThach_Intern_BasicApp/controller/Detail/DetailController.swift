//
//  DetailController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 19/08/2022.
//

import UIKit
import WebKit

class DetailController: UIViewController, WKNavigationDelegate {

    // MARK: variable
    var webView: WKWebView!
    var homeController = HomeViewController()
    var url: String = ""
    var activityIndicator = UIActivityIndicatorView()
    let pasteboard = UIPasteboard.general

    // MARK: outlet

    @IBOutlet weak private var navigationView: UIView!
    @IBOutlet weak private var containView: UIView!


    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        configWKWebView()

        configActivityIndicatorView()
        self.webView.load(URLRequest(url: URL(string: self.url)!))
        self.webView.navigationDelegate = self

    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        self.webView.frame = self.containView.frame

    }

    // MARK: config

    func webView(_ webView: WKWebView,
        didFinish navigation: WKNavigation!) {
        self.activityIndicator.removeFromSuperview()
        self.view.addSubview(self.webView)
    }


    func configActivityIndicatorView() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)

    }


    func configWKWebView() {
        let preferences = WKWebpagePreferences()
        let configuration = WKWebViewConfiguration()
        configuration.defaultWebpagePreferences = preferences
        self.webView = WKWebView(frame: .zero , configuration: configuration)

    }


    @IBAction func backBnt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func copyUrlBnt(_ sender: Any) {
        pasteboard.string = self.url
        print("copy")
        let message = "Đã copy link "
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        self.present(alert, animated: true)
        let duration: Double = 0.5
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + duration) {
            alert.dismiss(animated: true)
        }
    }
}

