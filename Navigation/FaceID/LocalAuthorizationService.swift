//
//  LocalAuthorizationService.swift
//  Navigation
//
//  Created by netlanc on 25.04.2024.
//

import Foundation
import LocalAuthentication

class LocalAuthorizationService: NSObject {
    
    static let defaultService = LocalAuthorizationService()
    
    private var context = LAContext()
    
    var isFaceIDAvailable: Bool {
        context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    func authorizeIfPossible(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Проверимся") { success, error in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                    completion(false)
                } else {
                    completion(success)
                }
            }
        }
    }
}
