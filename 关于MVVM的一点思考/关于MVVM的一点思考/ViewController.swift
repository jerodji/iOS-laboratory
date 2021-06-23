//
//  ViewController.swift
//  关于MVVM的一点思考
//
//  Created by Jerod on 2021/6/1.
//

import UIKit

class ViewController: UIViewController {

    @objc dynamic var viewModel = ViewModel()
    var observation: NSKeyValueObservation?
    
    @objc dynamic var name = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        let view = View(frame: CGRect(x: 20, y: 88, width: 100, height: 100))
        self.view.addSubview(view)

        bind(view: view, viewModel: viewModel)
    }

    func bind(view:View, viewModel:ViewModel) {
        
        // View -> ViewModel 的绑定, View把事件传给ViewModel
        view.numClickBlock = {
            self.viewModel.addAction()
        }
        
        // ViewModel -> View 的绑定，ViewModel把展示数据传给View更新
        viewModel.updatedBlock = { evt, numStr in
            view.numButton.setTitle(numStr, for: .normal)
        }
        /*
        // 或者
        observation = self.observe(\ViewController.viewModel.numStr, options: [.old, .new], changeHandler: { (object, change) in
            print("old \(change.oldValue!), new \(change.newValue!)")
            view.numButton.setTitle(change.newValue!, for: .normal)
        })
        */
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        viewModel.subAction()
    }
    
    
    deinit {
        viewModel.removeObserver(self, forKeyPath: "nameStr")
    }
}

