## Dunnett検定
Author:Tomoya Tsukimi  
Last update:2019-03-22  
<font color="red">注意</font>：使用は自己責任でお願いします  
参考：[データ科学便覧 Rによるダネット検定](https://data-science.gr.jp/implementation/ist_r_dunnett_test.html)
<br />  


### 1. スクリプトのダウンロード
---
・git cloneでまとめてダウンロード
```sh
git clone https://github.com/t-tsukimi/scripts.git
```
<br />
・あるいはClone or download -> Download ZIP  

![](https://github.com/t-tsukimi/scripts/blob/master/pvalue_correction/image/download_script.png)  

<br />  
<br />  

### 2. インプットデータの準備  
---
・1行B列以降に検定したい変数名(体重、ある細菌の存在量など)を入力し、最後の列には「group」と記入。  
・A列にサンプル名、B列以降に検定したい変数の値、group列にグループ名を記入。  
※コントロールとなるグループを1番上に記入すること。  
![](https://github.com/t-tsukimi/scripts/blob/master/Dunnett/image/Dunnett_input.png)  
<br />  
<br />  



### 3. 実行
---
terminalを起動して下記コマンドを入力。
```sh
Rscript Dunnett.R インプットファイル 補正方法
```
補正方法  
・Rのstatsパッケージのp.adjust関数のmethod引数に沿う  
・"holm", "hochberg", "hommel", "bonferroni", "BH"（デフォルト）, "BY", "fdr", "none"のいずれか  
・FDR補正するならひとまず"BH"で良い  

アウトプットファイル  
・「Dunnett_result_補正方法.csv」が出力される。  
<br />  
<br />  

### 4. 実行例
---
```sh
#FDR
Rscript Dunnett.R Dunnett_input.csv BH

#ボンフェローニ補正
Rscript Dunnett.R Dunnett_input.csv bonferroni
```
