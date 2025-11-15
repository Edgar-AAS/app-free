//
//  FirebaseLoginRepository.swift
//  app-free
//
//  Created by Lidia on 05/11/25.
//

import FirebaseAuth

protocol LoginRepositoryProtocol {
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    )
}

final class FirebaseLoginRepository: LoginRepositoryProtocol {
    func signIn(
        email: String,
        password: String,
        completion: @escaping (Result<Void, Error>) -> Void
    ) {
        Auth.auth().signIn(withEmail: email, password: password) { _, error in
            if let error = error {
                completion(.failure(error))
            } else {
                completion(.success(()))
            }
        }
    }
}
