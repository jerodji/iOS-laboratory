//
//  User.swift
//  IOSLaboratory
//
//  Created by Jerod on 2021/5/29.
//

// User.swift
import Foundation

struct User {
    let name: String
    let message: String
    
    init?(data: Data) {
        guard let obj = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
            return nil
        }
        guard let name = obj["name"] as? String else {
            return nil
        }
        guard let message = obj["message"] as? String else {
            return nil
        }
        
        self.name = name
        self.message = message
    }
}

extension User: Decodable {
    static func parse(data: Data) -> User? {
        return User(data: data)
    }
}
