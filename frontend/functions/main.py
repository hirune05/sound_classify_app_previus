import os
import librosa
import numpy as np
import soundfile as sf
import ffmpeg
from google.cloud import storage
from firebase_admin import credentials, initialize_app
from firebase_functions import storage_fn

# Initialize Firebase Admin SDK
cred = credentials.ApplicationDefault()
initialize_app(cred)


# Function to process audio file
def process_audio(data, context):
    # Firebase Storageのバケットとファイルパスを取得
    bucket_name = data['bucket']
    file_name = data['name']

    # ローカルファイルパスの設定
    local_file_path = f'/tmp/{file_name}'
    processed_file_path = f'/tmp/processed_{file_name}'

    # Firebase Storageからファイルをダウンロード
    storage_client = storage.Client()
    bucket = storage_client.bucket(bucket_name)
    blob = bucket.blob(file_name)
    blob.download_to_filename(local_file_path)

    # m4a形式の音声ファイルをmp3形式に変換
    path = local_file_path
    to = "mp3"
    s = ffmpeg.input(path)
    s = ffmpeg.output(s, f"{path.split('.')[0]}.{to}")
    ffmpeg.run(s)

    # 入力音源のパス
    input_path = f"{path.split('.')[0]}.{to}"
    
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

    # 特定の周波数帯域を増幅
    D_magnitude_db_amplified = D_magnitude_db.copy()
    freqs = librosa.fft_frequencies(sr=sr)
    target_freqs_mask = (freqs >= target_low) & (freqs <= target_high)
    D_magnitude_db_amplified[target_freqs_mask, :] += amplification_factor

    # 逆STFTを実行して増幅された音声を取得
    D_amplified = librosa.db_to_amplitude(D_magnitude_db_amplified) * D_phase
    y_amplified = librosa.istft(D_amplified)
    
    # 出力音源のパス
    output_path = f"{processed_file_path}.wav"

    # 出力音源の保存
    sf.write(output_path, y_amplified, sr)
    
    # wav形式の音声ファイルをm4a形式に変換
    input_file = output_path
    output_file = f"{processed_file_path}.m4a"
    
    stream = ffmpeg.input(input_file)
    stream = ffmpeg.output(stream, output_file, acodec="aac", vcodec="copy")
    ffmpeg.run(stream)
    
    # 処理済みファイルを別のバケットにアップロード
    processed_bucket = storage_client.bucket('processed_audio_files')
    processed_blob = processed_bucket.blob(f'processed_{file_name}')
    processed_blob.upload_from_filename(output_file)

    # ローカルファイルを削除
    os.remove(local_file_path)
    os.remove(input_path)
    os.remove(output_path)
    os.remove(output_file)

# Storage trigger for processing audio files
@storage_fn.on_finalize("audio_files/{file_name}")
def on_finalize_process_audio(data, context):
    process_audio(data, context)
