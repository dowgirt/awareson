from flask import Flask, request, render_template, redirect
import os
import mysql.connector
from mysql.connector import Error

app = Flask(__name__)

def get_db_connection():
    conn_str = (
        "DRIVER={ODBC Driver 17 for SQL Server};"
        f"SERVER={os.getenv('DB_HOST')};"
        f"DATABASE={os.getenv('DB_NAME')};"
        f"UID={os.getenv('DB_USER')};"
        f"PWD={os.getenv('DB_PASSWORD')}"
    )
    return pyodbc.connect(conn_str)

@app.route("/", methods=["GET", "POST"])
def index():
    conn = get_db_connection()
    cursor = conn.cursor()
    if request.method == "POST":
        name = request.form["name"]
        cursor.execute("INSERT INTO users (name) VALUES (%s)", (name,))
        conn.commit()
    cursor.execute("SELECT * FROM users")
    users = cursor.fetchall()
    conn.close()
    return render_template("index.html", users=users)

@app.route("/healthz")
def healthz():
    try:
        conn = get_db_connection()
        conn.close()
        return "Database Connected", 200
    except Error:
        return "Database Connection Failed", 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=80)
