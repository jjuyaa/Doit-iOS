//
//  ViewController.swift
//  MoviePlayer
//
//  Created by jjuyaa on 2021/01/23.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func btnPlayInternalMovie(_ sender: UIButton) {
        // 비디오 파일명 사용하여 비디오 저장된 앱 내부의 파일 경로 받아옴
        let filePath: String? = Bundle.main.path(forResource: "FastTyping", ofType: "mp4")
        let url = NSURL(fileURLWithPath: filePath!)
        
        playVideo(url: url)
    }
    
    @IBAction func btnPlayExternalMovie(_ sender: UIButton) {
        let url = NSURL(string: "https://dl.dropboxusercontent.com/s/e3auz050w2mvud/FireWorks.mp4")!
        
        playVideo(url: url)
    }
    
    // url을 인수로 받는 비디오 재생하는 함수
    private func playVideo(url: NSURL) {
        let playerController = AVPlayerViewController()
        
        // AVPlayer의 인스턴스 생성
        let player = AVPlayer(url: url as URL)
        // AVPlayerViewController의 player속성에서 생성한 AVPlayer 인스턴스 할당
        playerController.player = player
        
        // 비디오 재생
        self.present(playerController, animated: true) {
            player.play()
        }
    }
}
