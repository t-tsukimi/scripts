## 自作ショートカット集
Author:Tomoya Tsukimi  
Last update:2019-04-07  
<font color="red">注意</font>：使用は自己責任でお願いします  
<br />  

### ファイル数をカウントする
---

```sh
sh count_file_number.sh ファイル数をカウントしたいディレクトリ
```
- .bashrcにalias c='/yourpath/count_file_number.sh'として使用

### git add -> commit -> pushを自動化  
---
```sh
sh git_push.sh addしたいファイル コメント
```
- .bashrcにalias gitacp='/yourpath/git_push.sh'として使用
- commnetに空白が入るとうまくいかない(後で修正する)
