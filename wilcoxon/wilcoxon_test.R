rm(list = ls()) #オブジェクト全削除

#必要なパッケージがない場合はインストール
targetPackages <- c("exactRankTests") 
newPackages <- targetPackages[!(targetPackages %in% installed.packages()[,"Package"])]
if(length(newPackages) > 0) {
        install.packages(newPackages, repos = "http://cran.ism.ac.jp/", 
                         dependencies = T)
}
#パッケージの読み込み
for(package in targetPackages) {
        library(package, character.only = T)
}

#引数の取得, 検定と補正の指定がない場合は順位和検定でBH補正
args <- commandArgs(trailingOnly = T)
if(length(args) == 0) {
        cat("Input argument!\ntest was not performed...\n")
        q("no")
}
input <- args[1]
if(is.na(args[2])) {
        paired <- F
} else if(args[2] == "paired"){
        paired <- T
} else {
        cat("Invalid argument!\ntest was not performed...\n")
        q("no")
}
if(is.na(args[3])) {
        method <- "BH"
} else {
        method <- args[3]
}


#ファイルの読み込み
dt <- read.csv(input, header = T, row.names = 1)

#検定するためのデータ整形
dt$group <- factor(dt$group, levels = unique(dt$group))
variable_len <- ncol(dt) -1
group1 <- dt$group == unique(dt$group)[1]
group2 <- dt$group == unique(dt$group)[2]

#t検定の実施
p <- c()
for (i in 1:variable_len) {
        value1 <- dt[, i][group1]
        value2 <- dt[, i][group2]
        
        result <- wilcox.exact(value1, value2, paired = paired)
        p <- c(p, result$p.value)
}

#書き込み用に整形し多重検定補正
df <- data.frame(p.val = p, FDR = p.adjust(p, method = method), 
                 row.names = colnames(dt)[1:variable_len])
if(method == "BH") {
        colnames(df)[2] <- "FDR(BH)"
} else {
        colnames(df)[2] <- method
}


#ファイルの書き込み
if(paired){
        fn <- paste("wilcox_paired_", unique(dt$group)[1], 
                    "_", unique(dt$group)[2], "_", method, ".csv", sep = "")
} else {
        fn <- paste("wilcox_non_paired_", unique(dt$group)[1], 
                    "_", unique(dt$group)[2], "_", method, ".csv", sep = "")
}
write.csv(df, fn)

cat(paste("Test was performed successfully!\nChech ", fn, "\n", sep = ""))