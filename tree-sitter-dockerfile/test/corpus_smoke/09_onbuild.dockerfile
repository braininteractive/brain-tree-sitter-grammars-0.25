FROM python:3.12-slim
ONBUILD COPY requirements.txt /app/
ONBUILD RUN pip install -r /app/requirements.txt
WORKDIR /app
CMD ["python"]
