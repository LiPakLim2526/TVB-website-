from flask import Flask, render_template, redirect, url_for, flash, session
from models import db, User, UserProfile, Category, Video, Tag, NewsArticle, Banner, Comment, DataCenterItem, AccessLog
from werkzeug.security import generate_password_hash, check_password_hash
from flask import request, redirect, url_for, flash
from flask_mail import Mail, Message
import os

app = Flask(__name__)
app.config['SECRET_KEY'] = 'tvb_charity_2026_super_secret_key'


app.config['MAIL_SERVER'] = 'smtp.gmail.com'
app.config['MAIL_PORT'] = 587
app.config['MAIL_USE_TLS'] = True
app.config['MAIL_USERNAME'] = 'your_email@gmail.com'
app.config['MAIL_PASSWORD'] = 'your_email_password'
app.config['MAIL_DEFAULT_SENDER'] = '你的電郵@gmail.com'

mail = Mail(app)

app.config['SECRET_KEY'] = 'tvb_charity_secret_key_2026_very_secret'
app.config['SQLALCHEMY_DATABASE_URI'] = 'mysql+pymysql://root:rootroot@db:3306/tvb_charity_db?charset=utf8mb4'
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

db.init_app(app)

@app.context_processor
def inject_user():
    """
    全局上下文处理器：
    在所有模板中自动注入当前登录的 user 对象，
    无需在每个 render_template 中手动传递 user=user。
    """
    user = None
    if session.get('logged_in') and session.get('user_id'):
        user = User.query.get(session.get('user_id'))
    
    return dict(user=user)

@app.route('/')
def index():
    test_videos = [
        ("愛回家之開心速遞", "劇集", "/static/images/banner1.jpg", "https://www.tvb.com/dramanews-c/%E6%84%9B%E5%9B%9E%E5%AE%B6%E4%B9%8B%E9%96%8B%E5%BF%83%E9%80%9F%E9%81%9E%E7%AC%AC2787%E9%9B%86-%E8%80%81%E5%A9%86%E5%A5%B4Uncle%E6%90%AC%E5%85%A5%E6%88%91%E5%AE%B6-1013035"),
        ("正義女神｜許紹雄再爆神級演繹 爆喊講「我愛你」感動全城 丘梓謙自爆對戲強忍淚水：好有感覺", "劇集", "/static/images/banner2.jpg", "https://www.tvb.com/dramanews-c/%E6%AD%A3%E7%BE%A9%E5%A5%B3%E7%A5%9E-%E8%A8%B1%E7%B4%B9%E9%9B%84%E5%86%8D%E7%88%86%E7%A5%9E%E7%B4%9A%E6%BC%94%E7%B9%B9--%E7%88%86%E5%96%8A%E8%AC%9B-%E6%88%91%E6%84%9B%E4%BD%A0-%E6%84%9F%E5%8B%95%E5%85%A8%E5%9F%8E--%E4%B8%98%E6%A2%93%E8%AC%99%E8%87%AA%E7%88%86%E5%B0%8D%E6%88%B2%E5%BC%B7%E5%BF%8D%E6%B7%9A%E6%B0%B4-%E5%A5%BD%E6%9C%89%E6%84%9F%E8%A6%BA-1013037"),
        ("陳展鵬單文柔新居大公開！ 搬複式豪宅空間感十足 高EQ回應愈住愈「豪」", "藝人動態", "/static/images/banner3.jpg", "https://www.tvb.com/artiste-news-c/%E9%99%B3%E5%B1%95%E9%B5%AC%E5%96%AE%E6%96%87%E6%9F%94%E6%96%B0%E5%B1%85%E5%A4%A7%E5%85%AC%E9%96%8B--%E6%90%AC%E8%A4%87%E5%BC%8F%E8%B1%AA%E5%AE%85%E7%A9%BA%E9%96%93%E6%84%9F%E5%8D%81%E8%B6%B3-%E9%AB%98EQ%E5%9B%9E%E6%87%89%E6%84%88%E4%BD%8F%E6%84%88-%E8%B1%AA--1013040"),
        ("美食新聞報道｜中環地道韓式家庭料理 居港韓國人力推足料拌飯/辣炒豬肉", "TVB Plue", "/static/images/banner4.jpg", "https://www.tvb.com/tvbplusnews-c/%E7%BE%8E%E9%A3%9F%E6%96%B0%E8%81%9E%E5%A0%B1%E9%81%93-%E4%B8%AD%E7%92%B0%E5%9C%B0%E9%81%93%E9%9F%93%E5%BC%8F%E5%AE%B6%E5%BA%AD%E6%96%99%E7%90%86-%E5%B1%85%E6%B8%AF%E9%9F%93%E5%9C%8B%E4%BA%BA%E5%8A%9B%E6%8E%A8%E8%B6%B3%E6%96%99%E6%8B%8C%E9%A3%AF-%E8%BE%A3%E7%82%92%E8%B1%AC%E8%82%89-1012581"),
        ("正義女神線上看劇情懶人包！全25集劇透（持續更新）佘詩曼首套律政", "劇集", "/static/images/banner6.jpg", "https://www.tvb.com/dramanews-c/%E6%AD%A3%E7%BE%A9%E5%A5%B3%E7%A5%9E%E7%B7%9A%E4%B8%8A%E7%9C%8B%E5%8A%87%E6%83%85%E6%87%B6%E4%BA%BA%E5%8C%85-%E5%85%A825%E9%9B%86%E5%8A%87%E9%80%8F-%E6%8C%81%E7%BA%8C%E6%9B%B4%E6%96%B0-%E4%BD%98%E8%A9%A9%E6%9B%BC%E9%A6%96%E5%A5%97%E5%BE%8B%E6%94%BF%E5%8A%87-%E8%88%87%E9%99%B3%E7%85%92-%E4%BB%A5%E6%B3%95%E4%B9%8B%E5%90%8D-%E5%BC%95%E8%BF%B7%E9%80%94%E5%B0%91%E5%B9%B4%E6%AD%B8%E5%B2%B8-1012374"),
        ("穀雨｜用「穀雨三養」保健身體 中醫教7招養生 按摩1穴位加強氣血", "綜藝", "/static/images/banner5.jpg", "https://www.tvb.com/lifestyle-c/%E7%A9%80%E9%9B%A8-%E7%94%A8-%E7%A9%80%E9%9B%A8%E4%B8%89%E9%A4%8A-%E4%BF%9D%E5%81%A5%E8%BA%AB%E9%AB%94-%E4%B8%AD%E9%86%AB%E6%95%997%E6%8B%9B%E9%A4%8A%E7%94%9F-%E6%8C%89%E6%91%A91%E7%A9%B4%E4%BD%8D%E5%8A%A0%E5%BC%B7%E6%B0%A3%E8%A1%80-1013049"),
        ("生暗瘡｜中醫拆解生暗瘡2大成因 必學3穴位加快暗瘡凋謝/改善體質 推", "生活", "/static/images/banner8.jpg", "https://www.tvb.com/lifestyle-c/%E7%94%9F%E6%9A%97%E7%98%A1-%E4%B8%AD%E9%86%AB%E6%8B%86%E8%A7%A3%E7%94%9F%E6%9A%97%E7%98%A12%E5%A4%A7%E6%88%90%E5%9B%A0-%E5%BF%85%E5%AD%B83%E7%A9%B4%E4%BD%8D%E5%8A%A0%E5%BF%AB%E6%9A%97%E7%98%A1%E5%87%8B%E8%AC%9D-%E6%94%B9%E5%96%84%E9%AB%94%E8%B3%AA-%E6%8E%A8%E4%BB%8B%E5%81%A5%E8%84%BE%E5%8E%BB%E6%BF%95%E6%B9%AF-1013044"),
        ("女神配對計劃2｜擇偶條件大公開！郭珮文要求月入10萬？何沛珈晒纖腰自", "綜藝", "/static/images/banner9.jpg", "https://www.tvb.com/varietynews-c/%E5%A5%B3%E7%A5%9E%E9%85%8D%E5%B0%8D%E8%A8%88%E5%8A%832-%E6%93%87%E5%81%B6%E6%A2%9D%E4%BB%B6%E5%A4%A7%E5%85%AC%E9%96%8B-%E9%83%AD%E7%8F%AE%E6%96%87%E8%A6%81%E6%B1%82%E6%9C%88%E5%85%A510%E8%90%AC-%E4%BD%95%E6%B2%9B%E7%8F%88%E6%99%92%E7%BA%96%E8%85%B0%E8%87%AA%E7%88%86%E6%84%9B%E6%BA%AB%E6%9F%94%E7%94%B7-1013031"),
        ("大埔私樓破壞王離譜玩火燒觀音像 貓仔黎寬怡埋身追訪 否認指控：你哋搵我嚟做新聞！", "熱話", "/static/images/banner10.jpg", "https://www.tvb.com/hottopic-c/%E5%A4%A7%E5%9F%94%E7%A7%81%E6%A8%93%E7%A0%B4%E5%A3%9E%E7%8E%8B%E9%9B%A2%E8%AD%9C%E7%8E%A9%E7%81%AB%E7%87%92%E8%A7%80%E9%9F%B3%E5%83%8F-%E8%B2%93%E4%BB%94%E9%BB%8E%E5%AF%AC%E6%80%A1%E5%9F%8B%E8%BA%AB%E8%BF%BD%E8%A8%AA-%E5%90%A6%E8%AA%8D%E6%8C%87%E6%8E%A7-%E4%BD%A0%E5%93%8B%E6%90%B5%E6%88%91%E5%9A%9F%E5%81%9A%E6%96%B0%E8%81%9E--1013053"),
        ("羅湖站阿伯向路軌小便 車門關上險被夾腳 超缺德違法行為惹全網聲討", "熱話", "/static/images/banner11.jpg", "https://www.tvb.com/hottopic-c/%E5%A4%A7%E5%9F%94%E7%A7%81%E6%A8%93%E7%A0%B4%E5%A3%9E%E7%8E%8B%E9%9B%A2%E8%AD%9C%E7%8E%A9%E7%81%AB%E7%87%92%E8%A7%80%E9%9F%B3%E5%83%8F-%E8%B2%93%E4%BB%94%E9%BB%8E%E5%AF%AC%E6%80%A1%E5%9F%8B%E8%BA%AB%E8%BF%BD%E8%A8%AA-%E5%90%A6%E8%AA%8D%E6%8C%87%E6%8E%A7-%E4%BD%A0%E5%93%8B%E6%90%B5%E6%88%91%E5%9A%9F%E5%81%9A%E6%96%B0%E8%81%9E--1013053")
    ]

    return render_template('index.html', videos=test_videos)

@app.route('/news')
def news():
    artist_news = [
        ("黎姿激罕晒水着Chill歎陽光與海灘 網民震驚美貌零跌Watt", "藝人動態", "4小時前", "/static/images/artist1.jpg", "https://www.tvb.com/artiste-news-c/%E9%BB%8E%E5%A7%BF%E6%BF%80%E7%BD%95%E6%99%92%E6%B0%B4%E7%9D%80Chill%E6%AD%8E%E9%99%BD%E5%85%89%E8%88%87%E6%B5%B7%E7%81%98-%E7%B6%B2%E6%B0%91%E9%9C%87%E9%A9%9A%E7%BE%8E%E8%B2%8C%E9%9B%B6%E8%B7%8CWatt-1013074"),
        ("周嘉洛健身室狂操 同行蔣祖曼戴祖儀chill住打卡笑爆嘴", "藝人動態", "6小時前", "/static/images/artist2.jpg", "https://www.tvb.com/artiste-news-c/%E5%91%A8%E5%98%89%E6%B4%9B%E5%81%A5%E8%BA%AB%E5%AE%A4%E7%8B%82%E6%93%8D-%E5%90%8C%E8%A1%8C%E8%94%A3%E7%A5%96%E6%9B%BC%E6%88%B4%E7%A5%96%E5%84%80chill%E4%BD%8F%E6%89%93%E5%8D%A1%E7%AC%91%E7%88%86%E5%98%B4-1013061"),
        ("張寶兒因堵奶患乳腺炎兼發燒 揭母乳餵養背後挑戰：從來胸裡面都有一塊二塊鈣化", "藝人動態", "11小時前", "/static/images/artist3.jpg", "https://www.tvb.com/artiste-news-c/%E5%BC%B5%E5%AF%B6%E5%85%92%E5%9B%A0%E5%A0%B5%E5%A5%B6%E6%82%A3%E4%B9%B3%E8%85%BA%E7%82%8E%E5%85%BC%E7%99%BC%E7%87%92-%E6%8F%AD%E6%AF%8D%E4%B9%B3%E9%A4%B5%E9%A4%8A%E8%83%8C%E5%BE%8C%E6%8C%91%E6%88%B0-%E5%BE%9E%E4%BE%86%E8%83%B8%E8%A3%A1%E9%9D%A2%E9%83%BD%E6%9C%89%E4%B8%80%E5%A1%8A%E4%BA%8C%E5%A1%8A%E9%88%A3%E5%8C%96-1013052"),
        ("《新紮師兄》潘宏彬離世 終年63歲 與劉德華訓練班同期", "藝人動態", "13小時前", "/static/images/artist4.jpg", "https://www.tvb.com/artiste-news-c/-%E6%96%B0%E7%B4%AE%E5%B8%AB%E5%85%84-%E6%BD%98%E5%AE%8F%E5%BD%AC%E9%9B%A2%E4%B8%96-%E7%B5%82%E5%B9%B463%E6%AD%B2-%E8%88%87%E5%8A%89%E5%BE%B7%E8%8F%AF%E8%A8%93%E7%B7%B4%E7%8F%AD%E5%90%8C%E6%9C%9F-1013051"),
        ("吳文忻化療脫髮自嘲變「癩痢」 轉男仔頭新髮型獲網民打氣：型過以前！", "藝人動態", "16小時前", "/static/images/artist5.jpg", "https://www.tvb.com/artiste-news-c/%E5%90%B3%E6%96%87%E5%BF%BB%E5%8C%96%E7%99%82%E8%84%AB%E9%AB%AE%E8%87%AA%E5%98%B2%E8%AE%8A-%E7%99%A9%E7%97%A2--%E8%BD%89%E7%94%B7%E4%BB%94%E9%A0%AD%E6%96%B0%E9%AB%AE%E5%9E%8B%E7%8D%B2%E7%B6%B2%E6%B0%91%E6%89%93%E6%B0%A3-%E5%9E%8B%E9%81%8E%E4%BB%A5%E5%89%8D--1013047"),
        ("陳展鵬單文柔新居大公開！ 搬複式豪宅空間感十足 高EQ回應愈住愈「豪」", "藝人動態", "2026-04-16", "/static/images/artist6.jpg", "https://www.tvb.com/artiste-news-c/%E9%99%B3%E5%B1%95%E9%B5%AC%E5%96%AE%E6%96%87%E6%9F%94%E6%96%B0%E5%B1%85%E5%A4%A7%E5%85%AC%E9%96%8B--%E6%90%AC%E8%A4%87%E5%BC%8F%E8%B1%AA%E5%AE%85%E7%A9%BA%E9%96%93%E6%84%9F%E5%8D%81%E8%B6%B3-%E9%AB%98EQ%E5%9B%9E%E6%87%89%E6%84%88%E4%BD%8F%E6%84%88-%E8%B1%AA--1013040"),
    ]
    artist_news_data = [
        ("正義女神｜許紹雄挺身力撐佘詩曼 現實父女情同樣暖心爆燈", "劇集", "2小時前", "/static/images/drama1.jpg", "https://www.tvb.com/dramanews-c/%E6%AD%A3%E7%BE%A9%E5%A5%B3%E7%A5%9E-%E8%A8%B1%E7%B4%B9%E9%9B%84%E6%8C%BA%E8%BA%AB%E5%8A%9B%E6%92%90%E4%BD%98%E8%A9%A9%E6%9B%BC--%E7%8F%BE%E5%AF%A6%E7%88%B6%E5%A5%B3%E6%83%85%E5%90%8C%E6%A8%A3%E6%9A%96%E5%BF%83%E7%88%86%E7%87%88-1013075"),
        ("正義女神｜朱樂洺4分鐘Solo爆Seed痛哭 睇到網民：好驚佢喊到缺氧", "劇集", "2小時前", "/static/images/drama2.jpg", "https://www.tvb.com/dramanews-c/%E6%AD%A3%E7%BE%A9%E5%A5%B3%E7%A5%9E-%E6%9C%B1%E6%A8%82%E6%B4%BA4%E5%88%86%E9%90%98Solo%E7%88%86Seed%E7%97%9B%E5%93%AD-%E6%B6%95%E6%B7%9A%E7%B8%B1%E6%A9%AB%E8%B0%B7%E5%88%B0%E9%9D%A2%E7%B4%85%E8%B6%85%E5%85%A5%E6%88%B2-%E7%B6%B2%E6%B0%91-%E5%A5%BD%E9%A9%9A%E4%BD%A2%E5%96%8A%E5%88%B0%E7%BC%BA%E6%B0%A7--1013080"),
        ("正義女神｜陳少邦再演反派 怒啤佘詩曼哀格樣藝人憎", "劇集", "3小時前", "/static/images/drama3.jpg", "https://www.tvb.com/dramanews-c/%E6%AD%A3%E7%BE%A9%E5%A5%B3%E7%A5%9E-%E9%99%B3%E5%B0%91%E9%82%A6%E5%86%8D%E6%BC%94%E5%8F%8D%E6%B4%BE--%E6%80%92%E7%9D%A5%E4%BD%98%E8%A9%A9%E6%9B%BC%E8%A1%B0%E6%A0%BC%E6%A8%A3%E4%B9%9E%E4%BA%BA%E6%86%8E-%E7%A7%81%E4%B8%8B%E6%9A%96%E7%88%B8%E5%BD%A2%E8%B1%A1%E5%8F%8D%E5%B7%AE%E5%A4%A7-1013062"),
        ("愛回家之開心速遞第2788集｜正義的士司機樹仁哥 揭穿武館籌錢騙局", "劇集", "4小時前", "/static/images/drama4.jpg", "https://www.tvb.com/dramanews-c/%E6%84%9B%E5%9B%9E%E5%AE%B6%E4%B9%8B%E9%96%8B%E5%BF%83%E9%80%9F%E9%81%9E%E7%AC%AC2788%E9%9B%86-%E6%AD%A3%E7%BE%A9%E7%9A%84%E5%A3%AB%E5%8F%B8%E6%A9%9F%E6%A8%B9%E4%BB%81%E5%93%A5-%E6%8F%AD%E7%A9%BF%E6%AD%A6%E9%A4%A8%E7%B1%8C%E9%8C%A2%E9%A8%99%E5%B1%80-1013060"),
        ("正義女神｜丘梓謙康華相隔20年再演母子 晒《人間蒸發》舊照", "劇集", "12小時前", "/static/images/drama5.jpg", "https://www.tvb.com/dramanews-c/%E6%AD%A3%E7%BE%A9%E5%A5%B3%E7%A5%9E-%E4%B8%98%E6%A2%93%E8%AC%99%E5%BA%B7%E8%8F%AF%E7%9B%B8%E9%9A%9420%E5%B9%B4%E5%86%8D%E6%BC%94%E6%AF%8D%E5%AD%90--%E6%99%92-%E4%BA%BA%E9%96%93%E8%92%B8%E7%99%BC-%E8%88%8A%E7%85%A7%E7%88%86%E7%9B%B8%E8%AA%8D%E7%B6%93%E9%81%8E-1013054"),
        ("正義女神演員名單持續更新｜劉倬昕施焯日演少年犯掀熱討", "劇集", "13小時前", "/static/images/drama6.jpg", "https://www.tvb.com/dramanews-c/%E6%AD%A3%E7%BE%A9%E5%A5%B3%E7%A5%9E%E6%BC%94%E5%93%A1%E5%90%8D%E5%96%AE%E6%8C%81%E7%BA%8C%E6%9B%B4%E6%96%B0-%E9%80%BE10%E4%BD%8D%E6%96%B0%E4%B8%96%E4%BB%A3%E6%BC%94%E5%93%A1%E8%83%8C%E6%99%AF%E5%A4%A7%E8%B5%B7%E5%BA%95-%E5%8A%89%E5%80%AC%E6%98%95%E6%96%BD%E7%84%AF%E6%97%A5%E6%BC%94%E5%B0%91%E5%B9%B4%E7%8A%AF%E6%8E%80%E7%86%B1%E8%A8%8E-1012874"),
    ]
    funny_data = [
        ("試真D｜周嘉洛Jumbo麒麟臂搶Fo 歎乳鴿喪谷超強胸肌逼爆小背心", "綜藝", "5小時前", "/static/images/funny1.jpg","https://www.tvb.com/varietynews-c/%E8%A9%A6%E7%9C%9FD-%E5%91%A8%E5%98%89%E6%B4%9BJumbo%E9%BA%92%E9%BA%9F%E8%87%82%E6%90%B6Fo-%E6%AD%8E%E4%B9%B3%E9%B4%BF%E5%96%AA%E8%B0%B7%E8%B6%85%E5%BC%B7%E8%83%B8%E8%82%8C%E9%80%BC%E7%88%86%E5%B0%8F%E8%83%8C%E5%BF%83-1013064"),
        ("中年好聲音4｜新評審揭曉！陳潔靈被封「殿堂級」4字幽默回應 呢位大俠現身有驚喜", "綜藝", "11小時前", "/static/images/funny2.jpg","https://www.tvb.com/varietynews-c/%E4%B8%AD%E5%B9%B4%E5%A5%BD%E8%81%B2%E9%9F%B34-%E6%96%B0%E8%A9%95%E5%AF%A9%E6%8F%AD%E6%9B%89-%E9%99%B3%E6%BD%94%E9%9D%88%E8%A2%AB%E5%B0%81-%E6%AE%BF%E5%A0%82%E7%B4%9A-4%E5%AD%97%E5%B9%BD%E9%BB%98%E5%9B%9E%E6%87%89-%E5%91%A2%E4%BD%8D%E5%A4%A7%E4%BF%A0%E7%8F%BE%E8%BA%AB%E6%9C%89%E9%A9%9A%E5%96%9C-1013058"),
        ("女神配對計劃2｜俞可程Dry到爆被催拍拖 壓力爆煲擔心冇人吼 ：會唔會冇人追我？", "綜藝", "14小時前", "/static/images/funny3.jpg","https://www.tvb.com/varietynews-c/%E5%A5%B3%E7%A5%9E%E9%85%8D%E5%B0%8D%E8%A8%88%E5%8A%832-%E4%BF%9E%E5%8F%AF%E7%A8%8BDry%E5%88%B0%E7%88%86%E8%A2%AB%E5%82%AC%E6%8B%8D%E6%8B%96-%E5%A3%93%E5%8A%9B%E7%88%86%E7%85%B2%E6%93%94%E5%BF%83%E5%86%87%E4%BA%BA%E5%90%BC--%E6%9C%83%E5%94%94%E6%9C%83%E5%86%87%E4%BA%BA%E8%BF%BD%E6%88%91--1013041"),
        ("女神配對計劃2｜郭珮文最驚講錯嘢惹惡評 陳若思選擇困難盼有叻人依賴", "綜藝", "3小時前", "/static/images/funny4.jpg","https://www.tvb.com/varietynews-c/%E5%A5%B3%E7%A5%9E%E9%85%8D%E5%B0%8D%E8%A8%88%E5%8A%832-%E9%83%AD%E7%8F%AE%E6%96%87%E6%9C%80%E9%A9%9A%E8%AC%9B%E9%8C%AF%E5%98%A2%E6%83%B9%E6%83%A1%E8%A9%95-%E9%99%B3%E8%8B%A5%E6%80%9D%E9%81%B8%E6%93%87%E5%9B%B0%E9%9B%A3%E7%9B%BC%E6%9C%89%E5%8F%BB%E4%BA%BA%E4%BE%9D%E8%B3%B4-1013038"),
        ("女神配對計劃2｜阮嘉敏感恩𢭃住人工識男仔 何沛珈放低舊愛盼覓Soulmate", "綜藝", "18小時前", "/static/images/funny5.jpg","https://www.tvb.com/varietynews-c/%E5%A5%B3%E7%A5%9E%E9%85%8D%E5%B0%8D%E8%A8%88%E5%8A%832-%E9%98%AE%E5%98%89%E6%95%8F%E6%84%9F%E6%81%A9%F0%A2%AD%83%E4%BD%8F%E4%BA%BA%E5%B7%A5%E8%AD%98%E7%94%B7%E4%BB%94-%E4%BD%95%E6%B2%9B%E7%8F%88%E6%94%BE%E4%BD%8E%E8%88%8A%E6%84%9B%E7%9B%BC%E8%A6%93Soulmate-1013036"),
        ("女神配對計劃2｜擇偶條件大公開！郭珮文要求月入10萬？何沛珈晒纖腰自爆愛溫柔男", "綜藝", "7小時前", "/static/images/funny6.jpg","https://www.tvb.com/varietynews-c/%E5%A5%B3%E7%A5%9E%E9%85%8D%E5%B0%8D%E8%A8%88%E5%8A%832-%E6%93%87%E5%81%B6%E6%A2%9D%E4%BB%B6%E5%A4%A7%E5%85%AC%E9%96%8B-%E9%83%AD%E7%8F%AE%E6%96%87%E8%A6%81%E6%B1%82%E6%9C%88%E5%85%A510%E8%90%AC-%E4%BD%95%E6%B2%9B%E7%8F%88%E6%99%92%E7%BA%96%E8%85%B0%E8%87%AA%E7%88%86%E6%84%9B%E6%BA%AB%E6%9F%94%E7%94%B7-1013031")
    ]
    hot_data = [
        ("大埔私樓破壞王離譜玩火燒觀音像 貓仔黎寬怡埋身追訪 否認指控：你哋搵我嚟做新聞！", "熱話", "6小時前", "/static/images/hot1.jpg","https://www.tvb.com/hottopic-c/%E5%A4%A7%E5%9F%94%E7%A7%81%E6%A8%93%E7%A0%B4%E5%A3%9E%E7%8E%8B%E9%9B%A2%E8%AD%9C%E7%8E%A9%E7%81%AB%E7%87%92%E8%A7%80%E9%9F%B3%E5%83%8F-%E8%B2%93%E4%BB%94%E9%BB%8E%E5%AF%AC%E6%80%A1%E5%9F%8B%E8%BA%AB%E8%BF%BD%E8%A8%AA-%E5%90%A6%E8%AA%8D%E6%8C%87%E6%8E%A7-%E4%BD%A0%E5%93%8B%E6%90%B5%E6%88%91%E5%9A%9F%E5%81%9A%E6%96%B0%E8%81%9E--1013053"),
        ("羅湖站阿伯向路軌小便 車門關上險被夾腳 超缺德違法行為惹全網聲討 港鐵回應：站內有洗手...", "熱話", "4小時前", "/static/images/hot2.jpg","https://www.tvb.com/hottopic-c/%E7%BE%85%E6%B9%96%E7%AB%99%E9%98%BF%E4%BC%AF%E5%90%91%E8%B7%AF%E8%BB%8C%E5%B0%8F%E4%BE%BF-%E8%BB%8A%E9%96%80%E9%97%9C%E4%B8%8A%E9%9A%AA%E8%A2%AB%E5%A4%BE%E8%85%B3-%E8%B6%85%E7%BC%BA%E5%BE%B7%E9%81%95%E6%B3%95%E8%A1%8C%E7%82%BA%E6%83%B9%E5%85%A8%E7%B6%B2%E8%81%B2%E8%A8%8E-%E6%B8%AF%E9%90%B5%E5%9B%9E%E6%87%89-%E7%AB%99%E5%85%A7%E6%9C%89%E6%B4%97%E6%89%8B%E9%96%93-1013059"),
        ("港人憂90歲嫲嫲身故後被收樓 擬買入太和邨單人公屋予家人 網民列2原因勸退 猜測約20-30...", "熱話", "2小時前", "/static/images/hot3.jpg","https://www.tvb.com/hottopic-c/%E6%B8%AF%E4%BA%BA%E6%86%8290%E6%AD%B2%E5%AB%B2%E5%AB%B2%E8%BA%AB%E6%95%85%E5%BE%8C%E8%A2%AB%E6%94%B6%E6%A8%93--%E6%93%AC%E8%B2%B7%E5%85%A5%E5%A4%AA%E5%92%8C%E9%82%A8%E5%96%AE%E4%BA%BA%E5%85%AC%E5%B1%8B%E4%BA%88%E5%AE%B6%E4%BA%BA--%E7%B6%B2%E6%B0%91%E5%88%972%E5%8E%9F%E5%9B%A0%E5%8B%B8%E9%80%80-%E7%8C%9C%E6%B8%AC%E7%B4%8420-30%E8%90%AC-1013056"),
        ("「賽螃蟹應否加蟹肉」引熱討 網民力撐唔加：有蟹肉仲賽乜 賽字原來係咁解！", "熱話", "13小時前", "/static/images/hot4.jpg","https://www.tvb.com/hottopic-c/-%E8%B3%BD%E8%9E%83%E8%9F%B9%E6%87%89%E5%90%A6%E5%8A%A0%E8%9F%B9%E8%82%89-%E5%BC%95%E7%86%B1%E8%A8%8E-%E7%B6%B2%E6%B0%91%E5%8A%9B%E6%92%90%E5%94%94%E5%8A%A0-%E6%9C%89%E8%9F%B9%E8%82%89%E4%BB%B2%E8%B3%BD%E4%B9%9C-%E8%B3%BD%E5%AD%97%E5%8E%9F%E4%BE%86%E4%BF%82%E5%92%81%E8%A7%A3--1013017"),
        ("富昌邨現口罩奇人 每日亂翻垃圾桶倒滿地 煙灰垃圾隨處飛 街坊控訴：日日都係咁！", "熱話", "9小時前", "/static/images/hot5.jpg","https://www.tvb.com/hottopic-c/%E5%AF%8C%E6%98%8C%E9%82%A8%E7%8F%BE%E5%8F%A3%E7%BD%A9%E5%A5%87%E4%BA%BA-%E6%AF%8F%E6%97%A5%E4%BA%82%E7%BF%BB%E5%9E%83%E5%9C%BE%E6%A1%B6%E5%80%92%E6%BB%BF%E5%9C%B0--%E7%85%99%E7%81%B0%E5%9E%83%E5%9C%BE%E9%9A%A8%E8%99%95%E9%A3%9B-%E8%A1%97%E5%9D%8A%E6%8E%A7%E8%A8%B4-%E6%97%A5%E6%97%A5%E9%83%BD%E4%BF%82%E5%92%81--1013039"),
        ("大埔私樓破壞男玩殘街坊 大堂小便倒垃圾黐𨋢門犯眾憎 有立案法團前主席爸爸撐腰？", "熱話", "8小時前", "/static/images/hot6.jpg","https://www.tvb.com/hottopic-c/%E5%A4%A7%E5%9F%94%E7%A7%81%E6%A8%93%E7%A0%B4%E5%A3%9E%E7%94%B7%E7%8E%A9%E6%AE%98%E8%A1%97%E5%9D%8A-%E5%A4%A7%E5%A0%82%E5%B0%8F%E4%BE%BF%E5%80%92%E5%9E%83%E5%9C%BE%E9%BB%90%F0%A8%8B%A2%E9%96%80%E7%8A%AF%E7%9C%BE%E6%86%8E-%E6%9C%89%E7%AB%8B%E6%A1%88%E6%B3%95%E5%9C%98%E5%89%8D%E4%B8%BB%E5%B8%AD%E7%88%B8%E7%88%B8%E6%92%90%E8%85%B0--1013027")
    ]
    return render_template('news.html', artist_news=artist_news, artist_news_data=artist_news_data, funny_data=funny_data, hot_data=hot_data)

@app.route('/admin/logs')
def admin_logs():
    if not session.get('logged_in') or not session.get('is_admin'):
        flash("您沒有權限訪問此管理頁面！", "danger")
        return redirect(url_for('index'))

    page = request.args.get('page', 1, type=int)
    per_page = 20

    pagination = AccessLog.query.order_by(AccessLog.login_time.desc()).paginate(page=page, per_page=per_page, error_out=False)
    
    logs = pagination.items

    return render_template('admin_logs.html', logs=logs, pagination=pagination)

@app.route('/admin/news', methods=['GET', 'POST'])
def admin_news():
    if request.method == 'POST':
        title = request.form.get('title')
        content = request.form.get('content')
        image_url = request.form.get('image_url')
        link_url=request.form.get('link_url')
        news_list = NewsArticle.query.order_by(NewsArticle.display_order.desc(), NewsArticle.article_id.desc()).all()
        new_article = NewsArticle(title=title, content=content, image_url=image_url, link_url=link_url)
        
        db.session.add(new_article)
        db.session.commit()
        return redirect(url_for('admin_news'))

    articles = NewsArticle.query.order_by(NewsArticle.published_at.desc()).all()
    return render_template('admin_news.html', articles=articles)

@app.route('/admin/news/update_order/<int:article_id>', methods=['POST'])
def update_news_order(article_id):
    news = NewsArticle.query.get_or_404(article_id)
    new_order = request.form.get('display_order', type=int)
    
    if new_order is not None:
        news.display_order = new_order
        db.session.commit()
        
    return redirect(url_for('admin_news'))

@app.route('/admin/news/delete/<int:id>')
def delete_news(id):
    article = NewsArticle.query.get_or_404(id)
    db.session.delete(article)
    db.session.commit()
    return redirect(url_for('admin_news'))

@app.route('/admin/news/edit/<int:id>', methods=['GET', 'POST'])
def edit_news(id):
    article = NewsArticle.query.get_or_404(id)
    
    if request.method == 'POST':
        article.title = request.form.get('title')
        article.content = request.form.get('content')
        article.image_url = request.form.get('image_url')
        article.link_url = request.form.get('link_url')
        db.session.commit()
        return redirect(url_for('admin_news'))
        
    return render_template('admin_news_edit.html', article=article)

@app.route('/api/register', methods=['POST'])
def api_register():
    email = request.form.get('email')
    phone = request.form.get('phone')
    raw_password = request.form.get('password')

    existing_user = User.query.filter_by(email=email).first()
    if existing_user:
        flash("這組電郵已經註冊過囉，請直接登入！", "warning")
        return redirect(url_for('index', show_login=1))

    hashed_password = generate_password_hash(raw_password)
    new_user = User(
        email=email,
        username=email.split('@')[0],
        phone=phone,
        password=hashed_password
    )

    try:
        db.session.add(new_user)
        db.session.commit()

        try:
            msg = Message("【TVB 愛心基金】會員註冊成功！", recipients=[email])
            msg.body = f"親愛的 {new_user.username} 您好：\n\n感謝您註冊 TVB 愛心基金！您的會員帳號已成功開通。\n\n請隨時回來關注我們的最新公益活動，一起傳遞愛心。\n\nTVB 愛心基金團隊 敬上"
            mail.send(msg)
            email_status = "歡迎信已寄至您的信箱！"
        except Exception as mail_error:
            email_status = "(提醒：歡迎信發送失敗，但您的帳號已可使用)"
            print(f"發信錯誤: {mail_error}")

        flash(f"註冊成功！{email_status} 請嘗試登入。", "success")
        return redirect(url_for('index', show_login=1))

    except Exception as e:
        db.session.rollback()
        flash(f"系統發生錯誤，註冊失敗：{str(e)}", "danger")
        return redirect(url_for('index'))

@app.route('/api/login', methods=['POST'])
def api_login():
    email = request.form.get('email')
    password = request.form.get('password')
    
    user = User.query.filter_by(email=email).first()

    if user and check_password_hash(user.password, password):
    
        session['user_id'] = user.user_id  
        session['is_admin'] = user.is_admin 
        session['logged_in'] = True
        return redirect(request.referrer or url_for('index'))
    else:
        return "電郵或密碼錯誤！", 401

@app.route('/api/forgot_password', methods=['POST'])
def api_forgot_password():
    email = request.form.get('email')
    user = User.query.filter_by(email=email).first()
    
    if user:
        try:
            
            flash(f"重設密碼的連結已發送至 {email}，請查收！", "success")
            
            return redirect(url_for('index', show_login=1))
            
        except Exception as e:
            flash(f"發送失敗：{str(e)}", "error")
            return redirect(url_for('index', show_login=1))
            
    else:
        flash("找不到此電郵，請確認是否輸入正確。", "error")
        return redirect(url_for('index', show_login=1))

@app.route('/api/logout')
def api_logout():
    session.pop('user_id', None)
    session.pop('is_admin', None)
    session.pop('logged_in', None)
    flash("您已成功登出！", "success")
    return redirect(url_for('index'))

@app.route('/api/update_profile', methods=['POST'])
def api_update_profile():
    if not session.get('logged_in'):
        flash("請先登入！", "warning")
        return redirect(url_for('index', show_login=1))

    user_id = session.get('user_id')
    user = User.query.get(user_id)

    if user:
        new_username = request.form.get('username')
        new_phone = request.form.get('phone')
        
        user.username = new_username
        user.phone = new_phone
        
        try:
            db.session.commit()
            flash("資料更新成功！", "success")
        except Exception as e:
            db.session.rollback()
            flash(f"資料更新失敗：{str(e)}", "danger")
            
    return redirect(request.referrer or url_for('index'))

@app.route('/api/change_password', methods=['POST'])
def api_change_password():
    if not session.get('logged_in'):
        flash("請先登入！", "warning")
        return redirect(url_for('index', show_login=1))

    user_id = session.get('user_id')
    user = User.query.get(user_id)

    if user:
        old_password = request.form.get('old_password')
        new_password = request.form.get('new_password')
        confirm_password = request.form.get('confirm_password')

        if new_password != confirm_password:
            flash("新密碼與確認密碼不一致！", "danger")
            return redirect(request.referrer or url_for('index'))

        if not check_password_hash(user.password, old_password):
            flash("舊密碼錯誤！", "danger")
            return redirect(request.referrer or url_for('index'))

        user.password = generate_password_hash(new_password)
        
        try:
            db.session.commit()
            flash("密碼更改成功！請妥善保管新密碼。", "success")
        except Exception as e:
            db.session.rollback()
            flash(f"密碼更改失敗：{str(e)}", "danger")

    return redirect(request.referrer or url_for('index'))

@app.route('/charity')
def charity():
    banners = Banner.query.order_by(Banner.display_order.desc(), Banner.banner_id.desc()).limit(3).all()
    news_list = NewsArticle.query.order_by(NewsArticle.display_order.desc(), NewsArticle.article_id.desc()).limit(8).all()
    
  
    data_items = DataCenterItem.query.order_by(DataCenterItem.display_order.desc(), DataCenterItem.item_id.desc()).limit(4).all()
    

    return render_template('charity.html', banners=banners, news_list=news_list, data_items=data_items)

@app.route('/admin/categories', methods=['GET', 'POST'])
def admin_categories():
    if request.method == 'POST':
        name = request.form.get('name')
        slug = request.form.get('slug') # 網址縮寫，例如 'events'
        description = request.form.get('description')
        
        new_category = Category(name=name, slug=slug, description=description)
        db.session.add(new_category)
        db.session.commit()
        return redirect(url_for('admin_categories'))

    categories = Category.query.all()
    return render_template('admin_categories.html', categories=categories)

@app.route('/admin/categories/edit/<int:id>', methods=['GET', 'POST'])
def edit_category(id):
    category = Category.query.get_or_404(id)
    if request.method == 'POST':
        category.name = request.form.get('name')
        category.slug = request.form.get('slug')
        category.description = request.form.get('description')
        db.session.commit()
        return redirect(url_for('admin_categories'))
    
    return render_template('admin_categories_edit.html', category=category)

@app.route('/admin/categories/delete/<int:id>')
def delete_category(id):
    category = Category.query.get_or_404(id)
    db.session.delete(category)
    db.session.commit()
    return redirect(url_for('admin_categories'))

@app.route('/admin/videos', methods=['GET', 'POST'])
def admin_videos():
    if request.method == 'POST':
        new_video = Video(
            title=request.form.get('title'),
            cover_url=request.form.get('cover_url'),
            video_url=request.form.get('video_url'),
            description=request.form.get('description'),
            duration=request.form.get('duration'),
            category_id=request.form.get('category_id')
        )
        db.session.add(new_video)
        db.session.commit()
        return redirect(url_for('admin_videos'))

    videos = Video.query.all()
    categories = Category.query.all()
    return render_template('admin_videos.html', videos=videos, categories=categories)

@app.route('/admin/videos/edit/<int:id>', methods=['GET', 'POST'])
def edit_video(id):
    video = Video.query.get_or_404(id)
    if request.method == 'POST':
        video.title = request.form.get('title')
        video.cover_url = request.form.get('cover_url')
        video.video_url = request.form.get('video_url')
        video.description = request.form.get('description')
        video.duration = request.form.get('duration')
        video.category_id = request.form.get('category_id')
        db.session.commit()
        return redirect(url_for('admin_videos'))
    
    categories = Category.query.all()
    return render_template('admin_videos_edit.html', video=video, categories=categories)

@app.route('/admin/videos/delete/<int:id>')
def delete_video(id):
    video = Video.query.get_or_404(id)
    db.session.delete(video)
    db.session.commit()
    return redirect(url_for('admin_videos'))

@app.route('/admin/banners', methods=['GET', 'POST'])
def admin_banners():
    if request.method == 'POST':
        new_banner = Banner(
            title=request.form.get('title'),
            image_url=request.form.get('image_url'),
            link_url=request.form.get('link_url'),
            display_order=request.form.get('display_order', 0),
            is_active=1 if request.form.get('is_active') else 0
        )
        db.session.add(new_banner)
        db.session.commit()
        return redirect(url_for('admin_banners'))

    banners = Banner.query.order_by(Banner.display_order.desc()).all()
    return render_template('admin_banners.html', banners=banners)

@app.route('/admin/banners/update_order/<int:banner_id>', methods=['POST'])
def update_banner_order(banner_id):
    banner = Banner.query.get_or_404(banner_id)
    
    new_order = request.form.get('display_order', type=int)
    
    if new_order is not None:
        banner.display_order = new_order
        db.session.commit()
        
    return redirect(url_for('admin_banners'))

@app.route('/admin/banners/delete/<int:id>')
def delete_banner(id):
    banner = Banner.query.get_or_404(id)
    db.session.delete(banner)
    db.session.commit()
    return redirect(url_for('admin_banners'))

@app.route('/admin/banners/edit/<int:banner_id>', methods=['GET', 'POST'])
def edit_banner(banner_id):
    banner = Banner.query.get_or_404(banner_id)
    if request.method == 'POST':
        banner.title = request.form.get('title')
        banner.image_url = request.form.get('image_url')
        banner.link_url = request.form.get('link_url')
        banner.display_order = request.form.get('display_order', type=int)
        db.session.commit()
        return redirect(url_for('admin_banners'))
    return render_template('edit_banner.html', banner=banner)

@app.route('/admin/datacenter', methods=['GET', 'POST'])
def admin_datacenter():
    if request.method == 'POST':
        new_item = DataCenterItem(
            title=request.form.get('title'),
            image_url=request.form.get('image_url'),
            link_url=request.form.get('link_url')
        )
        db.session.add(new_item)
        db.session.commit()
        return redirect(url_for('admin_datacenter'))

    items = DataCenterItem.query.order_by(DataCenterItem.display_order.desc(), DataCenterItem.item_id.desc()).all()
    return render_template('admin_datacenter.html', items=items)

@app.route('/admin/datacenter/delete/<int:item_id>')
def delete_datacenter(item_id):
    item = DataCenterItem.query.get_or_404(item_id)
    db.session.delete(item)
    db.session.commit()
    return redirect(url_for('admin_datacenter'))

@app.route('/admin/datacenter/edit/<int:item_id>', methods=['GET', 'POST'])
def edit_datacenter(item_id):
    item = DataCenterItem.query.get_or_404(item_id)
    if request.method == 'POST':
        item.title = request.form.get('title')
        item.image_url = request.form.get('image_url')
        item.link_url = request.form.get('link_url')
        item.display_order = request.form.get('display_order', type=int)
        db.session.commit()
        return redirect(url_for('admin_datacenter'))
    return render_template('edit_datacenter.html', item=item)

@app.route('/admin/datacenter/update_order/<int:item_id>', methods=['POST'])
def update_datacenter_order(item_id):
    item = DataCenterItem.query.get_or_404(item_id)
    new_order = request.form.get('display_order', type=int)
    if new_order is not None:
        item.display_order = new_order
        db.session.commit()
    return redirect(url_for('admin_datacenter'))

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True, port=5000)