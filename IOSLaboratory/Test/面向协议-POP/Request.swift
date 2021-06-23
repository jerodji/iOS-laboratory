//
//  Request.swift
//  IOSLaboratory
//
//  Created by Jerod on 2021/5/29.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

protocol Request {
//    var host: String { get }
    var path: String { get }
    
    var method: HTTPMethod { get }
    var parameter: [String: Any] { get }
    
//    associatedtype Response
//    func parse(data: Data) -> Response?
    associatedtype Response: Decodable
}

protocol Decodable {
    static func parse(data: Data) -> Self?
}

protocol Client {
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?) -> Void)

    var host: String { get }
}

struct URLSessionClient: Client {
    let host = "https://api.onevcat.com"
    
    func send<T: Request>(_ r: T, handler: @escaping (T.Response?) -> Void) {
        let url = URL(string: host.appending(r.path))!
        var request = URLRequest(url: url)
        request.httpMethod = r.method.rawValue
        
        let task = URLSession.shared.dataTask(with: request) {
            data, _, error in
            if let data = data, let res = T.Response.parse(data: data) {
                DispatchQueue.main.async { handler(res) }
            } else {
                DispatchQueue.main.async { handler(nil) }
            }
        }
        task.resume()
    }
}

//extension Request {
//    func send(handler: @escaping (Response?) -> Void) {
//        let url = URL(string: host.appending(path))!
//        var request = URLRequest(url: url)
//        request.httpMethod = method.rawValue
//
//        // 在示例中我们不需要 `httpBody`，实践中可能需要将 parameter 转为 data
//        // request.httpBody = ...
//
//        let task = URLSession.shared.dataTask(with: request) {
//            data, _, error in
//            if let data = data, let res = parse(data: data) {
//                DispatchQueue.main.async { handler(res) }
//            } else {
//                DispatchQueue.main.async { handler(nil) }
//            }
//        }
//        task.resume()
//    }
//}


