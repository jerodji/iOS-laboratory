//
//  NumChineseDialog.swift
//  SimpleVerify
//
//  Created by Jerod on 2021/3/5.
//

import UIKit

let _ScreenWidth    = UIScreen.main.bounds.size.width
let _ScreenHeight   = UIScreen.main.bounds.size.height

let _PingFangSCRegular  = "PingFangSC-Regular"
let _PingFangSCMedium   = "PingFangSC-Medium"
let _PingFangSCSemibold = "PingFangSC-Semibold"



@objc protocol NumChineseDialogDelegate: AnyObject {
    @objc func verifySuccess()
    @objc func verifyFailure(clickArr:[String])
    @objc optional func verifyChineseButtonClicked(clkickArr:[String], chinese:String, selected:Bool)
}


@objc class NumChineseDialog: UIView {
    
    @objc weak var delegate: NumChineseDialogDelegate?
    private(set) var mgr : NumChineseManager?
    
    let closeBtn = UIButton(type: .custom)
    let wrap = UIView()
    let titleLabel = UILabel()
    let desLabel = UILabel()
    let bgImgView = UIImageView()
    let resetButton = UIButton(type: .custom)
    
    var verifyNum = 4
    var showNum = 6
    var clickArr: [String] = []
    
    private let _WrapWidth = CGFloat(310.0)
    private let _WrapHeight = CGFloat(316.0)
    private let _bundle = Bundle(path: Bundle.main.path(forResource: "NumChinese", ofType: "bundle")!)
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        renderUI(4, 6) // default 4,6
    }
    
    init(verify: Int, show: Int) {
        super.init(frame: UIScreen.main.bounds)
        renderUI(verify, show)
    }
    
    private func renderUI(_ v:Int, _ s:Int) {
        verifyNum = v
        showNum = s
        
        self.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.68)
        
        wrap.backgroundColor = .white
        wrap.frame = CGRect(x: (_ScreenWidth - _WrapWidth)/2.0, y: (_ScreenHeight - _WrapHeight)/2.0, width: _WrapWidth, height: _WrapHeight)
        wrap.layer.cornerRadius = 13
        self.addSubview(wrap)
        
        closeBtn.addTarget(self, action: #selector(closeAction), for: .touchUpInside)
        closeBtn.setImage(UIImage(named: "icn_close@2x", in: _bundle, compatibleWith: nil), for: .normal)
        closeBtn.frame = CGRect(x: wrap.frame.origin.x + wrap.frame.size.width - 29, y: wrap.frame.origin.y - 12 - 29, width: 29, height: 29)
        self.addSubview(closeBtn)
        
        // titleLabel
        titleLabel.text = "为防止误操作，请进行验证"
        titleLabel.font = UIFont(name: _PingFangSCSemibold, size: 18)
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.frame = CGRect(x: 15, y: 20, width: _WrapWidth-15-15, height: 25)
        wrap.addSubview(titleLabel)
        
        // desLabel
        desLabel.numberOfLines = 0
        desLabel.textAlignment = .center
        desLabel.frame = CGRect(x: 15, y: 55, width: _WrapWidth-15-15, height: 20)
        wrap.addSubview(desLabel)
        
        // bgImgView
        bgImgView.image = UIImage(named: "bc@2x", in: _bundle, compatibleWith: nil)
        bgImgView.frame = CGRect(x: 15, y: 87, width: 280, height: 166)
        wrap.addSubview(bgImgView)
        
        // resetButton
        resetButton.setTitle("换一组", for: .normal)
        resetButton.setTitleColor(UIColor(red: 0.61, green: 0.61, blue: 0.61, alpha: 1), for: .normal)
        resetButton.setImage(UIImage(named: "reset@2x", in: _bundle, compatibleWith: nil), for: .normal)
        resetButton.titleLabel?.font = UIFont(name: _PingFangSCMedium, size: 14)
        resetButton.addTarget(self, action: #selector(resetAction), for: .touchUpInside)
        resetButton.frame = CGRect(x: 124, y: 273, width: 64, height: 20)
        wrap.addSubview(resetButton)
        
        mgr = NumChineseManager(verify: verifyNum, show: showNum)
        print(mgr!.correctNumArr,"\n",mgr!.correctArr,"\n",mgr!.chineseArr)
        renderDescTitle()
        renderShowButtons()
    }
    
    private func renderDescTitle() {
        if mgr == nil {
            return
        }
        
        if mgr!.correctNumArr.count != verifyNum {
            NSLog("数据错误")
            return
        }
        
        var str = " "
        for i in 0..<mgr!.correctNumArr.count {
            let s = mgr!.correctNumArr[i]
            str.append(s)
            str.append(" ")
        }
        
        let string = "请选择" + str + "对应繁体字"
        let ns = NSString(string: string)
        let range1 = ns.range(of: "请选择")
        let range2 = ns.range(of: str)
        let range3 = ns.range(of: "对应繁体字")
        
        let attrString = NSMutableAttributedString(string: string)
        
        attrString.addAttributes([
            .font: UIFont(name: _PingFangSCMedium, size: 14) as Any,
            .foregroundColor: UIColor(red: 0.29, green: 0.29, blue: 0.29,alpha:1)
        ], range: range1)
        
        attrString.addAttributes([
            .font: UIFont(name: _PingFangSCMedium, size: 14) as Any,
            .foregroundColor: UIColor(red: 0.16, green: 0.74, blue: 0.44,alpha:1)
        ], range: range2)
        
        attrString.addAttributes([
            .font: UIFont(name: _PingFangSCMedium, size: 14) as Any,
            .foregroundColor: UIColor(red: 0.29, green: 0.29, blue: 0.29,alpha:1)
        ], range: range3)
        
        desLabel.attributedText = attrString
    }
    
    private func renderShowButtons() {
        if mgr == nil {
            return
        }
        
        for item in bgImgView.subviews {
            item.removeFromSuperview()
        }
        
        self.bgImgView.isUserInteractionEnabled = true
        for i in 0..<mgr!.chineseArr.count {
            let s = mgr!.chineseArr[i]
            let btn = UIButton(type: .custom)
            btn.tag = 100 + i
            btn.setTitle(s, for: .normal)
            btn.setTitleColor(.white, for: .normal)
            btn.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            btn.layer.cornerRadius = 4
            btn.addTarget(self, action: #selector(chineseButtonClick(_:)), for: .touchUpInside)
            
            let a = Int(i/3)
            let b = i%3
            btn.frame = CGRect(x: 40 + b*(60+10), y: 18 + a*(60+10), width: 60, height: 60)
            self.bgImgView.addSubview(btn)
        }
    }
    
    @objc private func chineseButtonClick(_ sender:UIButton) {
        if mgr == nil {
            return
        }
        
        let tag = sender.tag - 100
        let str = mgr!.chineseArr[tag]
        if sender.isSelected {
            sender.isSelected = false
            sender.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3)
            if clickArr.contains(str) {
                clickArr.removeAll(where: {$0 == str})
            }
            
            delegate?.verifyChineseButtonClicked?(clkickArr: clickArr, chinese: str, selected: false)
            
        } else {
            sender.isSelected = true
            sender.backgroundColor = UIColor(red: 1, green: 1, blue: 1, alpha: 0.29)
            clickArr.append(str)
            
            delegate?.verifyChineseButtonClicked?(clkickArr: clickArr, chinese: str, selected: true)
        }
        
        if clickArr.count == verifyNum {
            for i in 0..<mgr!.correctArr.count {
                let c = mgr!.correctArr[i]
                let s = clickArr[i]
                if c != s {
                    delegate?.verifyFailure(clickArr: clickArr)
//                    resetAction()
                    self.perform(#selector(resetAction), with: nil, afterDelay: 0.5)
                    return
                }
            }
            
            delegate?.verifySuccess()
//            dismiss()
            self.perform(#selector(dismiss), with: nil, afterDelay: 0.5)
            return
        }
    }
    
    @objc private func closeAction() {
        dismiss()
    }
    
    @objc private func resetAction() {
        mgr = NumChineseManager(verify: verifyNum, show: showNum)
        print(mgr!.correctNumArr,"\n",mgr!.correctArr,"\n",mgr!.chineseArr)
        clickArr.removeAll()
        renderDescTitle()
        renderShowButtons()
    }
    
    // MARK:- Public Methods
    
    @objc public func show() {
        self.frame = CGRect(x: 0, y: 0, width: _ScreenWidth, height: _ScreenHeight)
        UIApplication.shared.keyWindow?.addSubview(self)
    }
    
    @objc public func dismiss() {
        self.removeFromSuperview()
    }
    
}
