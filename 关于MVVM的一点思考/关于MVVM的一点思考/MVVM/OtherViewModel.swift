//
//  OtherViewModel.swift
//  关于MVVM的一点思考
//
//  Created by Jerod on 2021/6/1.
//

import UIKit

class OtherViewModel: NSObject {
    
    private let model = Model()
    
    var otherNumStr: String = ""
    
    override init() {
        super.init()
        model.num = 99;
    }
    
    
    
}
