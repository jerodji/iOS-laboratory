//
//  ViewController.swift
//  VerifyNum
//
//  Created by Jerod on 2021/3/6.
//

import UIKit

class ViewController: UIViewController, NumChineseDialogDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.view.backgroundColor = .white
        
        let btn = UIButton(type: .custom)
        btn.setTitle("开始验证", for: .normal)
        btn.backgroundColor = .systemPink
        btn.addTarget(self, action: #selector(btnClick(_:)), for: .touchUpInside)
        btn.frame = CGRect(x: 10, y: 100, width: 100, height: 50)
        self.view.addSubview(btn)
        
        
    }

    @objc func btnClick(_ sender:UIButton) {
         
        let dialog = NumChineseDialog(verify: 4, show: 6)
        dialog.delegate = self
        dialog.show()
        
    }

    func verifySuccess() {
        NSLog("bingo")
    }
    
    func verifyFailure(clickArr: [String]) {
        NSLog("error %@", clickArr)
    }
    
//    func verifyChineseButtonClicked(clkickArr: [String], chinese: String, selected: Bool) {
//
//    }
    
}

