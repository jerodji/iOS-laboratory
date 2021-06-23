//
//  ViewModel.swift
//  关于MVVM的一点思考
//
//  Created by Jerod on 2021/6/1.
//

import UIKit

class ViewModel: NSObject {
    
    private let model = Model()
    
    @objc dynamic var numStr: String = ""
    
    var updatedBlock: ((String, String) -> ())?
    
    override init() {
        super.init()
        model.num = 10;
        numStr = "10"
    }
    
    func addAction() {
        model.num! += 1
        numStr = String(model.num!);
        updatedBlock?("add", numStr)
    }
    
    func subAction() {
        model.num! -= 1;
        numStr = String(model.num!);
        updatedBlock?("sub", numStr)
    }
}
