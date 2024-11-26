//
//  system.swift
//  mineSweeper
//
//  Created by Taiki Kuwahara on 2024/08/20.
//

import Foundation

let dx = [-1, 0, 0, 1, -1, -1, 1, 1]
let dy = [0, 1, -1, 0, -1, 1, -1, 1]
//ゲームの状態を管理
var gameState = false
var tool = false
var openCount = 0
private var loseMessage = false
private var winMessage = false

//マスの構造体
struct square{
    var mine: Bool = false
    var state: Bool = false
    var count: Int = 0
    var flag: Bool = false
}

//盤面の生成
func generateField(field: inout [[square]], gameState: inout Bool) {
    gameState.toggle()
    openCount = 0
    field = Array(repeating: Array(repeating: square(mine: false, state: false, count: 0, flag: false), count: 9), count: 9)
    //0~80までの配列を作りシャッフル
    var nums = Array(0 ..< 81)
    nums.shuffle()
    //マスに爆弾を配置
    for i in 0...17{
        let y = nums[i] / 9
        let x = nums[i] % 9
        field[y][x].mine = true
    }
    for i in 0..<9 {
        for j in 0..<9 {
            for k in 0..<8 {
                if i + dy[k] < 0 || i + dy[k] > 8 || j + dx[k] < 0 || j + dx[k] > 8 {
                    continue
                }
                if field[i + dy[k]][j + dx[k]].mine {
                    field[i][j].count += 1
                }
            }
        }
    }
}

//ゲームクリア時の処理
func clearGame(field: inout [[square]], gameState: inout Bool) {
    gameState.toggle()
}

//マスを開ける時の処理
func openSquare(field: inout [[square]], x: Int, y: Int){
    field[y][x].state=true
    openCount+=1
    if openCount==63{
        clearGame(field: &field, gameState: &gameState)
        return
    }
    if field[y][x].count>0 && openCount>1{
        return
    }
    for i in 0..<8{
        let ny = y+dy[i]
        let nx = x+dx[i]
        if ny<0||ny>8||nx<0||nx>8{
            continue
        }
        if field[ny][nx].mine{
            continue
        }
        if field[ny][nx].state{
            continue
        }
        openSquare(field: &field, x: nx, y: ny)
    }
}

//旗を置く処理
func placeFlag(field: inout [[square]], x: Int, y: Int){
    field[y][x].flag.toggle()
}

enum AlertType: Identifiable {
    case win
    case lose
    var id: AlertType { self }
}
