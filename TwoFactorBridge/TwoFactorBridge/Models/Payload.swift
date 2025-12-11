//
//  twofactorpayload.swift
//  TwoFactorBridge
//
//  Created by Evelina Vorobyeva on 2025-12-11.
//

import Foundation

struct Payload: Codable {
    let code: String
    let timestamp: TimeInterval
}
