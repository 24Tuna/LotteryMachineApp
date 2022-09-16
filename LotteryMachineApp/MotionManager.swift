//
//  MotionManager.swift
//  LotteryMachineApp
//
//  Created by cmStudent on 2022/08/25.
//

import CoreMotion
import UIKit

//protocol LotteryProtcol{
//    func lottery()
//}

final class MotionManager:NSObject,ObservableObject{
    
    let player = SoundPlayer()
    
    var decision = false
    var playLotteryMachine = false
    
    var saveAccelX = 0.0
    var saveAccelY = 0.0
    var saveAccelZ = 0.0
    
    var count = 1
    var result = 0
    
    var imgStr:String = "ガラポン"
    
    @Published var accelX = 0.0
    @Published var accelY = 0.0
    @Published var accelZ = 0.0
    
    var isBig = false
    
    let manager = CMMotionManager()
    
    override init(){
        
        super.init()
        
//        print(playLotteryMachine)
       
            if manager.isAccelerometerAvailable{
            manager.accelerometerUpdateInterval = 20.0/60.0
            manager.startAccelerometerUpdates(
                to: OperationQueue.current!,
                withHandler:{
                    (accelData: CMAccelerometerData?, errorOC: Error?) in
                    self.accelX = floor((accelData?.acceleration.x ?? 0.0) * 100000) / 100000
                    self.accelY = floor((accelData?.acceleration.y ?? 0.0) * 100000) / 100000
                    self.accelZ = floor((accelData?.acceleration.z ?? 0.0) * 100000) / 100000
                    
                    if !self.playLotteryMachine{ return }
                    
                    print(self.decision)
                    
                    if fabs(fabs(self.accelX) - fabs(self.saveAccelX)) >= 0.1 &&
                        fabs(fabs(self.accelY) - fabs(self.saveAccelY)) >= 0.1{
                        //音声が流れていないなら音声を流す
                        if !self.decision{
                            self.player.playSound()
                            self.decision = true
                        }
                        
                        if self.count == 4{
                            self.stop()
                            print(self.count)
                            self.result = Int.random(in: 1...10)
                            self.isBig = true
                        }else{
                            self.imgStr = "ガラポン_差分"+String(self.count)
                        }
                        
                        self.count += 1
                        
                    }else if fabs(fabs(self.saveAccelX) - fabs(self.accelX)) >= 0.1 &&
                             fabs(fabs(self.saveAccelY) - fabs(self.accelY)) >= 0.1{
                        //音声が流れていないなら音声を流す
                        if !self.decision{
                            print("PlaySound:2")
                            self.player.playSound()
                            self.decision = true
                        }
                        
                         if self.count == 4{
                             self.stop()
                             print(self.count)
                             self.result = Int.random(in: 1...10)
                         }else{
                             self.imgStr = "ガラポン_差分"+String(self.count)
                         }
                    
                        self.count += 1
                        
                        
                    }else{
//                        self.stop()
                    }
                    
                    print("x:",self.accelX)
                    print("y:",self.accelY)
                    print("savex:",self.saveAccelX)
                    print("savey:",self.saveAccelY)
                    print()
                    
                    self.saveAccelX = self.accelX
                    self.saveAccelY = self.accelY
                    
                })
            }
        
    }
    
    func accel(){
        print("PlaySound:1")
        self.player.playSound()
        self.decision = true
        
    }
    
    func stop(){
        print("StopSound")
        self.decision = false
        self.player.stopSound()
        playLotteryMachine = false
    }
    
    func start(){
        playLotteryMachine = true
    }
    
    func clear(){
        self.count = 1
        self.isBig = false
        self.imgStr = "ガラポン"
        stop()
    }
}

//class Lottery: LotteryProtcol{
//    var result = 0
//
//    func lottery(){
//        result = Int.random(in: 1...10)
//    }
//}
