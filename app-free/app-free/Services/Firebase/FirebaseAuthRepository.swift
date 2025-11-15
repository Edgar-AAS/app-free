//
//  FirebaseAuthRepository.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import FirebaseAuth

protocol AuthRepositoryProtocol {
    func registerUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void)
}

final class FirebaseAuthRepository: AuthRepositoryProtocol {
    func registerUser(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
