rm(list = ls())

#必要なパッケージがない場合はインストール
targetPackages <- c("ggplot2", "scales", "tidyr", "RColorBrewer") 
newPackages <- targetPackages[!(targetPackages %in% installed.packages()[,"Package"])]
if(length(newPackages) > 0) {
        install.packages(newPackages, repos = "http://cran.ism.ac.jp/", 
                         dependencies = T)
}

#パッケージの読み込み
for(package in targetPackages) {
        library(package, character.only = T)
}

#パラメータの設定
xtext_size <- 10 #x軸テキストサイズ
ytext_size <- 10 #y軸テキストサイズ
ylab <- "Relative abundance (%)" #y軸ラベル
ylab_size <- 15 #y軸ラベルサイズ
width <- 1200 #出力ファイルの横幅
height <- 960 #出力ファイルの縦幅
res <- 200 #解像度
fname <- "CumulativeBarPlot.png" #出力ファイル名
bacnum <- 10 #Otherに含めない上位のbacteria数

#1番目の要素が灰色で残りはbacteria数に応じたパレットを作る
colorPallet <-  colorRampPalette(brewer.pal(11, "Spectral"))
fillcolourVec <- c("gray", rev(colorPallet(bacnum))) 
#fillcolourVec <- c() 好きな色を使いたい場合はここに16進数カラーコードで記載

#ワーキングディレクトリに移動
wd <- "~/working_dir"
setwd(wd)

#themeを設定
taxonomy.theme <- theme(plot.title = element_text(hjust = 0.5, size = 17, face = "bold"),
                        panel.background = element_rect(fill = "white", colour = NA),
                        panel.border = element_blank(),
                        axis.line = element_line(colour = "black", size = 1, 
                                                 lineend = "square"),
                        axis.title.x = element_blank(),
                        axis.title.y = element_text(colour = "black", size = ylab_size, 
                                                    margin = margin(r = 0.5, unit = "cm")), 
                        axis.text.x = element_text(colour = "black", size = xtext_size, 
                                                   angle = 90, hjust = 1, vjust = .5), 
                        axis.text.y = element_text(colour = "black", size = ytext_size), 
                        axis.ticks.y = element_line(size = 1, colour = "black"), 
                        axis.ticks.x = element_blank(), 
                        axis.ticks.length = unit(0.3,'cm'), 
                        legend.key = element_rect(fill = 'white'))


# データの読み込み
dt <- read.csv("CumulativeBarInput.csv", row.names = 1, header = T, 
               stringsAsFactors = F)
dt <- dt[order(dt[, 1], decreasing = T), ] #1番目のサンプルの相対存在量で並べ替え
bacOrder <- rev(c(rownames(dt)[1:bacnum], "Others")) #Othersが1番上に来るように
sampleOrder <- colnames(dt)
other <- apply(dt[(bacnum + 1):nrow(dt), ], MARGIN = 2, sum)


#上位bacteria＋Otherのデータに整形
dtOther <- rbind(dt[1:bacnum, ], other)
rownames(dtOther)[bacnum + 1] <- "Others"
dtOther <- data.frame(t(dtOther))
dtOther$sample <- rownames(dtOther)

#ロング型に変形
dtLong <- tidyr::gather(dtOther, key = bacteria,  value = ra, -sample)
dtLong$bacteria <- sapply(dtLong$bacteria, function(i) {
        return(gsub("\\.", ";", i))
}) # QIIME出力形式の";"はgatherを使うと"."に変換されてしまうので修正
dtLong$bacteria <- factor(dtLong$bacteria, levels = bacOrder)
dtLong$sample <- factor(dtLong$sample, levels = sampleOrder)

#plot
png(filename = fname, width = width, height = height, res = res)
ggplot(dtLong, aes(x = sample, y = ra, fill = bacteria)) + 
        geom_bar(stat = "identity", width = 1, colour = "black") + 
        scale_fill_manual(values = fillcolourVec) + 
        taxonomy.theme +
        #地面とのmargin消す
        scale_y_continuous(expand = c(0, 0), limits = c(0, 1.01), 
                           labels = percent) +
        ylab(ylab) +
        #凡例を降順に
        guides(fill = guide_legend(reverse = T))
dev.off()

