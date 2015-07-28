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