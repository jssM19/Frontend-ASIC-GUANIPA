FROM python:3-alpine3.23

WORKDIR /app

COPY ./build/web /app

CMD ["python", "-m", "http.server", "${PORT:-8000}"]
