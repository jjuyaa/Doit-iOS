//
//  ViewController.swift
//  ImageViewPractice
//
//  Created by jjuyaa on 2020/12/29.
//

import UIKit

class ViewController: UIViewController {
    
    var imageNum = 1
    var maxImageNum = 6
    
    @IBOutlet var imgGallery: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLeftImage(_ sender: UIButton) {
        imageNum = imageNum - 1
        if (imageNum < 1) {
            imageNum = maxImageNum
        }
        
        let imageName = String(imageNum) + ".png"
        imgGallery.image = UIImage(named: imageName)
    }
    
    @IBAction func btnRightImage(_ sender: UIButton) {
        imageNum = imageNum + 1
        if (imageNum > maxImageNum) {
            imageNum = 1
        }
        
        let imageName = String(imageNum) + ".png"
        imgGallery.image = UIImage(named: imageName)
    }
}
