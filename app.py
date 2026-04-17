from flask import Flask, render_template
import os

app = Flask(__name__)

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

if __name__ == '__main__':
    app.run(debug=True, port=5000)