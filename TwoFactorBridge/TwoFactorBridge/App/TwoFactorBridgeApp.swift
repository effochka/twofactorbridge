//
//  TwoFactorBridgeApp.swift
//  TwoFactorBridge
//
//  Created by Evelina Vorobyeva on 2025-12-10.
//

import SwiftUI

enum AuthState {
    case loggedOut
    case waitingFor2FA
    case authenticated
}

@main
struct TwoFactorBridgeApp: App {
    @State private var authState: AuthState = .loggedOut
    
    var body: some Scene {
        WindowGroup {
            switch authState {
            case .loggedOut:
                LoginView {
                    authState = .waitingFor2FA
                }
            case .waitingFor2FA:
                TwoFactorView {
                    authState = .authenticated
                }
            case .authenticated:
                SuccessView {
                    authState = .loggedOut
                }
            }
        }
    }
}
