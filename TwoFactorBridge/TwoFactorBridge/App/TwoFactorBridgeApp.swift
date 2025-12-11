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

//Coordinator pattern to handle different autorization states
@main
struct TwoFactorBridgeApp: App {
    @State private var authState: AuthState = .loggedOut
    
    var body: some Scene {
        WindowGroup {
            switch authState {
            case .loggedOut:
                LoginView {
                    withAnimation {
                        authState = .waitingFor2FA
                    }
                }.transition(.opacity)
            case .waitingFor2FA:
                TwoFactorView {
                    withAnimation {
                        authState = .authenticated
                    }
                }.transition(.opacity)
            case .authenticated:
                SuccessView {
                    withAnimation {
                        authState = .loggedOut
                    }
                }.transition(.opacity)
            }
        }
    }
}
