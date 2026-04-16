from flask import Flask, render_template
from flask_mysqldb import MySQL  

app = Flask(__name__)

app.config['MYSQL_HOST'] = 'localhost'
app.config['MYSQL_USER'] = 'root'
app.config['MYSQL_PASSWORD'] = 'rootroot' 
app.config['MYSQL_DB'] = 'tvb_db'

mysql = MySQL(app) 

@app.route('/')
def index():
    cur = mysql.connection.cursor() 
    cur.execute("SELECT title, category, image_url FROM videos")
    video_list = cur.fetchall()
    cur.close()
    return render_template('index.html', videos=video_list)

if __name__ == '__main__':
    app.run(debug=True)