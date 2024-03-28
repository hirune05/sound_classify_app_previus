#!/usr/bin/env python
# coding: utf-8


import librosa
import librosa.display
import numpy as np
import matplotlib.pyplot as plt
import soundfile as sf
import ffmpeg

# m4a形式の音声ファイルをmp3形式に変換
path = "../frontend/assets/audio/sample.m4a"
to = "mp3"
s = ffmpeg.input(path)
s = ffmpeg.output(s, f"{path.split('.')[0]}.{to}")
ffmpeg.run(s)


# 入力音源のパス
input_path = "../frontend/assets/audio/sample.mp3"

# 特定の周波数帯域
target_low = 2000  # 例: 2000 Hz
target_high = 4000  # 例: 4000 Hz（警報器や赤ちゃんの声のような甲高い音）

# 増幅倍率
amplification_factor = 2.5

# 音声データの読み込み
y, sr = librosa.load(input_path, sr=70000)

# 短時間フーリエ変換（STFT）を実行
D = librosa.stft(y)
D_magnitude, D_phase = librosa.magphase(D)
D_magnitude_db = librosa.amplitude_to_db(D_magnitude, ref=np.max)

# 対数周波数スケールで表示
plt.figure(figsize=(10, 4))
librosa.display.specshow(D_magnitude_db, sr=sr, x_axis="time", y_axis="log")
plt.colorbar(format="%+2.0f dB")
plt.title("Original Spectrogram")
plt.show()

# 特定の周波数帯域を増幅
D_magnitude_db_amplified = D_magnitude_db.copy()
freqs = librosa.fft_frequencies(sr=sr)
target_freqs_mask = (freqs >= target_low) & (freqs <= target_high)
D_magnitude_db_amplified[target_freqs_mask, :] += amplification_factor

# 逆STFTを実行して増幅された音声を取得
D_amplified = librosa.db_to_amplitude(D_magnitude_db_amplified) * D_phase
y_amplified = librosa.istft(D_amplified)

# 出力音源のパス
output_path = "../frontend/assets/audio/aftersample.wav"

# 出力音源の保存
sf.write(output_path, y_amplified, sr)

# wav形式の音声ファイルをm4a形式に変換
input_file = "../frontend/assets/audio/aftersample.wav"
output_file = "../frontend/assets/audio/aftersample.m4a"

stream = ffmpeg.input(input_file)
stream = ffmpeg.output(stream, output_file, acodec="aac", vcodec="copy")
ffmpeg.run(stream)
