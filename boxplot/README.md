## Dunnett検定
Author:Tomoya Tsukimi  
Last update:2019-04-14  
<font color="red">注意</font>：使用は自己責任でお願いします  
<br>

### 1. スクリプトのダウンロード
---
・git cloneでまとめてダウンロード
```sh
git clone https://github.com/t-tsukimi/scripts.git
```
<br>
・あるいはClone or download -> Download ZIP  

![](https://github.com/t-tsukimi/scripts/blob/master/pvalue_correction/image/download_script.png)  


### 2. インプットデータの準備  
---
- エクセルなどでA列にサンプル名、B列以降に検定したい変数の値、group列にグループ名、orderにそのグループを並べたい順番、colourに色を記入。
- colourは16進数カラーコードで記入する。16進数カラーコードは下記サイトなどを参照。
> [原色大辞典](https://www.colordic.org/), [RGBと16進数カラーコードの相互変換ツール](https://www.peko-step.com/tool/tfcolor.html)
- csvファイル形式で保存する。名前は何でも良いが"boxplot_input.csv"であればプログラムを修正することなく実行できる。
  
![](https://github.com/t-tsukimi/scripts/blob/master/boxplot/image/boxplot_input_csv.png)  



### 3. 実行
---
- Rstudioでboxplot.Rを起動する。
- inputファイル名を"boxplot_input.csv"にした場合はcommand(windows はctr) + Aで全選択した後、return(enter)で実行。
- inputファイル名を変更したい場合は45行目、文字サイズなどの詳細を調整したい場合は49-74行目のコードを修正すれば良い。
- 修正できるものは以下の通り(分かる人は直接drawboxplotを修正すればいいですが)
> タイトルサイズ  
x軸テキストサイズ(グループ名)  
x軸アングル(0か45か90)  
y軸ラベル  
y軸ラベルサイズ  
y軸テキストサイズ(変数の値)  
出力ファイルの横幅  
出力ファイルの縦幅  
解像度  
出力ディレクトリ  
y軸の値をパーセント表示にするか否か
- 終了すると出力先ディレクトリに「変数名.png」ファイルが出力される。
![](https://github.com/t-tsukimi/scripts/blob/master/boxplot/image/bacteria4.png)  

