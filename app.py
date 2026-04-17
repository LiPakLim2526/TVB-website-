import os
from flask import Flask, render_template
from flask_mysqldb import MySQL
from dotenv import load_dotenv

# 讀取 .env 文件中的內容
load_dotenv()

app = Flask(__name__)

# 使用環境變量，如果找不到則使用預設值
app.config['MYSQL_HOST'] = os.getenv('DB_HOST', 'localhost')
app.config['MYSQL_USER'] = os.getenv('DB_USER', 'root')
app.config['MYSQL_PASSWORD'] = os.getenv('DB_PASS')  # 密碼從環境變量讀取
app.config['MYSQL_DB'] = os.getenv('DB_NAME', 'tvb_db')

mysql = MySQL(app)

@app.route('/')
def index():
    try:
        cur = mysql.connection.cursor()
        cur.execute("SELECT title, category, image_url FROM videos")
        video_list = cur.fetchall()
        cur.close()
        return render_template('index.html', videos=video_list)
    except Exception as e:
        # 如果數據庫連接失敗，給一個空的列表，防止網頁報錯
        print(f"Database error: {e}")
        return render_template('index.html', videos=[])

if __name__ == '__main__':
    app.run(debug=True)