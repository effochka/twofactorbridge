//  SuccessView.swift
//  TwoFactorBridge
//
//  Created by Evelina Vorobyeva on 2025-12-10.
//

import SwiftUI

struct SuccessView: View {
    let onLogout: () -> Void
    
    var body: some View {
        VStack(spacing: 16) {
            Text("Congratulations! You are now authenticated.")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
            
            Button("Logout") {
                onLogout()
            }
            .buttonStyle(.borderedProminent)
            .tint(.red)
        }
        .padding()
    }
}

#Preview {
    SuccessView {
        print("logged out")
    }
}
