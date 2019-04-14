#途中でエラーになる（使用できない）

rm(list = ls()) #オブジェクト全削除

#必要なパッケージがない場合はインストール
targetPackages <- c("ggplot2") 
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
drawboxplot <- function(input, title_size = 10, xlab_size = 10, 
                        ylab_size = 10, xangle = 0, hjust = 0, 
                        vjust = 0, ylab = "Relative abundance (%)") {
        ggplot(dt, aes(x = group, y = dt[, i], fill = group)) + 
                stat_boxplot(geom = "errorbar", width = 0.25, size = 1) +
                geom_boxplot(width = 0.7, aes(fill = group), size = 1, colour = "black") +
                scale_fill_manual(values = group_colour) +
                theme(panel.background = element_rect(fill = "white", colour = NA),
                      panel.border = element_blank(),
                      axis.line = element_line(colour = "black", size = 1.5, 
                                               lineend = "square"),
                      axis.title.x = element_blank(),
                      axis.title.y = element_text(colour = "black", size = title_size), 
                      axis.text.x = element_text(colour = "black", size = xlab_size, 
                                                 angle = xangle, hjust = hjust, 
                                                 vjust = vjust), 
                      axis.text.y = element_text(colour = "black", size = ylab_size), 
                      axis.ticks = element_line(size = 1.5, colour = "black"), 
                      axis.ticks.length = unit(0.3,'cm'), 
                      legend.key = element_rect(fill = 'white'))+
                ylab(ylab) + 
                scale_y_continuous(expand = c(0, 0), 
                                   limits = c(0, max(dt[, i]) * 1.2)) +
                guides(fill = guide_legend(title = NULL, ncol = 1))
}

#引数の取得, 検定と補正の指定がない場合は順位和検定でBH補正
args <- commandArgs(trailingOnly = T)

# args[1] inputデータ(csv)
dt <- read.csv(args[1], row.names = 1, header = T, stringsAsFactors = F)
# args[2] 出力ディレクトリ(ない場合は作成)
dir <- args[2]
if(!(dir %in% list.files())) {
        dir.create(dir)
} 

# args[3] タイトルサイズ
title_size <- args[3]

# args[4] x軸ラベルサイズ
xlab_size <- args[4]

# args[5] x軸アングル
xangle <- args[5]
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
        cat("Select angle in 0, 45, 90! You input other angle.")
        q("no")
}

# args[6] y軸ラベル
ylab <- args[6]

# args[7] y軸ラベルサイズ
ylab_size <- args[7]

# args[8] ファイルの横幅
width <- args[8]

# args[9] ファイルの縦幅
height <- args[9]

# args[10] 解像度
res <- args[10]

#グループごとの色のベクトルを作成
group_colour <- c(rep(NA, length(unique(dt$order))))
for(i in 1:length(unique(dt$order))){
        group_colour[i] <- unique(dt$colour[dt$order == i])   
}

# 作図
variable_len <- ncol(dt) - 3
for(i in 1:variable_len) {
        fname <- paste(dir, "/", colnames(dt)[i], ".png", sep = "")
        print(cat(c(fname, width, height, args[10])))
        png(filename = fname, width = width, height = height, res = res)
        drawboxplot(input = dt[, c(i, variable_len:ncol(dt))], 
                    title_size = title_size, xlab_size = xlab_size, 
                    xangle = xangle, hjust = hjust, vjust = vjust, 
                    ylab = ylab, ylab_size = ylab_size)
        dev.off()
}

