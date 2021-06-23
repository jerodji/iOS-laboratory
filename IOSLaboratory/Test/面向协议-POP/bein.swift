//
//  bein.swift
//  IOSLaboratory
//
//  Created by Jerod on 2021/5/29.
//

import Foundation

class Begin: NSObject {
    func req() -> Void {
        
//        let request = UserRequest(name: "onevcat")
//        request.send { user in
//            if let user = user {
//                print("\(user.message) from \(user.name)")
//            }
//        }
        
        
        URLSessionClient().send(UserRequest(name: "onevcat")) { user in
            if let user = user {
                print("\(user.message) from \(user.name)")
            }
        }
        
        
    }
}


