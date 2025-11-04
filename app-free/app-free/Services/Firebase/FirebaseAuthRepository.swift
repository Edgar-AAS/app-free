//
//  FirebaseAuthRepository.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import FirebaseAuth

protocol AuthRepositoryProtocol {
    func registerUser(email: String, password: String) async throws
}

final class FirebaseAuthRepository: AuthRepositoryProtocol {
    func registerUser(email: String, password: String) async throws {
        try await Auth.auth().createUser(withEmail: email, password: password)
    }
}
