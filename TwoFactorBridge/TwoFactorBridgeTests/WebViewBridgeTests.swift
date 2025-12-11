//
//  WebViewBridgeTests.swift
//  TwoFactorBridge
//
//  Created by Evelina Vorobyeva on 2025-12-11.
//

import Testing

@testable import TwoFactorBridge
import Foundation

//Several tests to test the payload validation functionality
struct WebViewBridgeTests {
    
    @Test("Valid 6 digit code")
    func valideCodePasses() async throws {
        let bridge = await WebViewBridge(onAuthenticated: {})
        
        let payload = Payload(
            code: "111111",
            timestamp: Date().timeIntervalSince1970
        )
        
        let result = await bridge.validatePayload(payload: payload)
        
        #expect(result == true)
    }
    
    @Test("Invalid 5 digit code")
    func shortCodeFails() async throws {
        let bridge = await WebViewBridge(onAuthenticated: {})
        
        let payload = Payload(
            code: "11111",
            timestamp: Date().timeIntervalSince1970
        )
        
        let result = await bridge.validatePayload(payload: payload)
        
        #expect(result == false)
    }
    
    @Test("Invalid 7 digit code")
    func longCodeFails() async throws {
        let bridge = await WebViewBridge(onAuthenticated: {})
        
        let payload = Payload(
            code: "1234567",
            timestamp: Date().timeIntervalSince1970
        )
        
        let result = await bridge.validatePayload(payload: payload)
        
        #expect(result == false)
    }
    
    @Test("Invalid alphabetical code")
    func lettersCodeFails() async throws {
        let bridge = await WebViewBridge(onAuthenticated: {})
        
        let payload = Payload(
            code: "aaaaaa",
            timestamp: Date().timeIntervalSince1970
        )
        
        let result = await bridge.validatePayload(payload: payload)
        
        #expect(result == false)
    }
    
    @Test("Valid current timestamp ")
    func currentTimestampPassesValidation() async throws {
        
        let bridge = await WebViewBridge(onAuthenticated: {})
        let now = Date().timeIntervalSince1970
        let payload = Payload(
            code: "111111",
            timestamp: now
        )
        
        let result = await bridge.validatePayload(payload: payload)
        
        #expect(result == true)
    }
    
    @Test("Invalid old timestamp ")
    func oldTimestampFailsValidation() async throws {
        
        let bridge = await WebViewBridge(onAuthenticated: {})
        let now = Date().timeIntervalSince1970 - 360
        let payload = Payload(
            code: "111111",
            timestamp: now
        )
        
        let result = await bridge.validatePayload(payload: payload)
        
        #expect(result == false)
    }
}
