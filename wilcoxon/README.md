## ターミナルで二群ノンパラメトリック検定＋多重検定補正
Author:Tomoya Tsukimi  
Last update:2019-02-08  
<font color="red">注意</font>：使用は自己責任でお願いします  
<br />  

### 1. スクリプトのダウンロード
---
git cloneでまとめてダウンロード
```sh
git clone https://github.com/t-tsukimi/scripts.git
```
※個別にダウンロードする場合は「Raw」→名前をつけて保存  
<br />
![](https://github.com/t-tsukimi/scripts/blob/master/wilcoxon/image/script_dowonload.png)  
<br />  
<br />  

### 2. インプットデータの準備  
---
・1行A列は空白  
・1行B列以降に検定したい変数名(細菌の相対存在量など)を入力し、最後の列には「group」と記入  
・A列にサンプル名、B列以降に検定したい変数の値、group列にグループ名を記入し、csvで保存  
![](https://github.com/t-tsukimi/scripts/blob/master/wilcoxon/image/input_file.png)  
<br />  
<br />  



### 3. 実行
---
terminalを起動して下記コマンドを入力。
```sh
Rscript wilcoxon_test.R インプットファイル 検定の種類 補正方法
```
検定の種類  
・ウィルコクソンの順位和検定（＝マンホイットニーのU検定）：non-paired(デフォルト)  
・ウィルコクソンの符号順位検定：paired

補正方法  
・Rのstatsパッケージのp.adjust関数のmethod引数に沿う  
・"holm", "hochberg", "hommel", "bonferroni", "BH"（デフォルト）, "BY", "fdr", "none"のいずれか  
・FDR補正するならひとまず"BH"で良い  

アウトプットファイル  
・「wilcoxon_検定の種類_グループ1_グループ2_補正方法.csv」が出力される。  
<br />  
<br />  

### 4. 実行例
---
```sh
#ウィルコクソンの順位和検定を実行してFDR（BH）補正したい。
Rscript wilcoxon_test.R wilcoxon_input.csv non-paired BH

#検定の種類と補正方法を指定しない場合はウィルコクソンの順位和検定＋FDR（BH）
Rscript wilcoxon_test.R wilcoxon_input.csv #上記と同じ結果になる

#ウィルコクソンの符号順位検定を実行してボンフェローニ補正したい。
Rscript wilcoxon_test.R wilcoxon_input.csv paired bonferroni
```
<br />  
<br />  

### 5. エラー
---
- ウィルコクソンの符号順位検定で2群の値が全く変数があるとエラーになります。その場合は、その変数のみ削除して実行してください。
```R
wilcox.exact(c(0, 0, 0, 0, 1), c(0, 0, 0, 0, 1), paired = T)
#equiscores(scores, m, tol, fact, simulate) でエラー: m less than 1
```
