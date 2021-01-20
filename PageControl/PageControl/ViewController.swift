//
//  ViewController.swift
//  PageControl
//
//  Created by jjuyaa on 2021/01/11.
//

import UIKit

var images = ["01.png", "02.png", "03.png", "04.png", "05.png", "06.png"]

class ViewController: UIViewController {
    @IBOutlet var imgView: UIImageView!
    @IBOutlet var pageControl: UIPageControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        pageControl.numberOfPages = images.count
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.green // 페이지컨트롤 페이지 표시부분 색상 의미
        pageControl.currentPageIndicatorTintColor = UIColor.red // 페이지컨트롤 현재 페이지 표시 색상
        imgView.image = UIImage(named: images[0])
    }
    
    // pageControl Action func
    @IBAction func pageChange(_ sender: UIPageControl) {
        imgView.image = UIImage(named: images[pageControl.currentPage])
    }
    

}

