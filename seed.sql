
CREATE DATABASE IF NOT EXISTS tvb_charity_db;
USE tvb_charity_db;


CREATE TABLE IF NOT EXISTS categories (
    category_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100),
    slug VARCHAR(100) UNIQUE,
    description TEXT
);

CREATE TABLE IF NOT EXISTS tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100)
);

CREATE TABLE IF NOT EXISTS videos (
    video_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    cover_url VARCHAR(255),
    video_url VARCHAR(255),
    description TEXT,
    category_id INT,
    views INT DEFAULT 0,
    release_date DATE
);

CREATE TABLE IF NOT EXISTS video_tags (
    video_id INT,
    tag_id INT,
    PRIMARY KEY (video_id, tag_id)
);

CREATE TABLE IF NOT EXISTS news_articles (
    article_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    content TEXT,
    image_url VARCHAR(255),
    view_count INT DEFAULT 0
);

CREATE TABLE IF NOT EXISTS banners (
    banner_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    image_url VARCHAR(255),
    link_url VARCHAR(255),
    display_order INT
);


INSERT IGNORE INTO categories (name, slug, description) VALUES 
('愛心行動', 'charity-action', 'TVB 職藝員愛心基金的最新動態與慈善活動'),
('個案援助', 'case-support', '社會各界弱勢群體的個案援助與募款進度'),
('專題報導', 'feature-report', '深入探討社會議題與公益專題');

INSERT IGNORE INTO tags (name) VALUES ('大埔宏福苑'), ('送暖行動'), ('緊急援助'), ('青少年');

INSERT IGNORE INTO videos (title, cover_url, video_url, description, category_id, views, release_date) VALUES 
('「愛心送暖」2026 啟動禮', 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c?w=500', 'https://www.youtube.com/embed/dQw4w9WgXcQ', '匯聚全台愛心，正式啟動年度送暖計畫...', 1, 1250, '2026-03-12'),
('大埔宏福苑援助進展', 'https://images.pexels.com/photos/6646917/pexels-photo-6646917.jpeg?w=500', 'https://www.youtube.com/embed/3AtDnEC4zak', '感謝各界捐款，目前款項已送達受影響住戶...', 2, 890, '2025-11-28'),
('青少年警訊籃球友誼賽', 'https://images.unsplash.com/photo-1546519638-68e109498ffc?w=500', 'https://www.youtube.com/embed/dQw4w9WgXcQ', '體育推廣與慈善結合，展現活力與愛心...', 1, 2100, '2025-03-05');

INSERT IGNORE INTO video_tags (video_id, tag_id) VALUES (1, 2), (2, 1), (2, 3);

INSERT IGNORE INTO news_articles (title, content, image_url, view_count) VALUES 
('愛心基金撥款百萬援助災民', '無綫電視暨職藝員愛心基金今日宣佈緊急撥款...', 'https://www.tvb.com/1010380', 5600);

INSERT IGNORE INTO banners (title, image_url, link_url, display_order) VALUES 
('愛心送暖 2026', 'https://images.unsplash.com/photo-1488521787991-ed7bbaae773c', 'https://www.tvb.com/1011722', 1);