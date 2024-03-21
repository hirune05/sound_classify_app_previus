from flask import Flask, request, jsonify
from sound_processing import record_audio, process_audio

app = Flask(__name__)

@app.route('/record', methods=['POST'])
def record():
    output_path = "output.wav"
    record_audio(output_path)
    return jsonify({"message": "Recording completed.", "output_path": output_path})

@app.route('/process', methods=['POST'])
def process():
    input_path = "output.wav"
    target_low = 500
    target_high = 2000
    amplification_factor = 2.0
    process_audio(input_path, output_path, target_low, target_high, amplification_factor)
    return jsonify({"message": "Audio processing completed."})

if __name__ == "__main__":
    app.run(debug=True)
