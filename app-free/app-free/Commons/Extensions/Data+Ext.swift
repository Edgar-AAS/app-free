//
//  Data+Decoding.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

extension Data {
    func toModel<T: Decodable>() -> T? {
        guard let data = try? JSONDecoder().decode(T.self, from: self) else {
            return nil
        }
        return data
    }
}
