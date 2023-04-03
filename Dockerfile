FROM python:3.9-slim-buster

WORKDIR /app

COPY ./backend/requirements.txt .
RUN pip install -r requirements.txt

COPY . .

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "80"]
