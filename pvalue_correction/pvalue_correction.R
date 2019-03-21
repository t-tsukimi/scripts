rm(list = ls()) #オブジェクト全削除

#必要なパッケージがない場合はインストール
targetPackages <- c("stats") 
newPackages <- targetPackages[!(targetPackages %in% installed.packages()[,"Package"])]
if(length(newPackages) > 0) {
        install.packages(newPackages, repos = "http://cran.ism.ac.jp/", 
                         dependencies = T)
}
#パッケージの読み込み
for(package in targetPackages) {
        library(package, character.only = T)
}

#引数の取得
args <- commandArgs(trailingOnly = T)
if(length(args) != 2) {
        cat("Input argument!\ncorrection was not performed...\n")
        q("no")
}
input <- args[1]
method <- args[2]

p.adjust_methods <- c("holm", "hochberg", "hommel", "bonferroni", "BH", "BY", 
                      "fdr", "none")
if(!(method %in% p.adjust_methods)) {
        cat("Input valid argument!\ncorrection was not performed...\n")
        q("no")
}


#ファイルの読み込み、補正
p <- read.csv(input, header = T)[, 1] 
p_correction <- p.adjust(p, method = method)

#出力
result <- data.frame(raw_p = p, adjusted_p = p_correction)
if(method == "BH"){
        colnames(result)[2] <- "FDR"
}
fn <- paste("p_correction_", method, ".csv", sep = "")
write.csv(result, file = fn)
cat(paste("Correction was performed successfully!\nChech ", fn, "\n", sep = ""))


