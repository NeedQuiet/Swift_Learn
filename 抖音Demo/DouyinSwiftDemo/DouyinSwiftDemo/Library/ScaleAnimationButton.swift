//
//  ScaleAnimationButton.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/12.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

class ScaleAnimationButton: UIButton {
    // 当View本身被添加到父识图之上时
    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        addTarget(self, action:#selector(toggleSelected), for: .touchUpInside)
    }
    
    @objc func toggleSelected(){
        isSelected.toggle()
    }
    
    override var isSelected: Bool {
        get {
            super.isSelected
        }
        
        set{
            super.transform = .init(scaleX: 0.8, y: 0.8)
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [.beginFromCurrentState,.transitionCrossDissolve], animations: {
                super.isSelected = newValue
                super.transform = .identity
            })
        }
    }
    
    
}
