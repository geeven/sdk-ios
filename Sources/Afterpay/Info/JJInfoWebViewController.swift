

import Foundation
import UIKit
import WebKit

final class JJInfoWebViewController: UIViewController, WKNavigationDelegate {
  
  private let infoURL: URL
  
  private var webView: WKWebView = WKWebView()
  
  init(infoURL: URL) {
    self.infoURL = infoURL
    
    super.init(nibName: nil, bundle: nil)
    
    view.addSubview(webView)
    webView.allowsLinkPreview = false
    webView.navigationDelegate = self
    view.backgroundColor = .white
    webView.frame = CGRect(x: 0, y: 56, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height - 56)
    if #available(iOS 13.0, *) {
      let btn = UIButton(type: .close)
      view.addSubview(btn)
      btn.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
      btn.frame = CGRect(x: UIScreen.main.bounds.size.width - 60, y: 8, width: 40, height: 40)
    } else {
      // Fallback on earlier versions
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    self.extendedLayoutIncludesOpaqueBars = true
    

  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    
    webView.load(URLRequest(url: infoURL))
  }
  
  @objc private func dismissViewController() {
    dismiss(animated: true)
  }
  
  // MARK: WKNavigationDelegate
  
  func webView(
    _ webView: WKWebView,
    didFailProvisionalNavigation navigation: WKNavigation!,
    withError error: Error
  ) {
    let alert = UIAlertController(
      title: "Error",
      message: "Failed to load Afterpay information",
      preferredStyle: .alert
    )
    
    alert.addAction(
      UIAlertAction(title: "Retry", style: .default) { [infoURL] _ in
        webView.load(URLRequest(url: infoURL))
      }
    )
    alert.addAction(
      UIAlertAction(title: "Cancel", style: .destructive) { _ in
        self.dismiss(animated: true)
      }
    )
    
    present(alert, animated: true, completion: nil)
  }
  
  func webView(
    _ webView: WKWebView,
    decidePolicyFor navigationAction: WKNavigationAction,
    decisionHandler: @escaping (WKNavigationActionPolicy) -> Void
  ) {
    if let url = navigationAction.request.url, url != infoURL {
      decisionHandler(.cancel)
      UIApplication.shared.open(url)
    } else {
      decisionHandler(.allow)
    }
  }
  
  // MARK: Unavailable
  
  @available(*, unavailable)
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
