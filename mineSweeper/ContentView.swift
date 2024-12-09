//
//  ContentView.swift
//  mineSweeper
//
//  Created by Taiki Kuwahara on 2024/08/20.
//

import SwiftUI

struct ContentView: View {
    @State var tool = false
    @State var gameState = false
    @State var field: [[square]] = Array(repeating: Array(repeating: square(count: 0), count: 9), count: 9)
    @State private var winMessage = false
    @State private var loseMessage = false
    @State private var currentAlert: AlertType?
    @State private var counter: Double = 0.0
    @State private var timer: Timer?
    let columns = Array(repeating: GridItem(.flexible()), count: 9)
    
    func startTimer() {
        counter = 0.0
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            counter += 0.01
        }
    }

    func stopTimer() {
            timer?.invalidate()
            timer = nil
    }

            var body: some View {
                HStack{
                Text("Time: \(String(format: "%.2f", counter)) ")
                }
                VStack{

                    Text("MineSweeper")
                        .font(.largeTitle)
                        //失敗時のメッセージ（loseMessageフラグで起動）
                        .alert("You lost...", isPresented: $loseMessage){}message:{Text("Try again")}
                        //成功時のメッセージ（winMessageフラグで起動）
                        .alert("Congraturation!", isPresented: $winMessage){}message:{Text("Try again")}
                    HStack{
                        Button(action: {
                            if gameState == false {
                                generateField(field: &field, gameState: &gameState)
                                startTimer()
                            } else {
                                stopTimer()
                                gameState = false
                            }
                        }, label: {
                            Text(gameState ? "reset" : "start")
                                .font(.largeTitle)
                                .foregroundColor(.black)
                                .padding([.leading, .trailing], 30)
                                .padding([.top, .bottom], 6)
                                .border(Color.black)
                        })                    }
                    LazyVGrid(columns: columns, spacing: 3) {
                        ForEach(0..<9, id: \.self) { height in
                            ForEach(0..<9, id: \.self) { width in
                                Button(action: {
                                    if gameState{
                                        if !tool{
                                            if !field[height][width].state && !field[height][width].mine {
                                                openSquare(field: &field, x: width, y: height)
                                                if openCount==79{
                                                    winMessage.toggle()
                                                    stopTimer()
                                                }
                                            }
                                            if field[height][width].mine{
                                                loseMessage.toggle()
                                                stopTimer()
                                                gameState.toggle()
                                                field[height][width].state.toggle()
                                            }
                                        }
                                        else{
                                            placeFlag(field: &field, x: width, y: height)
                                        }
                                    }
                                }) {if field[height][width].flag && !field[height][width].state{
                                    Image(systemName: "flag")
                                        .foregroundColor(.black)
                                }
                                    else if field[height][width].mine && field[height][width].state{
                                        Image(systemName: "bolt")
                                            .foregroundColor(.black)
                                            .font(.title3)
                                    }
                                    else{
                                    Text(field[height][width].state ? "\(field[height][width].count)" : "")
                                        .frame(width: 35, height: 35) // マス目のサイズ
                                        .foregroundColor(.black)
                                        .border(Color.black)
                                    }
                                }
                                .padding([.top, .bottom], 2)
                            }
                        }
                    }
                    .padding(.all, 12)
                    Button(action: {
                        if gameState{tool.toggle()}}, label: {
                        if !tool{
                            VStack{
                                Text("open／flag")
                                    .font(.title2)
                                HStack{
                                    Text("now:   ")
                                    Image(systemName: "lock.open")
                                        .font(.system(size: 40))
                                }
                                .font(.title)
                            }
                            .foregroundColor(.black)
                            .background(Color.white)
                            .padding(.all)
                            .frame(width: 240, height: 100)
                            .border(Color.black)
                        }
                        else{
                            VStack{
                                Text("open／flag")
                                    .font(.title2)
                                HStack{
                                    Text("now:   ")
                                    Image(systemName: "flag")
                                        .font(.system(size: 40))
                                }
                                .font(.title)
                            }
                            .foregroundColor(.white)
                            .padding(.all)
                            .frame(width: 240, height: 100)
                            .background(Color.black)
                            }
                    })
                }
    }
}

#Preview {
    ContentView()
}
