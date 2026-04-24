from flask_sqlalchemy import SQLAlchemy
from datetime import datetime

db = SQLAlchemy()

video_tags = db.Table('video_tags',
    db.Column('video_id', db.Integer, db.ForeignKey('videos.video_id'), primary_key=True),
    db.Column('tag_id', db.Integer, db.ForeignKey('tags.tag_id'), primary_key=True)
)

class User(db.Model):
    __tablename__ = 'users'
    user_id = db.Column(db.Integer, primary_key=True)
    email = db.Column(db.String(120), unique=True, nullable=False)
    phone = db.Column(db.String(20))
    password = db.Column(db.String(255), nullable=False)
    is_admin = db.Column(db.Boolean, default=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    updated_at = db.Column(db.DateTime, default=datetime.utcnow, onupdate=datetime.utcnow)

    profile = db.relationship('UserProfile', backref='user', uselist=False, cascade="all, delete-orphan")
    access_logs = db.relationship('AccessLog', backref='user', lazy=True)
    comments = db.relationship('Comment', backref='author', lazy=True)

class UserProfile(db.Model):
    __tablename__ = 'user_profiles'
    profile_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False) # Foreign Key
    nickname = db.Column(db.String(50))
    avatar_url = db.Column(db.String(255))
    gender = db.Column(db.String(10))
    bio = db.Column(db.Text)

class AccessLog(db.Model):
    __tablename__ = 'access_logs'
    log_id = db.Column(db.Integer, primary_key=True)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False) # Foreign Key
    login_time = db.Column(db.DateTime, default=datetime.utcnow)
    ip_address = db.Column(db.String(45))
    user_agent = db.Column(db.String(255))


class Category(db.Model):
    __tablename__ = 'categories'
    category_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    slug = db.Column(db.String(100), unique=True)
    description = db.Column(db.Text)

    videos = db.relationship('Video', backref='category', lazy=True)

class Video(db.Model):
    __tablename__ = 'videos'
    video_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    cover_url = db.Column(db.String(255))
    description = db.Column(db.Text)
    video_url = db.Column(db.String(255))
    duration = db.Column(db.Integer) # 以秒為單位
    release_date = db.Column(db.Date)
    category_id = db.Column(db.Integer, db.ForeignKey('categories.category_id')) # Foreign Key
    views = db.Column(db.Integer, default=0)

    comments = db.relationship('Comment', backref='video', lazy=True, cascade="all, delete-orphan")
    tags = db.relationship('Tag', secondary=video_tags, backref=db.backref('videos', lazy='dynamic'))

class Tag(db.Model):
    __tablename__ = 'tags'
    tag_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), unique=True, nullable=False)


class NewsArticle(db.Model):
    __tablename__ = 'news_articles'
    article_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    content = db.Column(db.Text, nullable=False)
    author = db.Column(db.String(100))
    published_at = db.Column(db.DateTime, default=datetime.utcnow)
    image_url = db.Column(db.String(255))
    view_count = db.Column(db.Integer, default=0)
    link_url = db.Column(db.Text)
    display_order = db.Column(db.Integer, default=0)

class Banner(db.Model):
    __tablename__ = 'banners'
    banner_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(100))
    image_url = db.Column(db.String(255), nullable=False)
    link_url = db.Column(db.String(255))
    display_order = db.Column(db.Integer, default=0)
    is_active = db.Column(db.Boolean, default=True)
    start_date = db.Column(db.DateTime, default=db.func.now())
    end_date = db.Column(db.DateTime, nullable=True)

class Comment(db.Model):
    __tablename__ = 'comments'
    comment_id = db.Column(db.Integer, primary_key=True)
    content = db.Column(db.Text, nullable=False)
    created_at = db.Column(db.DateTime, default=datetime.utcnow)
    user_id = db.Column(db.Integer, db.ForeignKey('users.user_id'), nullable=False) # Foreign Key
    video_id = db.Column(db.Integer, db.ForeignKey('videos.video_id'), nullable=False) # Foreign Key
    
    
    parent_id = db.Column(db.Integer, db.ForeignKey('comments.comment_id'), nullable=True) 
    replies = db.relationship('Comment', backref=db.backref('parent', remote_side=[comment_id]))
    
    is_deleted = db.Column(db.Boolean, default=False)

class DataCenterItem(db.Model):
    __tablename__ = 'data_center_items'
    item_id = db.Column(db.Integer, primary_key=True)
    title = db.Column(db.String(255), nullable=False)
    image_url = db.Column(db.String(255))
    link_url = db.Column(db.Text)
    display_order = db.Column(db.Integer, default=0)
    published_at = db.Column(db.DateTime, default=db.func.now())