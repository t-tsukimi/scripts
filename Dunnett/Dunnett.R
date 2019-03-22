rm(list = ls()) #オブジェクト全削除

#必要なパッケージがない場合はインストール
targetPackages <- c("multcomp") 
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
if(length(args) == 0) {
        cat("Input argument!\ntest was not performed...\n")
        q("no")
}
input <- args[1]
method <- args[2]

#ファイルの読み込み(groupの順はコントロールを1番上にすること)
dt <- read.csv(input, header = T, row.names = 1)
dt <- read.csv("Dunnett_input.csv", header = T, row.names = 1)

#検定するためのデータ整形
dt$group <- factor(dt$group, levels = unique(dt$group))
variable_len <- ncol(dt) -1
group <- dt$group
group_len <- length(unique(dt$group)) - 1


#結果を格納するオブジェクトを作成
mt <- matrix(nrow = group_len, ncol = variable_len)

#検定
for (i in 1:variable_len) {
        value <- dt[, i]
        set.seed(18350110) #結果を固定するために乱数の種を設定
        result <- summary(glht(aov(value ~ group), linfct = mcp(group = "Dunnet")))
        mt[, i] <- result$test$pvalues #検定結果を格納
        
        #出力するために整形
        if(i == variable_len) {
                rownames(mt) <- names(result$test$coefficients)
                colnames(mt) <- colnames(dt)[1:variable_len]
        }
}

#多重検定補正
mt.adjust <- matrix(nrow = group_len, ncol = variable_len)
for (i in 1:nrow(mt.adjust)) {
        mt.adjust[i, ] <- p.adjust(mt[i, ], method = method)
}
if(method == "BH") {
        colnames(mt.adjust) <- paste(colnames(mt), ".FDR", sep = "")
} else {
        colnames(mt.adjust) <- paste(colnames(mt), ".", method, sep = "")
}
rownames(mt.adjust) <- rownames(mt)

output <- cbind(mt, mt.adjust)
#ファイルの書き込み
fn <- paste("Dunnett_result_", method, ".csv", sep = "")
write.csv(output, fn)
cat(paste("Test was performed successfully!\nChech ", fn, "\n", sep = ""))
