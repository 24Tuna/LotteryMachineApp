//
//  SoundPlayer.swift
//  LotteryMachineApp
//
//  Created by cmStudent on 2022/08/25.
//

import Foundation
import AVFoundation
import UIKit

class SoundPlayer:NSObject,ObservableObject,AVAudioPlayerDelegate{
    
    private var sound:AVAudioPlayer?
//    private var manager = MotionManager()
    
    func playSound(){
        //再生する音声ファイルの指定
        guard let url = Bundle.main.url(forResource: "garagara", withExtension: "mp3")else{ return }
        sound = try! AVAudioPlayer(contentsOf: url)
        sound?.delegate = self
        //再生開始地点の設定
        sound?.currentTime = 0.0
        //音声ファイルの再生
        sound?.play()
    }
    
    func stopSound(){
        sound?.stop()
    }
    
    //再生終了後に抽選処理を行う
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        let value = Int.random(in: 1...10)
        print("抽選結果:",value)
    }
}

