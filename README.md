# practice_r
多くのR入門サイト・本のようにRの使い方を基礎から順番に学ぶのではなく、実装を進めていく上で必要なもの必要なときに順番に紹介するという思想のもと作成しています。あくまでRの基礎の網羅が目的ではないので、別途他のサイトや本を参考にすることをお勧めします。


## 目的
- Rで簡単な計量経済学の分析・シミュレーションをできるようになるための基礎を学ぶ。
- Rで実際に分析をしながら実践的な使い方を学ぶ。


## 対象
以下の様な方を対象としたスライドです。
- 学部初級レベルの計量経済学の知識がある。
- 授業でRに触れたことはあるが慣れていない。


## お断り
- パッケージの詳しい使い方については触れません。
- Rの初歩を網羅的に学ぶことは目的としていません。
- 数学的な理論や厳密性は簡単のため省略しています。
- 著者は普段Rをあまり使用しないのでおかしな点があるかもしれません。

## フォルダ構成
- data: データ保存用のフォルダ
    - sample.csv: 説明に使うためのサンプルデータ
- fig: Rでプロットした画像の保存用フォルダ
- results: シミュレーション結果の保存用フォルダ
- slide: スライドのソースコードとスライドPDFの保存用フォルダ
    - pic4slide: スライドに必要な画像
- src: Rのソースコード
    - sample_genData.R: sample.csv作成のためのコード
    - sample_ls.R: data内のsample.csvを回帰分析するコード
    - sample_simulation.R: 回帰分析のLS推定量のシミュレーションを行うためのコード

## 環境
- MacBook Pro(M2), macOS Monterey 12.4
- R: 4.2.1
    - tidyverse: 1.3.2
        - ggplot2: 3.3.6
        - dplyr: 1.0.9
        - readr: 2.1.2
    - estimatr 1.0.0

## Demo
単回帰モデルの推定
```bash
Rscript src/sample_ls.R
```
LS推定のシミュレーション
```bash
Rscript src/sample_simulation.R
```

## License
This repository is under MIT License.
