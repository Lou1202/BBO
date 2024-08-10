//
//  SharpImageView.swift
//  playerCard
//
//  Created by 楊曜安 on 2023/3/30.
//

import UIKit

class SharpImageView: UIImageView {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: bounds.width * 0.2, y: 0))
        path.addLine(to: CGPoint(x: bounds.width, y: 0))
        path.addLine(to: CGPoint(x: bounds.width * 0.8, y:bounds.height))
        path.addLine(to: CGPoint(x: 0, y: bounds.height))
        path.close()
        let shapeLayer = CAShapeLayer()
        shapeLayer.path = path.cgPath
        layer.mask = shapeLayer
        
    }
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
