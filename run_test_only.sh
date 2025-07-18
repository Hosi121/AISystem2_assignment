#!/usr/bin/env bash
set -euo pipefail

# 元データセットルートと結合先ディレクトリ
DATASET_ROOT="dataset"
COMBINED_DIR="dataset_combined"
COMBINED_TEST_IMG_DIR="${COMBINED_DIR}/test/images"

# 既存の結合先をクリアしてディレクトリを再作成
rm -rf "${COMBINED_TEST_IMG_DIR}"
mkdir -p "${COMBINED_TEST_IMG_DIR}"

# 各クラスの test/images をシンボリックリンクでまとめる
for img_dir in "${DATASET_ROOT}"/*/test/images; do
  class_name=$(basename "$(dirname "$(dirname "$img_dir")")")
  for img in "${img_dir}"/*; do
    ln -s "$(realpath "$img")" \
      "${COMBINED_TEST_IMG_DIR}/${class_name}_$(basename "$img")"
  done
done

# 環境変数 INPUT_IMAGE に結合後ディレクトリを設定し、detect.py を呼び出す
export INPUT_IMAGE="${COMBINED_TEST_IMG_DIR}"
python detect.py

