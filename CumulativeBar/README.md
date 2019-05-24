## CumulativeBarPlot
Author:Tomoya Tsukimi  
Last update:2019-05-24  
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
<br>

### 2. インプットデータの準備  
---
- エクセルなどでA列に積み上げたい変数（この場合細菌名）、B列以降にサンプル名を記入する。
- csvファイル形式で保存する。名前は何でも良いが日本語は避けた方が無難。
- "CumulativeBarInput.csv"であればプログラムを修正することなく実行できる。
![](https://github.com/t-tsukimi/scripts/blob/master/CumulativeBar/image/CumulativeBarInput.png)  
- 例としてあげている"CumulativeBarInput.csv"は[QIIMEのIlluminaデータチュートリアル](https://nbviewer.jupyter.org/github/biocore/qiime/blob/1.9.1/examples/ipynb/illumina_overview_tutorial.ipynb)で生成される"table_mc1114_sorted_L6.txt"を加工したもの。
<br>

### 3. 実行
---
- Rstudioでboxplot.Rを起動する。
- inputファイル名を変更したい場合は55行目、文字サイズや色などの詳細を調整したい場合は17-34行目のコードを修正すれば良い。
- 修正できるものは以下の通り(分かる人は直接コードをいじってもらえればいいです)

> タイトルサイズ  
x軸テキストサイズ  
y軸テキストサイズ  
y軸ラベル  
y軸ラベルサイズ  
出力ファイルの横幅  
出力ファイルの縦幅  
解像度  
出力ファイル（png）のファイル名  
Otherに含めない上位のbacteria数  
色合い  
ワーキングディレクトリの場所

- 手動で色を入力する場合は16進数カラーコードで記入する。16進数カラーコードは以下のサイトなどを参照。
[原色大辞典](https://www.colordic.org/), [RGBと16進数カラーコードの相互変換ツール](https://www.peko-step.com/tool/tfcolor.html)
- 終了するとワーキングディレクトリにpngファイルが出力される。
- 表示されるのは指定した数の上位の変数＋Other。
- 各変数の量の順位付けには入力ファイル1番目のサンプルの値が用いられる。
![](https://github.com/t-tsukimi/scripts/blob/master/CumulativeBar/image/CumulativeBarPlot.png)


