# bas_stop_map
バス停情報を国土数値情報から整理する．

## How to use
バス停情報は国土交通省のホームページ内，[国土数値情報 バス停留所データ](http://nlftp.mlit.go.jp/ksj/gml/datalist/KsjTmplt-P11.html "国土数値情報")
よりダウンロード．

沖縄のバス停情報について動作を確認済み．


Rを起動し，
```R
source("baslocation.R")
```
で動く．

## Summary
data_mapオブジェクトの中に，バス停一つごとの緯度，経度が入る．
