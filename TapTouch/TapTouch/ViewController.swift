//
//  ViewController.swift
//  TapTouch
//
//  Created by jjuyaa on 2021/02/01.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var txtMessage: UILabel!
    @IBOutlet var txtTapCount: UILabel!
    @IBOutlet var txtTouchCount: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    // touch start
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // 현재 발생한 터치 이벤트 가져옴
        let touch = touches.first! as UITouch
        txtMessage.text = "Touches Began"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    // 손가락 움직였을 때 호출
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        txtMessage.text = "Touches Moved"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
    
    // 화면에서 손가락 떼었을 때 호출
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first! as UITouch
        txtMessage.text = "Touches Ended"
        txtTapCount.text = String(touch.tapCount)
        txtTouchCount.text = String(touches.count)
    }
}
