## t検定

Author:Tomoya Tsukimi  
Last update:2019-02-08  
**注意：使用は自己責任でお願いします**

### スクリプトのダウンロード
```sh
git clone https://github.com/t-tsukimi/scripts.git
```
個別にダウンロードする場合は「Raw」→名前をつけて保存
![](https://github.com/t-tsukimi/scripts/blob/master/ttest/image/script_download.png)


### インプットデータの準備  
・1行A列は空白  
・1行B列以降に検定したい変数名(細菌の存在量など)を入力し、最後の列には「group」と記入  
・A列にサンプル名、B列以降に検定したい変数の値、group列にグループ名を記入  
![](https://github.com/t-tsukimi/scripts/blob/master/ttest/image/input_file.png)

### 実行
terminalを起動して下記コマンドを入力。
```sh
Rscript ttest.R インプットファイル 検定の種類 補正方法
```
検定の種類
・スチューデントのt検定：student  
・ウェルチのt検定：welch  
・対応のあるt検定：paired  

補正方法  
・Rのstatsパッケージのp.adjust関数のmethod引数に沿う  
・"holm", "hochberg", "hommel", "bonferroni", "BH", "BY", "fdr", "none"のいずれか  
・FDR補正するならひとまず"BH"で良い  

アウトプットファイル  
・検定の種類_ttest_グループ1_グループ2_補正方法.csvが出力される。


### 実行例
```sh
#スチューデントのt検定を実行してFDR（BH）補正したい。
Rscript ttest.R ttest_input.csv student BH
#ウェルチのt検定を実行してボンフェローニ補正したい。
Rscript ttest.R ttest_input.csv welch bonferroni
```
