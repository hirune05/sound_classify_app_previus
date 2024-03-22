#!/usr/bin/env python
# coding: utf-8

# In[ ]:


import librosa
import librosa.display
import numpy as np
import matplotlib.pyplot as plt
import soundfile as sf

# 入力音源のパス
input_path = "C:/Users/ttymy/Dots to Code/sample.mp3"

# 特定の周波数帯域
target_low = 2000  # 例: 2000 Hz
target_high = 4000  # 例: 4000 Hz（警報器や赤ちゃんの声のような甲高い音）

# 増幅倍率
amplification_factor = 2.5

# 音声データの読み込み
y, sr = librosa.load(input_path, sr=None)

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
output_path = "C:/Users/ttymy/Dots to Code/amplified_sample.wav"

# 出力音源の保存
sf.write(output_path, y_amplified, sr)

print(f"Amplified audio saved to: {output_path}")
