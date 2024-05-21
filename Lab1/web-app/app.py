# app.py
from flask import Flask, jsonify
import datetime

app = Flask(__name__)
time_requests_count = 0

@app.route('/time', methods=['GET'])
def get_time():
    global time_requests_count
    time_requests_count += 1
    return jsonify({'current_time': datetime.datetime.now().isoformat()})

@app.route('/statistics', methods=['GET'])
def get_statistics():
    return jsonify({'time_requests_count': time_requests_count})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
