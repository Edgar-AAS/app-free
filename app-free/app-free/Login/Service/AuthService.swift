//
//  AuthService.swift
//  app-free
//
//  Created by Lidia on 03/11/25.
//

import FirebaseAuth

protocol AuthServiceProtocol {
    func signIn(email: String, password: String) async throws
}

final class AuthService: AuthServiceProtocol {
    func signIn(email: String, password: String) async throws {
        _ = try await Auth.auth().signIn(withEmail: email, password: password)
    }
}
