//  TwoFactorView.swift
//  TwoFactorBridge
//
//  Created by Evelina Vorobyeva on 2025-12-10.
//

import SwiftUI
import WebKit

struct TwoFactorView: View {
    let onAuthenticated: () -> Void
    
    var body: some View {
        TwoFactorWebView(onAuthenticated: onAuthenticated)
            .ignoresSafeArea(.all)
    }
}

struct TwoFactorWebView: UIViewRepresentable {
    let onAuthenticated: () -> Void
    
    func makeUIView(context: Context) -> WKWebView {
        let configuration = WKWebViewConfiguration()
        let controller = WKUserContentController()
        
        controller.add(context.coordinator, name: "twoFactor")
        configuration.userContentController = controller
        
        let webView = WKWebView(frame: .zero, configuration: configuration)

        if let url = Bundle.main.url(forResource: "twofactor", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        context.coordinator.webView = webView
        return webView
    }
    
    func makeCoordinator() -> WebViewBridge {
        WebViewBridge(onAuthenticated: onAuthenticated)
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

#Preview {
    TwoFactorView {
        print("success")
    }
}
