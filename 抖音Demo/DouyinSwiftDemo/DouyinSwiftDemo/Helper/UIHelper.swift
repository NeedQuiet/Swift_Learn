//
//  UIHelper.swift
//  DouyinSwiftDemo
//
//  Created by 许一宁 on 2020/4/12.
//  Copyright © 2020 许一宁. All rights reserved.
//

import UIKit

var layers = [CAShapeLayer]()//动画层

extension UIView {
    // 用 @IBInspectable public，xib里会增加corerRadius属性
    @IBInspectable public var corerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable public var boarderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable public var borderColor: UIColor {
        get {
            return UIColor(cgColor: layer.borderColor!)
        }
        set {
            layer.borderColor = newValue.cgColor
        }
    }
    
    func raiseAnimate(imaName: String, delay: TimeInterval) {
        //1. 贝塞尔曲线
        let path = UIBezierPath()
        
        // 起点: 再视图的中间
        let beginPoint = CGPoint(x: bounds.midX, y:bounds.midY)
        
        // 控制点的位移， 随机数
        let a : CGFloat = 2
        let b : CGFloat = 1.5
        let c : CGFloat = 3
        
        let offset1 = [a,b,c]
        
        let controlXOffset = offset1.randomElement()! * bounds.maxX
        let controlYOffset = offset1.randomElement()! * bounds.maxY
        
        // 终点的位移，随机数
        let e :CGFloat = 1.5
        let d :CGFloat = 1
        let f :CGFloat = 0.8
        
        let offset2 = [e,d,f]
        
        let g :CGFloat = 2.5
        let h :CGFloat = 3
        let i :CGFloat = 2
        
        let offset3 = [g,h,i]
        
        let endXOffSet = offset2.randomElement()! * bounds.maxY
        let endYOffSet = offset3.randomElement()! * bounds.maxY
        
        // 终点
        let endPoint = CGPoint(x:beginPoint.x - endXOffSet, y:beginPoint.y - endYOffSet)
        
        // 控制点
        let controlPoint = CGPoint(x:beginPoint.x - controlXOffset, y:beginPoint.y - controlYOffset)
        
        path.move(to:beginPoint)
        path.addQuadCurve(to: endPoint, controlPoint: controlPoint)
        
        //2. 动画组
        let group = CAAnimationGroup()
        group.duration = 4 // 动画持续时间
        group.beginTime = CACurrentMediaTime() + delay
        group.repeatCount = .infinity // 无限循环
        group.isRemovedOnCompletion = false // 是否自动移除
        group.fillMode = .forwards // 动画填充方式：向前填充
        group.timingFunction = CAMediaTimingFunction(name: .linear) // 线性动画
        
        let pathAnimation = CAKeyframeAnimation(keyPath: "position") // 关键帧动画
        pathAnimation.path = path.cgPath
        
        let rotateAnimation = CAKeyframeAnimation(keyPath: "transform.rotation") // 旋转
        rotateAnimation.values = [0,.pi / 2.0,.pi / 1.0]
        
        let alphaAnimation = CAKeyframeAnimation(keyPath: "opacity")// 透明度
        alphaAnimation.values = [0, 0.3, 1, 0.3, 0]
        
        let scaleAnimation = CAKeyframeAnimation(keyPath: "transform.scale")// 缩放
        scaleAnimation.values = [1.0,1.8,2.0]
        
        // 将关键帧动画加入动画组里
        group.animations = [pathAnimation,rotateAnimation,alphaAnimation,scaleAnimation]
        
        //3. 新建layer
        let layer = CAShapeLayer()
        layer.opacity = 0
        layer.contents = UIImage(named: imaName)?.cgImage
        layer.frame = CGRect(origin: beginPoint, size: CGSize(width: 10, height: 10))
        
        // 将新建的layer加到当前视图上
        self.layer.addSublayer(layer)
        // 把之前的动画组加至该layer上
        layer.add(group, forKey: nil)
        // 再把此layer存入layers的组里保存
        layers.append(layer)
    }
    
    func resetAnimation() {
        // 清除layers
        for layer in layers {
            layer.removeFromSuperlayer()
        }
        // 层上所有动画全部清除
        self.layer.removeAllAnimations()
        
        layers.removeAll()
    }
}
