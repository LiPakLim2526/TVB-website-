from flask import Flask, render_template
from models import db

app = Flask(__name__)
# 這裡先用 SQLite 測試，之後部署 AWS 再換成 MySQL
app.config['SQLALCHEMY_DATABASE_URI'] = 'sqlite:///tvb.db'
app.config['SECRET_KEY'] = 'your_secret_key'

db.init_app(app)

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == '__main__':
    with app.app_context():
        db.create_all() # 自動建立資料庫表
    app.run(debug=True)