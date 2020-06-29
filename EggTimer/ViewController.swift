//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    // ========= 変数定義 =========
    // 卵の硬度
    let eggTimes = ["Soft": 3, "Medium": 4, "Hard": 7]
    
    // 合計時間
    var totalTime = 0
    // 経過時間
    var secondsPassed = 0
    
    var timer = Timer()
    var player:AVAudioPlayer!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    // ========== IBAction定義 ==========
    @IBAction func hurchSelected(_ sender: UIButton) {
        // 現行のタイマーを停止させる
        timer.invalidate()
        
        // 卵の硬度を取得
        let hardness = sender.currentTitle!
        
        // 卵の硬度に対しての秒数を取得
        totalTime = eggTimes[hardness]!
        
        // 進捗状況のリセット
        progressBar.progress = 0.0
        secondsPassed = 0
        titleLabel.text = hardness
        
        // カウントダウンタイマー呼び出し
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
    }
    
    @objc func updateTimer() {
        if secondsPassed < totalTime {
            secondsPassed += 1
            // 進捗率の更新
            progressBar.progress = Float(secondsPassed) / Float(totalTime)
        } else {
            // タイマー終了
            timer.invalidate()
            
            // 終了時のアラーム出力
            alerm()
            
            titleLabel.text = "Complete!!!"
        }
    }
    
    // 警告音出力
    func alerm() {
        let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
        player = try! AVAudioPlayer(contentsOf: url!)
        player.play()
    }
}
