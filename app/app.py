from flask import Flask, request, render_template
import pyodbc
from db_config import get_db_connection

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():
    conn = get_db_connection()
    cursor = conn.cursor()

    if request.method == "POST":
        name = request.form["name"]
        cursor.execute("INSERT INTO users (name) VALUES (?)", name)
        conn.commit()

    cursor.execute("SELECT * FROM users")
    users = cursor.fetchall()

    return render_template("index.html", users=users)

@app.route("/health")
def health():
    try:
        conn = get_db_connection()
        conn.cursor().execute("SELECT 1")
        return "Database connection: OK", 200
    except Exception as e:
        return f"Database connection failed: {e}", 500

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)