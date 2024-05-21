from flask import Flask, jsonify
import requests

app = Flask(__name__)

@app.route('/time', methods=['GET'])
def get_time():
    response = requests.get('http://worldtimeapi.org/api/timezone/Europe/Moscow')
    data = response.json()
    return jsonify({'datetime': data['datetime']})

@app.route('/statistics', methods=['GET'])
def get_statistics():
    global time_requests_count
    return jsonify({'time_requests_count': time_requests_count})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
