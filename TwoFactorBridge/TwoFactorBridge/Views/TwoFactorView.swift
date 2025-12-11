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

    func makeUIView(context: Context) -> some UIView {
        let webView = WKWebView()
        
        if let url = Bundle.main.url(forResource: "twofactor", withExtension: "html") {
            webView.loadFileURL(url, allowingReadAccessTo: url.deletingLastPathComponent())
        }
        
        return webView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}

#Preview {
    TwoFactorView {
        print("success")
    }
}
