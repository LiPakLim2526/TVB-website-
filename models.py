from app import db

# 分类表
class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), unique=True, nullable=False)
    videos = db.relationship('Video', backref='category', lazy=True, cascade="all, delete-orphan")

# 影片表（外键关联分类）
class Video(db.Model):
    __tablename__ = 'videos'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    cover_url = db.Column(db.String(500))  # 封面网址
    description = db.Column(db.Text)        # 简介
    category_id = db.Column(db.Integer, db.ForeignKey('categories.id'), nullable=False)

# 首页横幅表
class Banner(db.Model):
    __tablename__ = 'banners'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200))
    image_url = db.Column(db.String(500), nullable=False)
    link_url = db.Column(db.String(500))    # 跳转链接（可选）