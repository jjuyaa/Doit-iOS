//
//  ViewController.swift
//  Navigation
//
//  Created by jjuyaa on 2021/01/11.
//

import UIKit

class ViewController: UIViewController, EditDelegate {
    
    let imgOn = UIImage(named: "lamp-on.png")
    let imgOff = UIImage(named: "lamp-off.png")
    
    var isOn = true
    
    @IBOutlet var txMessage: UITextField!
    @IBOutlet var imgView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        imgView.image = imgOn
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editViewController = segue.destination as! EditViewController
        if segue.identifier == "editButton" {
            // 버튼 클릭한 경우
            editViewController.textWayValue = "segue : use button"
        }
        else if segue.identifier == "editBarButton" {
            editViewController.textWayValue = "segue : use Bar button"
        }
        // 메인화면의 txMessage 수정화면에 전달
        editViewController.textMessage = txMessage.text!
        // 메인화면의 전구 onoff와 스위치 일치
        editViewController.isOn = isOn
        editViewController.delegate = self
    }
    
    func didMessageEditDone(_ controller: EditViewController, message: String) {
        txMessage.text = message
    }
    
    // 수정화면의 스위치 값을 메인화면에 전달하여 전구 켜짐여부 보여줌
    func didImageOnOffDone(_ controller: EditViewController, isOn: Bool) {
        if isOn {
            imgView.image = imgOn
            self.isOn = true
        }
        else {
            imgView.image = imgOff
            self.isOn = false
        }
    }
}
