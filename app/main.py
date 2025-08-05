from flask import Flask
import os
import psycopg2

app = Flask(__name__)

@app.route('/')
def index():
    try:
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST'),
            database=os.getenv('DB_NAME'),
            user=os.getenv('DB_USER'),
            password=os.getenv('DB_PASSWORD')
        )
        return "Conectado ao banco com sucesso!"
    except Exception as e:
        return f"Erro ao conectar ao banco: {e}"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)