#!/usr/bin/env bash
set -euo pipefail

# ダウンロード先フォルダの設定
FOLDER_ID="1Z1nFWLJ9pH8GGaJ14--AZ2FFhLVe7iRe"
DEST_DIR="dataset"

# gdown の有無をチェックし、なければインストール
if ! command -v gdown >/dev/null; then
    echo "gdown が見つかりません。インストールします..."
    python3 -m pip install --user gdown
fi

# 出力ディレクトリを作成
mkdir -p "${DEST_DIR}"

# Google Drive フォルダを丸ごとダウンロード
echo "Google Drive からデータセットをダウンロード中..."
gdown --folder "https://drive.google.com/drive/folders/${FOLDER_ID}" -O "${DEST_DIR}"

echo "ダウンロード完了: ${DEST_DIR}"

