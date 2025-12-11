# TwoFactorBridge

A small app showing bidirectional communication between native Swift and a WebView using JavaScript injection.

## Overview

This app implements a 2FA flow:

1. Native login screen with username and password textfields (LoginView)
2. WebView based 2FA entry (HTML/JS) that captures a 6 digit code (TwoFactorView)
3. Bidirectional bridge that validates the code in native swift (WebViewBridge)
4. Success screen with logout functionality (SuccessView)

## Running
1. Open the project in Xcode and run
2. Any username/password works
3. Enter a 6 digit code to complete the flow
4. Run tests if needed

## Architecture
Native login -> Webview 2FA form -> Native payload Validation -> Feedback back to the Webview -> Success Screen
SwiftUI is used for all native screens


## Security notes

1. **Javascript injection** Always a security risk. Any script in webview can call message handlers. Currently, the HTML is bundled into the app and the payload is validated. In production, the origin should be validated and rate limited, to supress potential overflow.
2. **Man in the middle attacks** Remote content can be intercepted and modified. In production, things like certificate pinning (only trust server with matching certs or keys) and App Transport security can be used (ios feature that enforces Webview to use secure connections)
3. **Webviews should always be treated as untrusted code**
    Native logic should validate as much as possible.
4. **Whitelist allowed hosts** and block navigation from the webview to any unknown domains. 
5. All sensitive data should live in the keychain
6. Payloads should be encrypted or protected in transit in production
7. **Rate limiting** The user can only attempt a few times within time window, to prevent brute forcing

