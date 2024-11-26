# README
# mineSweeper(beta)
iOSで動作するマインスイーパーアプリです。
<div style="display: flex; justify-content: space-between;">
  <img src="https://github.com/user-attachments/assets/1b8a7c9f-d250-4f72-9659-ffb057dfdbfe" width="30%" />
  <img src="https://github.com/user-attachments/assets/8b24fa5c-cd41-4ddf-a40c-af094fc0b285" width="30%" />
</div>

# 備考
現在クリア画面が表示されない場合があるバグを修正しています。

# 開発の経緯
AtCoderで出題された[minesweeper](https://atcoder.jp/contests/abc075/tasks/abc075_b)からアイデアを受けて作成しました。<br/>
該当の問題は爆弾の数の表示のみですが、競プロ定番の深さ優先探索を使って開くマスを走査しています。

# 使用技術
+ Swift 5.10
+ XCode 16.1

# 操作方法
+ startをタップで開始。
+ 画面下部のボタンが"open squares"の間、タップでマスを開く。
+ 画面下部のボタンが"place flags"の間、タップでマスに旗を配置。
+ resetでタイマー停止&盤面の再生成

# テスト
+ XCode 16.1

