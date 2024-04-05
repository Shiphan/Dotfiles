#!/bin/bash

# a資料夾
adir="dotconfig"

# b資料夾
bdir="~/.config"

# 計算a資料夾中存在多少個b資料夾中的檔案
count=0
for file in "$adir"/*; do
  if [ -f "$file" ]; then
    if [ -f "$bdir/$file" ]; then
      ((count++))
      echo "$file"
    fi
  fi
done

# 輸出結果
echo "There are $count files in the directory $adir that also exist in the directory $bdir."
