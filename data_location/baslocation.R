# xmlを読み込む（テキストデータのままっぽい）
library(XML)
doc <- xmlParse("P11-10_47-jgd-g.xml")

# <gml:pos>というタグの付いているやつをタグごと持ってくる
items <- getNodeSet(doc,"//gml:pos")


## items_numにタグを外して代入（文字列形式）
#pos_search <- function(x){
#	a <- xmlValue(x[[1]])
#	for(i in 2:length(x)){
#		a <- append(a,xmlValue(x[[i]]))
#	}
#	return(a)
#}
#items_num <- pos_search(items)

# 上の式と同義
items_num <- sapply(items, function(x) xmlValue(x))

# スペース区切りになっているので，分割して連番に
items_number <- sapply(items_num, function(x) as.numeric(unlist(strsplit(x," "))))

# 緯度と経度に分割していく
latitudes <- items_number[seq(1,length(items_number),2)]
longtudes <- items_number[seq(2,length(items_number),2)]

basstop_name <- getNodeSet(doc,"//ksj:busStopName")
basstop_name <- sapply(basstop_name, function(x) xmlValue(x))

# バス停留所のIDと緯度経度の関係
basstop_data <- data.frame(NAMES=basstop_name, LATITUDE=latitudes, LONGTUDE=longtudes)

# 沖縄っぽい地図が見える
#plot(basstop_data$LATITUDE,basstop_data$LONGTUDE)

basstop_route <- getNodeSet(doc,"//ksj:BusStop")
a <- sapply(basstop_route, function(x) xmlChildren(x)[c(-1,-2)])
b <- sapply(a,function(x) sapply(x, xmlChildren))
c <- sapply(b,function(x) sapply(x, xmlChildren))
e <- lapply(c, function(x) x[seq(3,length(x),3)])
f <- lapply(e, function(x) lapply(x,xmlValue))

# 一つ目のバス停に接続されている経路
#f[[1]]

# 一つ目のバス停の一つ目の経路
#f[[1]][[1]]