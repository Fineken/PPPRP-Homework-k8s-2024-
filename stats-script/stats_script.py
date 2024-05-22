import requests
import time

url = 'http://web-app-service:80/statistics'

time.sleep(30)

while True:
    try:
        response = requests.get(url)
        response.raise_for_status()  
        data = response.json()
        with open('stats.txt', 'a') as file:
            file.write(f"{data['time_requests_count']}\n")
    except requests.exceptions.RequestException as e:
        print(f"Error: {e}")
    time.sleep(5)
