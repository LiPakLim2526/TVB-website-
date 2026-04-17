from flask import Flask, render_template
import os

app = Flask(__name__)

@app.route('/')
def index():
    test_videos = [
        ("愛回家之開心速遞", "劇集", "/static/images/banner1.jpg"),
        ("正義女神｜許紹雄再爆神級演繹 爆喊講「我愛你」感動全城 丘梓謙自爆對戲強忍淚水：好有感覺", "劇集", "/static/images/banner2.jpg"),
        ("陳展鵬單文柔新居大公開！ 搬複式豪宅空間感十足 高EQ回應愈住愈「豪」", "藝人動態", "/static/images/banner3.jpg"),
        ("美食新聞報道｜中環地道韓式家庭料理 居港韓國人力推足料拌飯/辣炒豬肉", "TVB Plue", "/static/images/banner4.jpg"),
        ("正義女神線上看劇情懶人包！全25集劇透（持續更新）佘詩曼首套律政", "劇集", "/static/images/banner6.jpg"),
        ("穀雨｜用「穀雨三養」保健身體 中醫教7招養生 按摩1穴位加強氣血", "綜藝", "/static/images/banner5.jpg"),
        ("生暗瘡｜中醫拆解生暗瘡2大成因 必學3穴位加快暗瘡凋謝/改善體質 推", "生活", "/static/images/banner8.jpg"),
        ("女神配對計劃2｜擇偶條件大公開！郭珮文要求月入10萬？何沛珈晒纖腰自", "綜藝", "/static/images/banner9.jpg"),
        ("大埔私樓破壞王離譜玩火燒觀音像 貓仔黎寬怡埋身追訪 否認指控：你哋搵我嚟做新聞！", "熱話", "/static/images/banner10.jpg"),
        ("羅湖站阿伯向路軌小便 車門關上險被夾腳 超缺德違法行為惹全網聲討", "熱話", "/static/images/banner11.jpg")
    ]
    
    return render_template('index.html', videos=test_videos)

if __name__ == '__main__':
    app.run(debug=True, port=5000)