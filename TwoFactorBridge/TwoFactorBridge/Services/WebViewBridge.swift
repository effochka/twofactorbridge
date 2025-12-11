//
//  WebViewBridge.swift
//  TwoFactorBridge
//
//  Created by Evelina Vorobyeva on 2025-12-11.
//

import Foundation
import WebKit

class WebViewBridge: NSObject, WKScriptMessageHandler {
    let onAuthenticated: () -> Void
    weak var webView: WKWebView?
    
    init(onAuthenticated: @escaping () -> Void) {
        self.onAuthenticated = onAuthenticated
    }
    
    //Parcing the message and validating it
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        guard message.name == "twoFactor",
              let body = message.body as? [String: Any],
              let code = body["code"] as? String,
              let timestamp = body["timestamp"] as? TimeInterval else {
            return
        }
        
        let payload = Payload(code: code, timestamp: timestamp)
        let payloadValid = validatePayload(payload: payload)
        if payloadValid {
            webView?.evaluateJavaScript("handleResult(true);")
            
            //1 second delay to give feedback to the user before moving to the next screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.onAuthenticated()
            }
        } else {
            webView?.evaluateJavaScript("handleResult(false);")
        }
    }
    
    //Validation rules: code is numeric, timestamp is not older than 5 minutes old
    public func validatePayload(payload: Payload) -> Bool {
        let code = payload.code
        guard code.count == 6, code.allSatisfy({$0.isNumber}) else {
            print()
            return false
        }
        
        let now = Date().timeIntervalSince1970
        guard payload.timestamp <= now && now - payload.timestamp <= 300 else {
            return false
        }
        return true
    }
}
