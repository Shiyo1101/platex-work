# pLaTeX 執筆環境

このリポジトリは、DevContainerを使用したpLaTeX執筆環境です。複数のドキュメントを整理して管理できる構造になっています。

## 機能

- **pLaTeX**: 最新のTeXLiveを使用したpLaTeXコンパイル環境
- **リンター**: ChkTeXによるLaTeX構文チェック
- **フォーマッター**: latexindentによる自動整形（保存時に実行）
- **プレビュー**: VS Code内でのPDFプレビュー機能
- **Markdownサポート**: Markdownプレビューと編集支援機能
- **Git管理**: バージョン管理機能

## 前提条件

- [Docker](https://www.docker.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## フォルダ構造

```
platex-work/
├── .devcontainer/          # DevContainer設定
│   ├── devcontainer.json
│   └── Dockerfile
├── .vscode/                # VS Code設定
│   └── settings.json
├── documents/              # ドキュメント管理
│   ├── sample/             # サンプルドキュメント
│   │   ├── main.tex
│   │   ├── sections/       # 章ごとのファイル
│   │   └── images/         # ドキュメント専用の画像
│   └── template/           # 新規ドキュメント用テンプレート
│       ├── main.tex
│       ├── sections/
│       └── images/
├── shared/                 # プロジェクト全体で共有するリソース
│   ├── images/             # 共有画像ファイル
│   ├── bibliography/       # 参考文献ファイル（.bibなど）
│   └── styles/             # カスタムスタイルファイル（.styなど）
├── out/                    # コンパイル出力先（Git管理対象外）
├── .latexindent.yaml       # latexindent設定
├── .gitignore              # Git除外設定
└── README.md               # このファイル
```

## 使い方

### 1. 環境の起動

1. VS Codeでこのフォルダを開く
2. コマンドパレット（`Cmd+Shift+P` / `Ctrl+Shift+P`）を開く
3. `Dev Containers: Reopen in Container` を選択
4. コンテナのビルドと起動を待つ（初回は数分かかります）

### 2. 新しいドキュメントの作成

#### テンプレートを使用する方法

1. `documents/template/` フォルダをコピー
2. 新しい名前に変更（例: `documents/my-document/`）
3. `main.tex` を編集して執筆開始

#### 手動で作成する方法

1. `documents/` 内に新しいフォルダを作成
2. `main.tex` ファイルを作成
3. 必要に応じて `sections/` や `images/` フォルダを作成

### 3. LaTeX文書の編集とコンパイル

1. `.tex` ファイルを作成または編集
2. ファイルを保存すると自動的にコンパイルが実行されます
3. VS Code右側にPDFプレビューが表示されます

#### 自動コンパイル（GUIを使用）

- ファイル保存時に自動的にpLaTeXとdvipdfmxでコンパイルされます

#### 手動コンパイル（GUIを使用）

- `Cmd+Option+B` / `Ctrl+Alt+B`: ビルド実行
- LaTeX Workshopのサイドバーから「Build LaTeX project」を選択

#### CLIからのコンパイル

VS Codeのターミナルを開いて、以下のコマンドを実行します：

**基本的なコンパイル:**

```bash
# pLaTeXでDVIファイルを生成
platex main.tex

# DVIファイルをPDFに変換
dvipdfmx main.dvi
```

**より詳細な出力を得る:**

```bash
platex -synctex=1 -interaction=nonstopmode -file-line-error main.tex
dvipdfmx main.dvi
```

**pBibTeXを使用する場合:**

```bash
platex main.tex
pbibtex main
platex main.tex
platex main.tex
dvipdfmx main.dvi
```

**生成されたファイルをクリーンアップ:**

```bash
# 補助ファイルを削除
rm -f *.aux *.log *.dvi *.toc *.lot *.lof *.out *.synctex.gz
```

### 4. PDF表示

- `Cmd+Option+V` / `Ctrl+Alt+V`: PDFをタブで表示
- サイドバーの「View LaTeX PDF」アイコンをクリック

### 5. コードの整形

- ファイル保存時に自動的に整形されます
- 手動で整形: `Shift+Option+F` / `Shift+Alt+F`

### 6. リンティング

- ChkTeXが自動的に実行され、問題がある場合は警告が表示されます
- 問題パネル（`Cmd+Shift+M` / `Ctrl+Shift+M`）で確認できます

## ドキュメント管理のベストプラクティス

### ドキュメントの配置

- 各ドキュメントは `documents/` 配下に個別のフォルダとして管理
- メインファイルは `main.tex` に統一すると管理しやすい
- 章ごとにファイルを分割する場合は `sections/` に配置

### 画像の管理

- ドキュメント専用の画像: `documents/<document-name>/images/`
- 複数のドキュメントで共有する画像: `shared/images/`

### スタイルファイルの管理

- カスタムスタイルファイル（.sty）は `shared/styles/` に配置
- 使用する際は `\usepackage{../../shared/styles/mystyle}` のように相対パスで指定

### 参考文献の管理

- BibTeXファイル（.bib）は `shared/bibliography/` に配置
- 複数のドキュメントで同じ参考文献を共有可能

## カスタマイズ

### コンパイル設定

`.devcontainer/devcontainer.json` の `latex-workshop.latex.recipes` で以下を変更できます：

- `pLaTeX`: 基本的なコンパイル（platex → dvipdfmx）
- `pLaTeX with pBibTeX`: 参考文献を含むコンパイル

### インデント設定

`.latexindent.yaml` でインデントルールをカスタマイズできます

## トラブルシューティング

### コンパイルエラー

- 出力パネル（`Cmd+Shift+U` / `Ctrl+Shift+U`）で「LaTeX Compiler」を選択してエラー詳細を確認
- DVIファイルが生成されているか確認: `ls -la *.dvi`

### 日本語が文字化けする

- pLaTeXでは `jarticle` や `jbook` などの日本語対応ドキュメントクラスを使用してください
- UTF-8エンコーディングでファイルを保存してください

### コンテナが起動しない

1. Dockerが起動しているか確認
2. コマンドパレットから `Dev Containers: Rebuild Container Without Cache` を実行

### LaTeX Workshop拡張機能が動作しない

コマンドが見つからないエラーが出る場合：

1. コンテナ内で拡張機能が正しくインストールされているか確認
2. コンテナを再ビルド: `Dev Containers: Rebuild Container Without Cache`
3. それでも解決しない場合は、CLIからのコンパイルを使用

## 参考リンク

**LaTeX関連:**

- [LaTeX Workshop](https://github.com/James-Yu/LaTeX-Workshop)
- [TeXLive](https://www.tug.org/texlive/)
- [pLaTeX](https://texwiki.texjp.org/?pLaTeX)
- [ChkTeX](https://www.nongnu.org/chktex/)
- [latexindent](https://github.com/cmhughes/latexindent.pl)

**Markdown関連:**

- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
