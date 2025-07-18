#!/usr/bin/env bash
set -euo pipefail

# 元のデータセットルート
DATASET_ROOT="dataset"

# 結合後のディレクトリ
COMBINED_DIR="dataset_combined"

# まずは既存の結合先を削除してから再作成
rm -rf "${COMBINED_DIR}"
mkdir -p "${COMBINED_DIR}/train/images" "${COMBINED_DIR}/train/labels"

# 各サブディレクトリの train/images, train/labels をシンボリックリンクで集約
for d in "${DATASET_ROOT}"/*/train; do
  name=$(basename "$(dirname "$d")")  # book1, book2, …
  
  # 画像ファイルを集める
  if [ -d "${d}/images" ]; then
    for img in "${d}/images"/*; do
      ln -s "$(realpath "$img")" "${COMBINED_DIR}/train/images/${name}_$(basename "$img")"
    done
  fi
  
  # ラベルファイルを集める
  if [ -d "${d}/labels" ]; then
    for lbl in "${d}/labels"/*; do
      ln -s "$(realpath "$lbl")" "${COMBINED_DIR}/train/labels/${name}_$(basename "$lbl")"
    done
  fi
done

# YOLOv8 用の一時データ定義ファイルを作成
cat > data_train_only.yaml <<EOF
train: ${COMBINED_DIR}/train/images
val:
nc: 4
names: ['book1','book2','book3','living-room']
EOF

# .env の DATA_FILE を上書きして train.py を呼び出し
export DATA_FILE="data_train_only.yaml"
python train.py

