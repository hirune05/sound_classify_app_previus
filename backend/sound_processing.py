import pyaudio
import wave
import numpy as np

def record_audio(output_path, record_time=5):
    CHUNK = 1024
    FORMAT = pyaudio.paInt16
    CHANNELS = 1
    RATE = 44100

    p = pyaudio.PyAudio()

    stream = p.open(format=FORMAT,
                    channels=CHANNELS,
                    rate=RATE,
                    input=True,
                    frames_per_buffer=CHUNK)

    print("Recording ...")
    frames = []
    for i in range(0, int(RATE / CHUNK * record_time)):
        data = stream.read(CHUNK)
        frames.append(data)
    print("Done.")

    stream.stop_stream()
    stream.close()
    p.terminate()

    wf = wave.open(output_path, 'wb')
    wf.setnchannels(CHANNELS)
    wf.setsampwidth(p.get_sample_size(FORMAT))
    wf.setframerate(RATE)
    wf.writeframes(b''.join(frames))
    wf.close()

def process_audio(input_path, output_path, target_low, target_high, amplification_factor):
    y, sr = librosa.load(input_path)
    
    # FFTを実行
    fft_data = np.fft.fft(y)
    frequencies = np.fft.fftfreq(len(fft_data), 1.0/sr)

    # 特定の周波数帯域を取り出す
    target_frequency_index = np.where((frequencies > target_low) & (frequencies < target_high))[0]
    target_fft_data = fft_data[target_frequency_index]

    # 増幅処理
    amplified_fft_data = target_fft_data * amplification_factor

    # IFFTを使用した時間領域への変換
    amplified_time_domain_data = np.fft.ifft(amplified_fft_data)

    # 音声出力
    stream = pyaudio.PyAudio().open(format=pyaudio.paInt16, channels=1, rate=sr, output=True)
    stream.write(amplified_time_domain_data.astype(np.int16).tobytes())
    stream.close()

if __name__ == "__main__":
    # 録音
    output_path = "output.wav"
    record_audio(output_path)

    # 音声処理
    input_path = output_path
    target_low = 500
    target_high = 2000
    amplification_factor = 2.0
    process_audio(input_path, output_path, target_low, target_high, amplification_factor)
