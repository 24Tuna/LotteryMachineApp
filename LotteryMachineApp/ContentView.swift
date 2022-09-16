//
//  ContentView.swift
//  LotteryMachineApp
//
//  Created by cmStudent on 2022/08/25.
//

import SwiftUI

struct ContentView: View {
    @State var bool:Bool = true
    @StateObject var manager = MotionManager()
    
//    let protcol = LotteryProtcol()
//    let lottery = Lottery()
    
    var result : Int = 0
    var body: some View {
        
        ZStack{
            
//            Color("AppBack")
            Image("BackImage2")
                .resizable()
                .edgesIgnoringSafeArea(.all)
                .aspectRatio(contentMode: .fill)
                
            
            VStack{
                Spacer()
                
                if bool{
                    StartButton
                }else{
                    
                    if manager.count >= 4{
                        
                        Text(String(manager.result)+"等!")
                            .font(.largeTitle)
                            .foregroundColor(Color("Text"))
                            .scaleEffect(manager.isBig ? 1.0 : 0)
                            .animation(.easeInOut, value: self.manager.isBig)
                        
                        
                        ReturnButton
                           
                            
                    }else{
                        Image(manager.imgStr)
                    }
                    
                }//if
                
                Spacer()
            }//VStack
        }//ZStack
    }//Body
    
    var StartButton:some View{
        Button {
            bool = false
            manager.start()
        } label: {
            Text("抽選開始!")
                .font(.title)
                .padding()
                .background(Color("ButtonColor"))
                .foregroundColor(Color("Text"))
                .cornerRadius(10)
        }//Button
        .disabled(!bool)
    }
    
    var ReturnButton:some View{
        Button {
            bool = true
            manager.clear()
        } label: {
            Text("戻る")
                .font(.title2)
                .padding()
                .background(Color("ButtonColor"))
                .foregroundColor(Color("Text"))
                .cornerRadius(10)
        }
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
