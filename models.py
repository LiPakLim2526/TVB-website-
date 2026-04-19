from app import db


class Category(db.Model):
    __tablename__ = 'categories'
    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(50), unique=True, nullable=False)
    videos = db.relationship('Video', backref='category', lazy=True, cascade="all, delete-orphan")


class Video(db.Model):
    __tablename__ = 'videos'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200), nullable=False)
    cover_url = db.Column(db.String(500))  # 封面网址
    description = db.Column(db.Text)        # 简介
    category_id = db.Column(db.Integer, db.ForeignKey('categories.id'), nullable=False)


class Banner(db.Model):
    __tablename__ = 'banners'
    id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(200))
    image_url = db.Column(db.String(500), nullable=False)
    link_url = db.Column(db.String(500))    # 跳转链接（可选）