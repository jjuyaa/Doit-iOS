//
//  ViewController.swift
//  DrawGraphics
//
//  Created by jjuyaa on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawFlower()
    }

    func drawFlower() {
        UIGraphicsBeginImageContext(imgView.frame.size)
        let context = UIGraphicsGetCurrentContext()!
        
        // draw stem
        context.setLineWidth(4.0)
        context.setFillColor(UIColor.green.cgColor)
        context.setStrokeColor(UIColor.green.cgColor)
        
        context.move(to: CGPoint(x: 170, y: 200))
        context.addLine(to: CGPoint(x: 200, y: 450))
        context.addLine(to: CGPoint(x: 140, y: 450))
        context.addLine(to: CGPoint(x: 170, y: 200))
        context.fillPath()
        context.strokePath()
        
        // draw leaves
        context.setLineWidth(4.0)
        context.setStrokeColor(UIColor.red.cgColor)
        
        context.addEllipse(in: CGRect(x: 120, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120+50, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120-50, y: 150, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120, y: 150-50, width: 100, height: 100))
        context.addEllipse(in: CGRect(x: 120, y: 150+50, width: 100, height: 100))
        context.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
}
