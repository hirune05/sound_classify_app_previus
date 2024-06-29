from firebase_functions import firestore_fn, https_fn, storage_fn
from firebase_admin import initialize_app, storage, firestore
import os
import pathlib
import librosa
import numpy as np
import soundfile as sf
import ffmpeg
import google.cloud.firestore
from firebase_functions import storage_fn
from firebase_admin import initialize_app, storage, credentials

# Firebaseアプリの初期化。ストレージバケットを明示的に指定します。
cred = credentials.ApplicationDefault()
initialize_app(cred, {
    'storageBucket': 'cocomakers-sound-classify-app.appspot.com'  # バケット名を指定します
})

@storage_fn.on_object_finalized(bucket="cocomakers-sound-classify-app.appspot.com", region='asia-northeast1')
def process_audio(event: storage_fn.CloudEvent[storage_fn.StorageObjectData]):
    bucket_name = event.data.bucket
    file_path = pathlib.PurePath(event.data.name)
    content_type = event.data.content_type
    if not content_type or not content_type.startswith("audio/x-m4a"):
        print(f"Unsupported content type: {content_type}")
        return

    if file_path.name.startswith("edited_"):
        print("Already edited.")
        return

    bucket = storage.bucket(bucket_name)

    input_blob = bucket.blob(str(file_path))
    input_path = f"/tmp/{file_path.name}"
    input_blob.download_to_filename(input_path)

    # Convert m4a to mp3
    mp3_filename = f"{file_path.stem}.mp3"
    mp3_path = f"/tmp/{mp3_filename}"
    try:
        ffmpeg.input(input_path).output(mp3_path).run()
    except ffmpeg.Error as e:
        print(f"Error converting m4a to mp3: {e}")
        return

    # Verify that the mp3 file was created successfully
    if not os.path.exists(mp3_path):
        print(f"mp3 file not found at {mp3_path}")
        return
    else:
        print(f"mp3 file successfully created at {mp3_path}")

    # Audio processing
    try:
        y, sr = librosa.load(mp3_path, sr=48000)
    except Exception as e:
        print(f"Error loading mp3 file with librosa: {e}")
        return
    
    D = librosa.stft(y)
    D_magnitude, D_phase = librosa.magphase(D)
    D_magnitude_db = librosa.amplitude_to_db(D_magnitude, ref=np.max)

    # Amplify specific frequency band
    target_low = 2000
    target_high = 4000
    amplification_factor = 2.5
    freqs = librosa.fft_frequencies(sr=sr)
    target_freqs_mask = (freqs >= target_low) & (freqs <= target_high)
    D_magnitude_db[target_freqs_mask, :] += amplification_factor

    D_amplified = librosa.db_to_amplitude(D_magnitude_db) * D_phase
    y_amplified = librosa.istft(D_amplified)

    # Save the edited file
    output_filename = f"edited_{file_path.stem}.wav"
    output_path = f"/tmp/{output_filename}"
    sf.write(output_path, y_amplified, sr)

    # Convert wav to m4a
    output_m4a_filename = f"edited_{file_path.stem}.m4a"
    output_m4a_path = f"/tmp/{output_m4a_filename}"
    try:
        ffmpeg.input(output_path).output(output_m4a_path, acodec="aac").run()
    except ffmpeg.Error as e:
        print(f"Error converting wav to m4a: {e}")
        return

    # Upload the processed file to Cloud Storage
    output_blob = bucket.blob(f"edited/{output_m4a_filename}")
    output_blob.upload_from_filename(output_m4a_path)

    # Clean up temporary files
    os.remove(input_path)
    os.remove(mp3_path)
    os.remove(output_path)
    os.remove(output_m4a_path)

    print(f"Processed file uploaded to edited/{output_m4a_filename}")