#!/bin/bash
# どうぶつ音声生成スクリプト（VOICEVOX使用）
# 事前にVOICEVOXを起動しておくこと: http://localhost:50021

SPEAKER=20  # もち子さん
AUDIO_DIR="./audio"
mkdir -p "$AUDIO_DIR"

generate_wav() {
  local text="$1"
  local output="$2"
  local encoded=$(python3 -c "import urllib.parse; print(urllib.parse.quote('$text'))")
  local query=$(curl -s -X POST "http://localhost:50021/audio_query?speaker=${SPEAKER}&text=${encoded}")
  if [ -z "$query" ]; then
    echo "ERROR: VOICEVOXに接続できません"
    exit 1
  fi
  curl -s -X POST "http://localhost:50021/synthesis?speaker=${SPEAKER}" \
    -H "Content-Type: application/json" \
    -d "$query" \
    -o "$output"
  echo "生成: $output ($text)"
}

echo "=== どうぶつ音声生成 (VOICEVOX: もち子さん) ==="

# いえの どうぶつ
generate_wav "いぬ"     "$AUDIO_DIR/inu.wav"
generate_wav "ねこ"     "$AUDIO_DIR/neko.wav"
generate_wav "うさぎ"   "$AUDIO_DIR/usagi.wav"
generate_wav "ぶた"     "$AUDIO_DIR/buta.wav"
generate_wav "うし"     "$AUDIO_DIR/ushi.wav"
generate_wav "ひつじ"   "$AUDIO_DIR/hitsuji.wav"
generate_wav "うま"     "$AUDIO_DIR/uma.wav"
generate_wav "にわとり" "$AUDIO_DIR/niwatori.wav"

# もりの どうぶつ
generate_wav "くま"   "$AUDIO_DIR/kuma.wav"
generate_wav "さる"   "$AUDIO_DIR/saru.wav"
generate_wav "きつね" "$AUDIO_DIR/kitsune.wav"
generate_wav "ぱんだ" "$AUDIO_DIR/panda.wav"
generate_wav "こあら" "$AUDIO_DIR/koala.wav"
generate_wav "りす"   "$AUDIO_DIR/risu.wav"

# サバンナの どうぶつ
generate_wav "ぞう"     "$AUDIO_DIR/zou.wav"
generate_wav "きりん"   "$AUDIO_DIR/kirin.wav"
generate_wav "らいおん" "$AUDIO_DIR/raion.wav"
generate_wav "しまうま" "$AUDIO_DIR/shimauma.wav"
generate_wav "かば"     "$AUDIO_DIR/kaba.wav"

# うみの いきもの
generate_wav "さかな" "$AUDIO_DIR/sakana.wav"
generate_wav "くじら" "$AUDIO_DIR/kujira.wav"
generate_wav "いるか" "$AUDIO_DIR/iruka.wav"
generate_wav "たこ"   "$AUDIO_DIR/tako.wav"
generate_wav "かに"   "$AUDIO_DIR/kani.wav"

# むし・は虫類
generate_wav "ちょうちょ" "$AUDIO_DIR/choucho.wav"
generate_wav "かえる"     "$AUDIO_DIR/kaeru.wav"
generate_wav "かめ"       "$AUDIO_DIR/kame.wav"
generate_wav "へび"       "$AUDIO_DIR/hebi.wav"
generate_wav "あひる"     "$AUDIO_DIR/ahiru.wav"

echo "=== 褒め言葉 ==="
generate_wav "すごい！"             "$AUDIO_DIR/sugoi.wav"
generate_wav "やったね！"           "$AUDIO_DIR/yattane.wav"
generate_wav "てんさい！"           "$AUDIO_DIR/tensai.wav"
generate_wav "かっこいい！"         "$AUDIO_DIR/kakkoii.wav"
generate_wav "すばらしい！"         "$AUDIO_DIR/subarashii.wav"
generate_wav "やったね！おめでとう！" "$AUDIO_DIR/yattane_big.wav"

echo "=== 完了 ==="
