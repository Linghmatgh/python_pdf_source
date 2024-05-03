#!/bin/bash

# 遍历当前目录下的文件
for file in ./*
do
    # 跳过目录
    if [ -d "$file" ]; then
        continue
    fi

    # 使用grep全文搜索并直接提取符合特定部分的字符串
    # 正则表达式直接定位并提取'\d{2}[A-Z]{0,1}'
    key_info=$(grep -oP '正则表达式' "$file")

    # 确保提取到了信息
    if [ -z "$key_info" ]; then
        echo "No match found in $file, skipping."
        continue
    fi

    # 获取原文件名（不含路径）和扩展名
    base_name=$(basename -- "$file")
    extension="${base_name##*.}"
    base_name_no_ext="${base_name%.*}"

    # 构建新的文件名
    new_file_name="${key_info}_${base_name}"

    # 重命名文件
    echo "Renaming $file to $new_file_name"
    mv "$file" "$new_file_name"
done

echo "File renaming completed."