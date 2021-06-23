//
//  UserRequest.swift
//  IOSLaboratory
//
//  Created by Jerod on 2021/5/29.
//

import Foundation

struct UserRequest: Request {
    
    let name: String
    
//    let host = "https://api.onevcat.com"
    var path: String {
        return "/users/\(name)"
    }
    let method: HTTPMethod = .GET
    let parameter: [String: Any] = [:]
    
    typealias Response = User
//    func parse(data: Data) -> User? {
//        return User(data: data)
//    }
}



