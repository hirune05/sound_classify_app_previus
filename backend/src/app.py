from flask import Flask, request, send_file
import io
import sound_classify_app.backend.src.main as aps

app = Flask(__name__)


@app.route("/process_audio", methods=["POST"])
def process_audio():
    # Flutter アプリからオーディオファイルを受け取る
    audio_file = request.files["audio_file"]

    # 一時ファイルに保存
    tmp_input_path = "tmp_input.mp3"
    audio_file.save(tmp_input_path)

    # main.pyを実行
    tmp_output_path = "tmp_output.wav"
    aps.input_path = tmp_input_path
    aps.output_path = tmp_output_path
    aps.process_audio()

    # 処理後の音声ファイルを Flutter アプリに返す
    output_data = io.BytesIO()
    with open(tmp_output_path, "rb") as f:
        output_data.write(f.read())
    output_data.seek(0)

    return send_file(output_data, mimetype="audio/wav")


if __name__ == "__main__":
    app.run()
