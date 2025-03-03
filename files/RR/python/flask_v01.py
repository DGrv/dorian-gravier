from flask import Flask, request, jsonify
import json
from datetime import datetime

app = Flask(__name__)

# File to store GPS data
DATA_FILE = "gps_data.json"

def save_data(data):
    """Append GPS data to a JSON file."""
    try:
        with open(DATA_FILE, "a") as f:
            f.write(json.dumps(data) + "\n")
    except Exception as e:
        print(f"Error saving data: {e}")

@app.route('/trackbox-data', methods=['POST'])
def receive_gps_data():
    """Receive GPS data from the Track Box"""
    try:

        print("Raw request data:", request.data)  # Debugging line

        data = request.get_json()  # Get JSON data from request
        if not data:
            return jsonify({"error": "Invalid data"}), 400
        
        # Add a timestamp for tracking
        data["received_at"] = datetime.utcnow().isoformat()

        # Save the data
        save_data(data)

        print("Received GPS Data:", data)
        return jsonify({"status": "success", "message": "Data received"}), 200

    except Exception as e:
        print(f"Error: {e}")
        return jsonify({"error": "Server error"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=True)  # Runs on port 5000


# curl -X POST http://localhost:5000/trackbox-data -H "Content-Type: application/json" -d "{\"id\": \"123456\", \"latitude\": 48.858844, \"longitude\": 2.294351}"