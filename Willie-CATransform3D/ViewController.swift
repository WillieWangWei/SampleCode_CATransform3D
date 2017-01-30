//
//  ViewController.swift
//  Willie-CATransform3D
//
//  Created by 王炜 on 2017/1/30.
//  Copyright © 2017年 Jenova. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var imageView: UIImageView!
    
    override func viewDidLoad() {
        
        view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        
        guard let actualPath = Bundle.main.path(forResource: "test", ofType: "jpg") else { return }
        guard let actualImgae = UIImage.init(contentsOfFile: actualPath) else { return }
        
        imageView = UIImageView(image: actualImgae)
        imageView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        imageView.center = view.center
        view.addSubview(imageView)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.beginObserve()
        
        //        self.translate()
        //        self.scale()
        //        self.rotate()
        //        self.concat()
        //        self.invert()
        self.combine()
    }
}

extension ViewController {
    
    // 平移
    func translate() {
        
        let transformTranslation = CATransform3DMakeTranslation(0, 100, 0)
        
        UIView.animate(withDuration: 1) {
            self.imageView.layer.transform = transformTranslation
        }
    }
    
    // 缩放
    func scale() {
        
        let transformSclae = CATransform3DMakeScale(0.5, 0.5, 1)
        
        UIView.animate(withDuration: 1) {
            self.imageView.layer.transform = transformSclae
        }
    }
    
    // 旋转
    func rotate() {
        
        let transformRotation = CATransform3DMakeRotation(CGFloat(M_PI_4), 0, 0, 1)
        
        UIView.animate(withDuration: 1) {
            self.imageView.layer.transform = transformRotation
        }
    }
    
    // 叠加
    func concat() {
        
        let transformTranslation = CATransform3DMakeTranslation(200, 200, 0)
        let transformSclae = CATransform3DMakeScale(0.5, 0.5, 1)
        let transformConcat = CATransform3DConcat(transformTranslation, transformSclae)
        
        UIView.animate(withDuration: 1) {
            self.imageView.layer.transform = transformConcat
        }
    }
    
    // 反转
    func invert() {
        
        let transformSclae = CATransform3DMakeScale(0.5, 0.5, 1)
        let transformInvert = CATransform3DInvert(transformSclae)
        
        UIView.animate(withDuration: 1) {
            self.imageView.layer.transform = transformInvert
        }
    }
    
    // 综合Demo
    func combine() {
        
        let frontImageView = UIImageView(image: imageView.image)
        frontImageView.frame = imageView.bounds
        imageView.addSubview(frontImageView)
        
        let transformSclae = CATransform3DMakeScale(0.5, 0.5, 1)
        let transformRotation = CATransform3DMakeRotation(CGFloat(M_PI), 0, 0, 1)
        imageView.layer.transform = CATransform3DConcat(transformSclae, transformRotation)
        
        UIView.animate(withDuration: 1, animations: {
            self.imageView.layer.transform = CATransform3DIdentity
            
        }) { _ in
            
            UIView.animate(withDuration: 1, animations: {
                self.imageView.layer.transform = CATransform3DMakeTranslation(0, 100, 0)
                
            }, completion: { _ in
                
                frontImageView.layer.anchorPoint = CGPoint.init(x: 0.5, y: 0);
                frontImageView.frame.origin.y -= 100
                
                UIView.animate(withDuration: 1, animations: {
                    
                    var transform = CATransform3DIdentity
                    transform.m34 = -1 / 400.0
                    transform = CATransform3DRotate(transform, CGFloat(M_PI), 1, 0, 0)
                    frontImageView.layer.transform = transform
                })
            })
        }
    }
    
    // 监听frame
    func beginObserve() {
        
        print(imageView.frame)
        perform(#selector(ViewController.beginObserve), with: self, afterDelay: 0.1)
    }
}
