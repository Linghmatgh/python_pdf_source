#!/bin/bash

# 使用find命令遍历当前目录及其所有子目录下的文件
find . -type f -exec bash -c '
    # 提取文件路径
    file="$0"
    # 提取文件内容中的关键信息
    key_info=$(grep -oP "(?<=-\dF[A-Z]{1,3}-)\d{2}[A-Z]{0,1}" "$file")

    # 确保提取到了信息
    if [ -z "$key_info" ]; then
        echo "No match found in $file, skipping."
        exit 0
    fi

    # 获取文件名（不含路径）和扩展名
    base_name=$(basename -- "$file")
    extension="${base_name##*.}"
    base_name_no_ext="${base_name%.*}"

    # 构建新的文件名
    new_file_name="${key_info}_${base_name}"

    # 重命名文件
    echo "Renaming $file to $new_file_name"
    mv "$file" "$new_file_name"
' {} \;

echo "File renaming completed."
