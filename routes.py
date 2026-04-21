from flask import render_template, request, flash, redirect
from app import app


@app.route('/')
def index():
    return render_template("index.html")


@app.route('/news')
def news():
    return redirect('/funnyhot')  


@app.route('/funnyhot')
def funnyhot():
    return render_template("funnyhot.html")


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


@app.route('/videos')
def videos():
    return render_template("videos.html")


@app.route('/admin')
def admin():
    return render_template("admin.html")