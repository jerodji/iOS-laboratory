//
//  View.swift
//  关于MVVM的一点思考
//
//  Created by Jerod on 2021/6/1.
//

import UIKit

class View: UIView {

    let numButton = UIButton()
//    var name: String?
//    let viewModel = ViewModel()
//    let otherViewModel = OtherViewModel()
    
//    typealias NumBlock = () -> Void
//    var block: NumBlock?
    var numClickBlock: (() -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        numButton.backgroundColor = .red
        numButton.addTarget(self, action: #selector(numClick), for: .touchUpInside)
        numButton.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        addSubview(numButton)
        
        // ... other UI coding
        
//        bindViewModel()
    }
    
    @objc func numClick() {
//        viewModel.addAction()
//        self.numClickBlock()
//        self.numClickBlock?(self)
        self.numClickBlock?()
    }
    
//    func bindViewModel() {
//        viewModel.addObserver(self, forKeyPath: "numStr", options: .new, context: nil)
//    }
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "numStr" {
//            numButton.setTitle(viewModel.numStr, for: .normal)
//        }
//    }
    
//    deinit {
//        viewModel.removeObserver(self, forKeyPath: "numStr")
//    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
