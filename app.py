import os
from flask import Flask
from reactpy import component, html, run

app = Flask(__name__)



@app.route('/')
def hello_world():
    # Inserta "Hello World" en la base de datos

    return html.h1("Hello, world!")

if __name__ == '__main__':
    # Crea las tablas en la base de datos (solo se debe hacer una vez)
   
    app.run(debug=True, host='0.0.0.0')


