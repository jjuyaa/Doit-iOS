//
//  ViewController.swift
//  Audio
//
//  Created by jjuyaa on 2021/01/18.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate, AVAudioRecorderDelegate {

    var audioPlayer: AVAudioPlayer!
    var audioFile: URL!
    var MAX_VOLUME: Float = 10.0
    var progressTimer: Timer!
    
    // 재생 타이머 위한 상수
    let timePlayerSelector: Selector = #selector(ViewController.updatePlayTime)
    // 녹음 타이머 위한 상수
    let timeRecordSelector: Selector = #selector(ViewController.updateRecordTime)
    
    @IBOutlet var pvProgressPlay: UIProgressView!
    @IBOutlet var lblCurrentTime: UILabel!
    @IBOutlet var lblEndTime: UILabel!
    @IBOutlet var btnPlay: UIButton!
    @IBOutlet var btnPause: UIButton!
    @IBOutlet var btnStop: UIButton!
    @IBOutlet var slVolume: UISlider!
    
    @IBOutlet var btnRecord: UIButton!
    @IBOutlet var lblRecordTime: UILabel!
    
    var audioRecorder: AVAudioRecorder!
    var isRecordMode = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
 
        selectAudioFile()
        if !isRecordMode {
            initPlay()
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
        }
        else {
            initRecord()
        }
    }

    func selectAudioFile() {
        // 녹음모드 아닐 때 사용
        if !isRecordMode {
            audioFile = Bundle.main.url(forResource: "Sicilian_Breeze", withExtension: "mp3")
        }
        else {
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            audioFile = documentDirectory.appendingPathComponent("recordFile.m4a")
        }
    }
    
    // 녹음 위해 초기화하는 함수
    func initRecord() {
        let recordSettings = [
            AVFormatIDKey: NSNumber(value:kAudioFormatAppleLossless as UInt32),
            AVEncoderAudioQualityKey: AVAudioQuality.max.rawValue,
            AVEncoderBitRateKey: 320000,
            AVNumberOfChannelsKey: 2,
            AVSampleRateKey: 44100.0] as [String: Any]
        
        do {
            audioRecorder = try AVAudioRecorder(url: audioFile, settings: recordSettings)
        } catch let error as NSError {
            print("Error-initRecord: \(error)")
        }
        
        audioRecorder.delegate = self
        
        slVolume.value = 1.0
        audioPlayer.volume = slVolume.value
        lblEndTime.text = convertNSTimeInterval2String(0)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(false, pause: false, stop: false)
        
        let session = AVAudioSession.sharedInstance()
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch let error as NSError {
            print("Error-setCategory: \(error)")
        }
        
        do {
            try session.setActive(true)
        } catch let error as NSError {
            print("Error-setActive : \(error)")
        }
    }
    
    // 오디오 재생 위해 초기화하는 함수
    func initPlay() {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: audioFile)
        } catch let error as NSError {
            print("Error-initPlay : \(error)")
        }
        
        slVolume.maximumValue = MAX_VOLUME
        slVolume.value = 1.0
        pvProgressPlay.progress = 0
        
        audioPlayer.delegate = self
        audioPlayer.prepareToPlay()
        audioPlayer.volume = slVolume.value
        
        // 오디오 파일 재생시간 값을 텍스트에 출력
        lblEndTime.text = convertNSTimeInterval2String(audioPlayer.duration)
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        
        setPlayButtons(true, pause: false, stop: false)
        /*btnPlay.isEnabled = true
        btnPause.isEnabled = false
        btnStop.isEnabled = false*/
    }

    func setPlayButtons(_ play: Bool, pause: Bool, stop: Bool) {
        btnPlay.isEnabled = play
        btnPause.isEnabled = pause
        btnStop.isEnabled = stop
    }
    
    func convertNSTimeInterval2String(_ time: TimeInterval) -> String {
        let min = Int(time / 60)
        // time을 60으로 나눈 나머지 값을 정수로 변환하여 sec에 초기화
        let sec = Int(time.truncatingRemainder(dividingBy: 60))
        let strTime = String(format: "%02d:%02d", min, sec)
        
        return strTime
    }
    
    @IBAction func btnPlayAudio(_ sender: UIButton) {
        audioPlayer.play()
        setPlayButtons(false, pause: true, stop: true)
        progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timePlayerSelector, userInfo: nil, repeats: true)
    }
    
    // 재생 시간을 lblCurrentTime과 progressView에 보여줌
    @objc func updatePlayTime() {
        lblCurrentTime.text = convertNSTimeInterval2String(audioPlayer.currentTime)
        pvProgressPlay.progress = Float(audioPlayer.currentTime / audioPlayer.duration)
    }
    
    @IBAction func btnPauseAudio(_ sender: UIButton) {
        audioPlayer.pause()
        setPlayButtons(true, pause: false, stop: true)
    }
    
    @IBAction func btnStopAudio(_ sender: UIButton) {
        audioPlayer.stop()
        audioPlayer.currentTime = 0
        lblCurrentTime.text = convertNSTimeInterval2String(0)
        setPlayButtons(true, pause: false, stop: false)
        // timer 무효화시키기
        progressTimer.invalidate()
    }
    
    // 볼륨 조절하는 함수
    @IBAction func slChangeVolume(_ sender: UISlider) {
        audioPlayer.volume = slVolume.value
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        progressTimer.invalidate()
        setPlayButtons(true, pause: false, stop: false)
    }
    
    @IBAction func swRecordMode(_ sender: UISwitch) {
        if sender.isOn {
            audioPlayer.stop()
            audioPlayer.currentTime = 0
            lblRecordTime!.text = convertNSTimeInterval2String(0)
            isRecordMode = true
            btnRecord.isEnabled = true
            lblRecordTime.isEnabled = true
        }
        else {
            isRecordMode = false
            btnRecord.isEnabled = false
            lblRecordTime.isEnabled = false
            lblRecordTime.text = convertNSTimeInterval2String(0)
        }
        
        selectAudioFile()
        
        if !isRecordMode {
            initPlay()
        }
        else {
            initRecord()
        }
    }
    
    @IBAction func btnRecord(_ sender: UIButton) {
        // 버튼 이름이 Record이면 녹음하고 버튼 이름을 Stop으로 변경
        if (sender as AnyObject).titleLabel?.text == "Record" {
            audioRecorder.record()
            (sender as AnyObject).setTitle("Stop", for: UIControl.State())
            progressTimer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: timeRecordSelector, userInfo: nil, repeats: true)
        }
        // 현재 녹음 중이므로 녹음 중단하고 버튼 이름 Stop으로 변경, play버튼 활성화시킴
        else {
            audioRecorder.stop()
            // 녹음 중단 시 타이머 무효화
            progressTimer.invalidate()
            (sender as AnyObject).setTitle("Record", for: UIControl.State())
            btnPlay.isEnabled = true
            initPlay()
        }
    }
    
    // 0.1초마다 함수 실행하는데, 녹음시간 표시
    @objc func updateRecordTime() {
        lblRecordTime.text = convertNSTimeInterval2String(audioRecorder.currentTime)
    }
}
