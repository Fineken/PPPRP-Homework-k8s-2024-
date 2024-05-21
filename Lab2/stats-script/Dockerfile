# Dockerfile
FROM python:3.9-slim

WORKDIR /app

COPY requirements.txt requirements.txt
RUN pip install -r requirements.txt

COPY stats_script.py stats_script.py

CMD ["python", "stats_script.py"]
