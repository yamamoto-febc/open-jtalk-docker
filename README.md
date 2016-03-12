
# Open JTalk image

Open JTalk + hts engine用イメージです。

## `Dockerfile` links

[`latest`](https://github.com/yamamoto-febc/openjtalk-docker)[(Dockerfile)](https://github.com/yamamoto-febc/openjtalk-docker)

## 使い方

### 起動コマンド書式

```bash
docker run -i --rm yamamotofebc/open_jtalk
```

### 音声ファイル(wav)作成の例
```bash
echo "合成したい文字" | docker run -i --rm yamamotofebc/open_jtalk > created.wav
```

### パラメータ(環境変数) 一覧

  * $JTALK_VOICE_FILE : 音声ファイル(htsvoice) : デフォルトは`""`
  * $JTALK_VOICE_TYPE : 音声ファイルタイプ(normal / angry / bashful / happy / sadのいずれか) : デフォルトは`normal`
  * $JTALK_OUTPUT : 出力先パス : デフォルトは`標準出力`

    **$JTALK_VOICE_FILEが指定されている場合は$JTALK_VOICE_TYPEは無視されます**

## docker-composeを使う場合

以下のようなdocker-compose.mlファイルを用意しておくと
環境変数の指定をまとめて行うことができます。

#### docker-compose.yml
```docker-compose
open_jtalk:
  image: yamamotofebc/open_jtalk
  environment:
    JTALK_VOICE_FILE: ""
    JTALK_VOICE_TYPE: "normal"
    JTALK_OUTPUT: ""
```

#### docker-composeでの実行例
```bash
echo "合成したい文字" | docker-compose run --rm open_jtalk > created.wav
```
