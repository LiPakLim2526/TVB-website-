from flask import render_template, request, flash, redirect
from app import app

# 首頁
@app.route('/')
def index():
    return render_template("index.html")

# 導航 url_for('news') → 自動跳轉到 funnyhot 頁面
@app.route('/news')
def news():
    return redirect('/funnyhot')  # 👈 這裡改成跳轉！

# 娛樂焦點頁面
@app.route('/funnyhot')
def funnyhot():
    return render_template("funnyhot.html")

# 登入頁
@app.route('/login', methods=['GET', 'POST'])
def login():
    if request.method == 'POST':
        username = request.form.get('username')
        password = request.form.get('password')
        if username == "admin" and password == "123456":
            return redirect('/admin')
        else:
            flash("帳號或密碼錯誤")
    return render_template("login.html")

# 影片
@app.route('/videos')
def videos():
    return render_template("videos.html")

# 後台
@app.route('/admin')
def admin():
    return render_template("admin.html")