//
//  LoginView.swift
//  TwoFactorBridge
//
//  Created by Evelina Vorobyeva on 2025-12-10.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    let onLogin: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Please Login")
            TextField("Username", text: $username)
                .textFieldStyle(.roundedBorder)
                .autocorrectionDisabled()
                .autocapitalization(.none)
            SecureField("Password", text: $password)
                .textFieldStyle(.roundedBorder)
            Button("Login") {
                guard !username.isEmpty, !password.isEmpty else { return }
                onLogin()
            }
            .buttonStyle(.borderedProminent)
            .disabled(username.isEmpty || password.isEmpty)
            
        }.padding()
    }
}

#Preview {
    LoginView {
        print("logged in")
    }.preferredColorScheme(.dark)
}
