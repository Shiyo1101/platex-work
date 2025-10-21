# LuaLaTeX 執筆環境

このリポジトリは、DevContainerを使用したLuaLaTeX執筆環境です。

## 機能

- **LuaLaTeX**: 最新のTeXLiveを使用したLuaLaTeXコンパイル環境
- **リンター**: ChkTeXによるLaTeX構文チェック
- **フォーマッター**: latexindentによる自動整形（保存時に実行）
- **プレビュー**: VS Code内でのPDFプレビュー機能
- **Markdownサポート**: Markdownプレビューと編集支援機能
- **Git管理**: バージョン管理機能

## 前提条件

- [Docker](https://www.docker.com/)
- [Visual Studio Code](https://code.visualstudio.com/)
- [Dev Containers拡張機能](https://marketplace.visualstudio.com/items?itemName=ms-vscode-remote.remote-containers)

## 使い方

### 1. 環境の起動

1. VS Codeでこのフォルダを開く
2. コマンドパレット（`Cmd+Shift+P` / `Ctrl+Shift+P`）を開く
3. `Dev Containers: Reopen in Container` を選択
4. コンテナのビルドと起動を待つ（初回は数分かかります）

### 2. LaTeX文書の作成

1. `.tex` ファイルを作成または編集
2. ファイルを保存すると自動的にコンパイルが実行されます
3. VS Code右側にPDFプレビューが表示されます

### 3. コンパイル

#### 自動コンパイル（GUIを使用）

- ファイル保存時に自動的にLuaLaTeXでコンパイルされます

#### 手動コンパイル（GUIを使用）

- `Cmd+Option+B` / `Ctrl+Alt+B`: ビルド実行
- LaTeX Workshopのサイドバーから「Build LaTeX project」を選択

#### CLIからのコンパイル（GUIが使えない場合）

VS Codeのターミナルを開いて、以下のコマンドを実行します：

**基本的なコンパイル:**

```bash
lualatex sample.tex
```

**より詳細な出力を得る:**

```bash
lualatex -synctex=1 -interaction=nonstopmode -file-line-error sample.tex
```

**BibTeXを使用する場合:**

```bash
lualatex sample.tex
bibtex sample
lualatex sample.tex
lualatex sample.tex
```

**latexmkを使用する場合（推奨）:**

```bash
# LuaLaTeXで自動コンパイル
latexmk -lualatex sample.tex

# PDFが生成されたら確認
ls -lh sample.pdf
```

**生成されたファイルをクリーンアップ:**

```bash
# 補助ファイルを削除
latexmk -c

# PDF含めてすべて削除
latexmk -C
```

**ターミナルでPDFを開く（macOS）:**

```bash
open sample.pdf
```

**ターミナルでPDFを開く（Linux）:**

```bash
xdg-open sample.pdf
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

### 7. Markdownプレビュー

Markdownファイル（`.md`）を編集する場合：

**プレビューを開く（標準方法）:**

- `Cmd+Shift+V` / `Ctrl+Shift+V`: プレビューを別タブで表示
- `Cmd+K V` / `Ctrl+K V`: プレビューを横に並べて表示

**コンテナで標準コマンドが動作しない場合:**

VS Codeの組み込みMarkdownプレビューコマンドがコンテナ内で見つからない場合（`command 'markdown.showPreviewToSide' not found`エラー）は、以下を試してください：

1. **コマンドパレットから手動で開く:**
   - `Cmd+Shift+P` / `Ctrl+Shift+P` でコマンドパレットを開く
   - 「Markdown: Open Preview」を検索して実行

2. **Markdown All in Oneのコマンドを使用:**
   - コマンドパレットで「Markdown All in One: Print」などのコマンドを検索

3. **コンテナを再起動:**
   ```
   Dev Containers: Rebuild Container
   ```

4. **拡張機能の確認:**
   - 左サイドバーの拡張機能アイコンをクリック
   - 「Markdown All in One」がインストールされていることを確認

**便利な機能:**

- 目次の自動生成
- リンクの補完
- Markdownリンター（構文チェック）
- 整形（`Shift+Option+F` / `Shift+Alt+F`）

## ファイル構成

```
.
├── .devcontainer/
│   ├── devcontainer.json    # DevContainer設定
│   └── Dockerfile           # Docker環境定義
├── .vscode/
│   └── settings.json        # VS Code設定
├── .latexindent.yaml        # latexindent設定
├── .gitignore               # Git除外設定
├── sample.tex               # サンプルLaTeX文書
└── README.md                # このファイル
```

## カスタマイズ

### フォント設定

`sample.tex` の以下の部分を編集してフォントを変更できます：

```latex
\setmainjfont{IPAMincho}
\setsansjfont{IPAGothic}
```

### コンパイル設定

`.vscode/settings.json` で以下を変更できます：

- `latex-workshop.latex.autoBuild.run`: 自動ビルドの設定
- `latex-workshop.latex.recipes`: コンパイルレシピ
- `editor.formatOnSave`: 保存時の自動整形

### インデント設定

`.latexindent.yaml` でインデントルールをカスタマイズできます

## トラブルシューティング

### コンパイルエラー

- 出力パネル（`Cmd+Shift+U` / `Ctrl+Shift+U`）で「LaTeX Compiler」を選択してエラー詳細を確認

### フォントエラー

- 日本語フォントが見つからない場合は、`sample.tex` のフォント設定を環境に合わせて変更してください

### コンテナが起動しない

1. Dockerが起動しているか確認
2. コマンドパレットから `Dev Containers: Rebuild Container Without Cache` を実行

### LaTeX Workshop拡張機能が動作しない

コマンドが見つからないエラー（`command 'latex-workshop.build' not found`）が出る場合：

1. コンテナ内で拡張機能が正しくインストールされているか確認
   - 左サイドバーの拡張機能アイコンをクリック
   - 「INSTALLED」セクションに「LaTeX Workshop」があるか確認
2. コンテナを再ビルド: `Dev Containers: Rebuild Container Without Cache`
3. それでも解決しない場合は、CLIからのコンパイル（上記参照）を使用

### Markdownプレビューが表示されない

`command 'markdown.showPreviewToSide' not found` エラーが出る場合：

**原因:** VS Codeの組み込みMarkdown拡張機能がコンテナ内で正しく読み込まれていない

**解決策:**

1. **コンテナを再起動:**
   ```
   Dev Containers: Rebuild Container
   ```

2. **コマンドパレットから手動で開く:**
   - `Cmd+Shift+P` / `Ctrl+Shift+P`
   - 「Markdown: Open Preview」を検索して実行
   - または「Markdown: Open Preview to the Side」を検索

3. **拡張機能の確認:**
   - 左サイドバーの拡張機能アイコンをクリック
   - 「Markdown All in One」がコンテナ内にインストールされているか確認
   - インストールされていない場合は、コンテナ内で再インストール

4. **VS Code Windowをリロード:**
   - コマンドパレット → 「Developer: Reload Window」

5. **キーボードショートカットを試す:**
   - `Cmd+Shift+V` / `Ctrl+Shift+V`: プレビューを別タブで表示
   - `Cmd+K V` / `Ctrl+K V`: プレビューを横に並べて表示

## 参考リンク

**LaTeX関連:**

- [LaTeX Workshop](https://github.com/James-Yu/LaTeX-Workshop)
- [TeXLive](https://www.tug.org/texlive/)
- [LuaLaTeX](http://www.luatex.org/)
- [ChkTeX](https://www.nongnu.org/chktex/)
- [latexindent](https://github.com/cmhughes/latexindent.pl)

**Markdown関連:**

- [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
- [markdownlint](https://marketplace.visualstudio.com/items?itemName=DavidAnson.vscode-markdownlint)
