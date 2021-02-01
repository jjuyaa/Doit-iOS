//
//  ViewController.swift
//  DrawGraphicsChapter17
//
//  Created by jjuyaa on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var setLineWidthButton: UIButton!
    
    var lastPoint: CGPoint!
    var lineSize: CGFloat = 2.0
    var lineColor = UIColor.red.cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        setLineWidthButton.setTitle("두께 2", for: .normal)
    }

    @IBAction func clearImgViewButton(_ sender: UIButton) {
        imgView.image = nil
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        
        lastPoint = touch.location(in: imgView)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        let touch = touches.first! as UITouch
        let currPoint = touch.location(in: imgView)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: currPoint.x, y: currPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        lastPoint = currPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        UIGraphicsBeginImageContext(imgView.frame.size)
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
        UIGraphicsGetCurrentContext()?.setLineCap(CGLineCap.round)
        UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
        
        imgView.image?.draw(in: CGRect(x: 0, y: 0, width: imgView.frame.size.width, height: imgView.frame.size.height))
        
        UIGraphicsGetCurrentContext()?.move(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.addLine(to: CGPoint(x: lastPoint.x, y: lastPoint.y))
        UIGraphicsGetCurrentContext()?.strokePath()
        
        imgView.image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
    }
    
    @IBAction func setLineBlackButton(_ sender: UIButton) {
        lineColor = UIColor.black.cgColor
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
    }
    
    @IBAction func setLineRedButton(_ sender: UIButton) {
        lineColor = UIColor.red.cgColor
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
    }
    
    @IBAction func setLineGreenButton(_ sender: UIButton) {
        lineColor = UIColor.green.cgColor
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
    }
    
    @IBAction func setLineBlueButton(_ sender: UIButton) {
        lineColor = UIColor.blue.cgColor
        UIGraphicsGetCurrentContext()?.setStrokeColor(lineColor)
    }
    
    @IBAction func setLineWidthButton(_ sender: UIButton) {
        if lineSize == 2.0 {
            lineSize = 4.0
            UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
            setLineWidthButton.setTitle("두께 4", for: .normal)
        }
        else {
            lineSize = 2.0
            UIGraphicsGetCurrentContext()?.setLineWidth(lineSize)
            setLineWidthButton.setTitle("두께 2", for: .normal)
        }
    }
}
