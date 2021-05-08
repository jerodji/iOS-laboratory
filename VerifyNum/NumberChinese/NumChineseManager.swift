//
//  NumChineseManager.swift
//  SimpleVerify
//
//  Created by Jerod on 2021/3/5.
//

import UIKit

@objc class NumChineseManager: NSObject {
    
    /// 缓存正确的4个结果 数字
    private(set) var correctNumArr : [String] = []
    /// 缓存正确的4个结果 中文
    private(set) var correctArr : [String] = []
    /// 显示的6个中文
    private(set) var chineseArr : [String] = []
    
    
    override init() {
        super.init()
        configData()
    }
    
    /// 初始化方法
    /// - Parameters:
    ///   - result: 需要校验的个数, 默认4
    ///   - show: 选择的个数, 默认6
    init(verify:Int, show:Int) {
        super.init()
        configData(verify, show)
    }
    
    func configData(_ verify:Int=4, _ show:Int=6) {
        var data: [[String]] = [
            ["零","0"],
            ["壹","1"],["貳","2"],["叁","3"],
            ["肆","4"],["伍","5"],["陆","6"],
            ["柒","7"],["捌","8"],["玖","9"]
        ]
        
        if verify >= data.count || show >= data.count || verify == 0 || show == 0 {
            NSLog("参数错误, 范围应为[1,10]")
            return
        }
        if verify > show {
            NSLog("所需参数个数应≤显示个数")
            return
        }
        
        var arr: [String] = []
        var str: [String] = []
        var showArr: [String] = []
        
        while showArr.count < show {
            let i = randomIndex(from: 0, to: data.count-1)
            let el = data[i]
            if arr.count < verify {
                arr.append(el[0])
                str.append(el[1])
                showArr.append(el[0])
            } else {
                let j = randomIndex(from: 0, to: showArr.count)
                showArr.insert(el[0], at: j)
            }
            data.remove(at: i)
        }
        
        correctNumArr = str
        correctArr = arr
        chineseArr = showArr
    }
    
    func randomIndex(from:Int, to:Int) -> Int {
        return from + (Int(arc4random()) % (to - from + 1) )
    }
    
    
}
