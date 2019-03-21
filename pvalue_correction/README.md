## P値の多重検定補正
Author:Tomoya Tsukimi  
Last update:2019-03-21  
<font color="red">注意</font>：使用は自己責任でお願いします  
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
・1行A列にpと記入し、その後に補正したいP値を入力してcsvで保存。  
![](https://github.com/t-tsukimi/scripts/blob/master/pvalue_correction/image/p_correction_input.png)  
<br />  
<br />  



### 3. 実行
---
terminalを起動して下記コマンドを入力。
```sh
Rscript pvalue_correction.R インプットファイル 補正方法
```
補正方法  
・Rのstatsパッケージのp.adjust関数のmethod引数に沿う  
・"holm", "hochberg", "hommel", "bonferroni", "BH"（デフォルト）, "BY", "fdr", "none"のいずれか  
・FDR補正するならひとまず"BH"で良い  

アウトプットファイル  
・「p_correction_補正方法.csv」が出力される。  
<br />  
<br />  

### 4. 実行例
---
```sh
#FDR
Rscript pvalue_correction.R p_correction_input.csv BH

#ボンフェローニ補正
Rscript pvalue_correction.R p_correction_input.csv bonferroni
```
