#!/usr/bin/env perl

# pLaTeX + dvipdfmx を使用
$latex = 'platex -synctex=1 -interaction=nonstopmode -file-line-error';
$bibtex = 'pbibtex';
$dvipdf = 'dvipdfmx %O -o %D %S';
$makeindex = 'mendex %O -o %D %S';
$pdf_mode = 3; # use dvipdf

# 出力ディレクトリ
$out_dir = 'out';

# クリーンアップ対象ファイル
$clean_ext = 'synctex.gz nav snm dvi';
