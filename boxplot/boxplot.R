rm(list = ls()) #オブジェクト全削除

#必要なパッケージがない場合はインストール
targetPackages <- c("ggplot2", "scales") 
newPackages <- targetPackages[!(targetPackages %in% installed.packages()[,"Package"])]
if(length(newPackages) > 0) {
        install.packages(newPackages, repos = "http://cran.ism.ac.jp/", 
                         dependencies = T)
}

#パッケージの読み込み
for(package in targetPackages) {
        library(package, character.only = T)
}

#boxplotを作図する関数を定義
drawboxplot <- function(input, title_size, xlab_size, ylab_size, xangle, 
                        hjust, vjust, ylab, xtext_size, ytext_size) {
        ggplot(input, aes(x = group, y = input[, 1], fill = group)) + 
                stat_boxplot(geom = "errorbar", width = 0.25, size = 1) +
                geom_boxplot(width = 0.7, aes(fill = group), size = 1, colour = "black") + 
                ggtitle(colnames(input)[1]) +
                scale_fill_manual(values = group_colour) +
                theme(panel.background = element_rect(fill = "white", colour = NA),
                      panel.border = element_blank(),
                      axis.line = element_line(colour = "black", size = 1.5, 
                                               lineend = "square"),
                      plot.title = element_text(size = title_size, hjust = 0.5), 
                      axis.title.x = element_blank(),
                      axis.title.y = element_text(colour = "black", size = ylab_size), 
                      axis.text.x = element_text(colour = "black", size = xtext_size, 
                                                 angle = xangle, hjust = hjust, 
                                                 vjust = vjust), 
                      axis.text.y = element_text(colour = "black", size = ytext_size), 
                      axis.ticks = element_line(size = 1.5, colour = "black"), 
                      axis.ticks.length = unit(0.3,'cm'), 
                      legend.key = element_rect(fill = 'white'))+
                ylab(ylab) + 
                guides(fill = guide_legend(title = NULL, ncol = 1))
}

getwd() #ワーキングディレクトリ確認
# データの読み込み
dt <- read.csv("boxplot_input.csv", row.names = 1, header = T, stringsAsFactors = F)
dt$group <- factor(dt$group, levels = unique(dt$group)[unique(dt$order)]) #順序の指定

#パラメータの設定
title_size <- 12 #タイトルサイズ
xtext_size <- 10 #x軸テキストサイズ
xangle <- 0 #x軸アングル(0か45か90)
if(xangle == 0){
        hjust <- NULL
        vjust <- NULL
} else if(xangle == 45) {
        hjust <- 0.5
        vjust <- 0.5
} else if(xangle == 90) {
        hjust <- 1
        vjust <- 0.5
} else{
        stop("Select angle in 0, 45, 90! You input other angle.")
}
ylab <- "Relative abundance (%)" #y軸ラベル
ylab_size <- 10 #y軸ラベルサイズ
ytext_size <- 8 #y軸テキストサイズ
width <- 960 #出力ファイルの横幅
height <- 960 #出力ファイルの縦幅
res <- 200 #解像度
dir <- "plot" #出力ディレクトリ
if(!(dir %in% list.files())) {
        dir.create(dir)
}
percent <- T #パーセント表示にする場合はT、そうでない場合はF

#グループごとの色のベクトルを作成
group_colour <- c(rep(NA, length(unique(dt$order))))
for(i in 1:length(unique(dt$order))){
        group_colour[i] <- unique(dt$colour[dt$order == i])   
}

# 作図
variable_len <- ncol(dt) - 3
for(i in 1:variable_len) {
        fname <- paste(dir, "/", colnames(dt)[i], ".png", sep = "")
        png(filename = fname, width = width, height = height, res = res)
        g <- drawboxplot(input = dt[, c(i, variable_len:ncol(dt))], 
                    title_size = title_size, xtext_size = xtext_size, 
                    xangle = xangle, hjust = hjust, vjust = vjust, 
                    ylab = ylab, ylab_size = ylab_size, 
                    ytext_size = ytext_size)
        if(percent) {
                g <- g + scale_y_continuous(expand = c(0, 0), 
                                            limits = c(0, max(dt[, i]) * 1.2), 
                                            labels = scales::percent)
        } else {
                g <- g + scale_y_continuous(expand = c(0, 0), 
                                            limits = c(0, max(dt[, i]) * 1.2))
        }
        print(g)
        dev.off()
}
