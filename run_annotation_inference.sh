#!/usr/bin/env bash
set -euo pipefail

# アノテーション用画像フォルダ
ANNOT_DIR="annotation"

# フォルダ存在チェック
if [ ! -d "${ANNOT_DIR}" ]; then
  echo "Error: ${ANNOT_DIR} ディレクトリが見つかりません" >&2
  exit 1
fi

# 環境変数 INPUT_IMAGE にフォルダを設定して detect.py を実行
export INPUT_IMAGE="${ANNOT_DIR}"
python detect.py

