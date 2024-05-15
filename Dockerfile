FROM python:3.9

WORKDIR /app


RUN pip install reactpy flask

COPY . .

EXPOSE 5000

CMD [ "python", "app.py" ]