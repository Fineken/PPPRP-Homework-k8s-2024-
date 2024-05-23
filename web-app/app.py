from flask import Flask, request, jsonify
from datetime import datetime

global counter
counter = 0
app = Flask(__name__)

@app.route('/time', methods=['GET'])
def get_time():
    global counter
    counter += 1
    return jsonify({'time': str(datetime.now())})

@app.route('/statistics', methods=['GET'])
def get_statistics():
    global counter
    return jsonify({'count': counter})

if __name__ == 'main':
    app.run(debug=True)
