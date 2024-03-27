//
//  WkWebViewRepresentable.swift
//  CoreKit
//
//  Created by Jisu Kim on 3/27/24.
//

import SwiftUI
import WebKit

public struct WkWebViewRepresentable: UIViewRepresentable {
    var url: String
    
    public func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: url) else {
            return WKWebView()
        }
        let webView = WKWebView()

        webView.load(URLRequest(url: url))
        
        return webView
    }
    
    public func updateUIView(_ webView: WKWebView, context: UIViewRepresentableContext<WkWebViewRepresentable>) {
//        guard let url = URL(string: url) else { return }
//        
//        webView.load(URLRequest(url: url))
    }
}
