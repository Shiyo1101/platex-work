# ドキュメントテンプレート

このフォルダは、新しいpLaTeXドキュメントを作成する際のテンプレートです。

## 使い方

1. このフォルダ全体をコピー
2. `documents/` 配下に新しい名前で配置（例: `documents/my-report/`）
3. `main.tex` を編集して執筆を開始

## フォルダ構成

```
template/
├── main.tex      # メインのLaTeXファイル
├── sections/     # 章ごとにファイルを分割する場合はここに配置
├── images/       # このドキュメント専用の画像ファイル
└── README.md     # このファイル
```

## ファイル分割の例

大きなドキュメントの場合、章ごとにファイルを分割すると管理しやすくなります。

### main.tex の例

```latex
\documentclass[12pt,a4paper,dvipdfmx]{jarticle}

% パッケージの読み込み
\usepackage[dvipdfmx]{graphicx}
\usepackage[dvipdfmx]{hyperref}
\usepackage{amsmath}

\title{タイトル}
\author{著者名}
\date{\today}

\begin{document}

\maketitle
\tableofcontents

\input{sections/introduction}
\input{sections/methods}
\input{sections/results}
\input{sections/conclusion}

\end{document}
```

### sections/ の例

- `sections/introduction.tex`: はじめに
- `sections/methods.tex`: 研究方法
- `sections/results.tex`: 結果
- `sections/conclusion.tex`: 結論

各ファイルは以下のように記述します：

```latex
% sections/introduction.tex
\section{はじめに}

ここに内容を記述します。
```

## 共有リソースの利用

### 共有画像の使用

`shared/images/` にある画像を使用する場合：

```latex
\includegraphics[width=0.8\textwidth]{../../shared/images/図の名前.pdf}
```

### カスタムスタイルの使用

`shared/styles/` にあるスタイルファイルを使用する場合：

```latex
\usepackage{../../shared/styles/mystyle}
```

### 参考文献の使用

`shared/bibliography/` にあるBibTeXファイルを使用する場合：

```latex
\bibliographystyle{jplain}
\bibliography{../../shared/bibliography/references}
```

## コンパイル

ファイルを保存すると自動的にコンパイルされます。

手動でコンパイルする場合：

```bash
platex main.tex
dvipdfmx main.dvi
```

## ヒント

- メインファイル名は `main.tex` に統一すると管理しやすい
- 章ごとにファイルを分割する場合は `\input{sections/filename}` を使用
- 画像は相対パスで指定するか、`\graphicspath{{images/}}` を設定
- 出力ファイルは `out/` に自動的に生成されます
