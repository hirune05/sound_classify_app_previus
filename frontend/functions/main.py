import os
import librosa
import numpy as np
import soundfile as sf
import ffmpeg
from google.cloud import storage

def process_audio(event, context):
    bucket_name = event['bucket']
    input_filename = event['name']

    # Cloud Storageクライアントの初期化
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    input_blob = bucket.blob(input_filename)
    input_path = f"/tmp/{input_filename}"
    input_blob.download_to_filename(input_path)

    # m4a形式の音声ファイルをmp3形式に変換
    mp3_filename = f"{input_filename.split('.')[0]}.mp3"
    mp3_path = f"/tmp/{mp3_filename}"
    ffmpeg.input(input_path).output(mp3_path).run()

    # 音声編集処理
    y, sr = librosa.load(mp3_path, sr=70000)
    D = librosa.stft(y)
    D_magnitude, D_phase = librosa.magphase(D)
    D_magnitude_db = librosa.amplitude_to_db(D_magnitude, ref=np.max)
    
    # 特定の周波数帯域を増幅
    target_low = 2000
    target_high = 4000
    amplification_factor = 2.5
    D_magnitude_db_amplified = D_magnitude_db.copy()
    freqs = librosa.fft_frequencies(sr=sr)
    target_freqs_mask = (freqs >= target_low) & (freqs <= target_high)
    D_magnitude_db_amplified[target_freqs_mask, :] += amplification_factor

    D_amplified = librosa.db_to_amplitude(D_magnitude_db_amplified) * D_phase
    y_amplified = librosa.istft(D_amplified)

    # 編集後のファイルを保存
    output_filename = f"edited_{input_filename.split('.')[0]}.wav"
    output_path = f"/tmp/{output_filename}"
    sf.write(output_path, y_amplified, sr)

    # wav形式の音声ファイルをm4a形式に変換
    output_m4a_filename = f"edited_{input_filename.split('.')[0]}.m4a"
    output_m4a_path = f"/tmp/{output_m4a_filename}"
    ffmpeg.input(output_path).output(output_m4a_path, acodec="aac", vcodec="copy").run()

    # Cloud Storageにアップロード
    output_blob = bucket.blob(f"edited/{output_m4a_filename}")
    output_blob.upload_from_filename(output_m4a_path)

    print(f"Processed file uploaded to edited/{output_m4a_filename}")
