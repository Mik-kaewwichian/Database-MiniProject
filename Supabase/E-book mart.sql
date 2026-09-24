-- ============================================================================
-- E-BOOK MART DATABASE SCHEMA
-- PostgreSQL / Supabase
-- ============================================================================

-- Drop existing tables (ถ้ามี)
DROP TABLE IF EXISTS download_links CASCADE;
DROP TABLE IF EXISTS payments CASCADE;
DROP TABLE IF EXISTS order_items CASCADE;
DROP TABLE IF EXISTS orders CASCADE;
DROP TABLE IF EXISTS cart_items CASCADE;
DROP TABLE IF EXISTS carts CASCADE;
DROP TABLE IF EXISTS reviews CASCADE;
DROP TABLE IF EXISTS wishlists CASCADE;
DROP TABLE IF EXISTS ebooks CASCADE;
DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS users CASCADE;
DROP TABLE IF EXISTS roles CASCADE;

-- ============================================================================
-- 1. ROLES TABLE
-- ============================================================================
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE roles IS 'บทบาทผู้ใช้งาน (customer, admin)';
COMMENT ON COLUMN roles.name IS 'ชื่อบทบาท: customer หรือ admin';

-- ============================================================================
-- 2. USERS TABLE
-- ============================================================================
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    role_id INTEGER NOT NULL REFERENCES roles(id) ON DELETE RESTRICT,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    name VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    address TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE users IS 'ข้อมูลผู้ใช้งานระบบ';
COMMENT ON COLUMN users.email IS 'อีเมลสำหรับ login';
COMMENT ON COLUMN users.password_hash IS 'รหัสผ่านที่ hash แล้ว (bcrypt)';

CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role_id ON users(role_id);

-- ============================================================================
-- 3. CATEGORIES TABLE
-- ============================================================================
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE categories IS 'หมวดหมู่หนังสือ';

-- ============================================================================
-- 4. AUTHORS TABLE
-- ============================================================================
CREATE TABLE authors (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    bio TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE authors IS 'ผู้แต่งหนังสือ';

-- ============================================================================
-- 5. EBOOKS TABLE
-- ============================================================================
CREATE TABLE ebooks (
    id SERIAL PRIMARY KEY,
    category_id INTEGER NOT NULL REFERENCES categories(id) ON DELETE RESTRICT,
    author_id INTEGER NOT NULL REFERENCES authors(id) ON DELETE RESTRICT,
    title VARCHAR(200) NOT NULL,
    description TEXT,
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    cover_url VARCHAR(500),
    download_url VARCHAR(500),
    stock INTEGER DEFAULT 0 CHECK (stock >= 0),
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE ebooks IS 'รายการหนังสืออิเล็กทรอนิกส์';
COMMENT ON COLUMN ebooks.price IS 'ราคาหนังสือ (ต้องมากกว่า 0)';
COMMENT ON COLUMN ebooks.stock IS 'จำนวนคงเหลือ (ต้องไม่เป็นลบ)';
COMMENT ON COLUMN ebooks.is_active IS 'สถานะพร้อมขาย';

CREATE INDEX idx_ebooks_category_id ON ebooks(category_id);
CREATE INDEX idx_ebooks_author_id ON ebooks(author_id);
CREATE INDEX idx_ebooks_title ON ebooks(title);
CREATE INDEX idx_ebooks_is_active ON ebooks(is_active);

-- ============================================================================
-- 6. CARTS TABLE
-- ============================================================================
CREATE TABLE carts (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    status VARCHAR(20) DEFAULT 'active' CHECK (status IN ('active', 'converted', 'abandoned')),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE carts IS 'ตะกร้าสินค้าของผู้ใช้';
COMMENT ON COLUMN carts.status IS 'active=ใช้งาน, converted=สั่งซื้อแล้ว, abandoned=ทิ้งไว้';

CREATE INDEX idx_carts_user_id ON carts(user_id);
CREATE INDEX idx_carts_status ON carts(status);

-- ============================================================================
-- 7. CART_ITEMS TABLE
-- ============================================================================
CREATE TABLE cart_items (
    id SERIAL PRIMARY KEY,
    cart_id INTEGER NOT NULL REFERENCES carts(id) ON DELETE CASCADE,
    ebook_id INTEGER NOT NULL REFERENCES ebooks(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL DEFAULT 1 CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    added_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE cart_items IS 'รายการในตะกร้า';
COMMENT ON COLUMN cart_items.price IS 'ราคา ณ เวลาเพิ่มลงตะกร้า';

CREATE INDEX idx_cart_items_cart_id ON cart_items(cart_id);
CREATE INDEX idx_cart_items_ebook_id ON cart_items(ebook_id);

-- ============================================================================
-- 8. ORDERS TABLE
-- ============================================================================
CREATE TABLE orders (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE RESTRICT,
    total_amount DECIMAL(10,2) NOT NULL CHECK (total_amount > 0),
    status VARCHAR(20) NOT NULL DEFAULT 'pending' CHECK (status IN ('pending', 'paid', 'confirmed', 'cancelled')),
    payment_slip_url VARCHAR(500),
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE orders IS 'คำสั่งซื้อ';
COMMENT ON COLUMN orders.status IS 'pending=รอชำระ, paid=ชำระแล้ว, confirmed=ยืนยันแล้ว, cancelled=ยกเลิก';

CREATE INDEX idx_orders_user_id ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at);

-- ============================================================================
-- 9. ORDER_ITEMS TABLE
-- ============================================================================
CREATE TABLE order_items (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    ebook_id INTEGER NOT NULL REFERENCES ebooks(id) ON DELETE RESTRICT,
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price > 0),
    subtotal DECIMAL(10,2) NOT NULL CHECK (subtotal > 0)
);

COMMENT ON TABLE order_items IS 'รายการในคำสั่งซื้อ';
COMMENT ON COLUMN order_items.price IS 'ราคา ณ เวลาสั่งซื้อ';
COMMENT ON COLUMN order_items.subtotal IS 'price × quantity';

CREATE INDEX idx_order_items_order_id ON order_items(order_id);
CREATE INDEX idx_order_items_ebook_id ON order_items(ebook_id);

-- ============================================================================
-- 10. PAYMENTS TABLE
-- ============================================================================
CREATE TABLE payments (
    id SERIAL PRIMARY KEY,
    order_id INTEGER NOT NULL UNIQUE REFERENCES orders(id) ON DELETE CASCADE,
    amount DECIMAL(10,2) NOT NULL CHECK (amount > 0),
    payment_method VARCHAR(50) NOT NULL,
    slip_url VARCHAR(500),
    status VARCHAR(20) DEFAULT 'pending' CHECK (status IN ('pending', 'verified', 'rejected')),
    paid_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE payments IS 'การชำระเงิน';
COMMENT ON COLUMN payments.order_id IS '1 คำสั่ง = 1 การชำระ (UNIQUE)';
COMMENT ON COLUMN payments.status IS 'pending=รอตรวจสอบ, verified=ยืนยันแล้ว, rejected=ปฏิเสธ';

CREATE INDEX idx_payments_order_id ON payments(order_id);
CREATE INDEX idx_payments_status ON payments(status);

-- ============================================================================
-- 11. DOWNLOAD_LINKS TABLE
-- ============================================================================
CREATE TABLE download_links (
    id SERIAL PRIMARY KEY,
    order_item_id INTEGER NOT NULL UNIQUE REFERENCES order_items(id) ON DELETE CASCADE,
    token VARCHAR(255) NOT NULL UNIQUE,
    expires_at TIMESTAMP NOT NULL,
    downloaded_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

COMMENT ON TABLE download_links IS 'ลิงก์ดาวน์โหลดหนังสือ';
COMMENT ON COLUMN download_links.token IS 'Token สำหรับเข้าถึงลิงก์';
COMMENT ON COLUMN download_links.expires_at IS 'วันหมดอายุของลิงก์';

CREATE INDEX idx_download_links_order_item_id ON download_links(order_item_id);
CREATE INDEX idx_download_links_token ON download_links(token);

-- ============================================================================
-- 12. REVIEWS TABLE
-- ============================================================================
CREATE TABLE reviews (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    ebook_id INTEGER NOT NULL REFERENCES ebooks(id) ON DELETE CASCADE,
    rating INTEGER NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, ebook_id)
);

COMMENT ON TABLE reviews IS 'รีวิวและให้คะแนนหนังสือ';
COMMENT ON COLUMN reviews.rating IS 'คะแนน 1-5 ดาว';
COMMENT ON CONSTRAINT reviews_user_id_ebook_id_key ON reviews IS '1 คน รีวิว 1 หนังสือได้ครั้งเดียว';

CREATE INDEX idx_reviews_user_id ON reviews(user_id);
CREATE INDEX idx_reviews_ebook_id ON reviews(ebook_id);
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- ============================================================================
-- 13. WISHLISTS TABLE
-- ============================================================================
CREATE TABLE wishlists (
    id SERIAL PRIMARY KEY,
    user_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    ebook_id INTEGER NOT NULL REFERENCES ebooks(id) ON DELETE CASCADE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE (user_id, ebook_id)
);

COMMENT ON TABLE wishlists IS 'รายการที่อยากได้';
COMMENT ON CONSTRAINT wishlists_user_id_ebook_id_key ON wishlists IS 'ไม่ให้มีรายการซ้ำ';

CREATE INDEX idx_wishlists_user_id ON wishlists(user_id);
CREATE INDEX idx_wishlists_ebook_id ON wishlists(ebook_id);

-- ============================================================================
-- SEED DATA
-- ============================================================================

-- Insert Roles
INSERT INTO roles (name, description) VALUES
('customer', 'ลูกค้าทั่วไป'),
('admin', 'ผู้ดูแลระบบ');

-- Insert Categories
INSERT INTO categories (name, description) VALUES
('นิยาย', 'นิยายทั่วไปและนิยายแปล'),
('พัฒนาตนเอง', 'หนังสือพัฒนาตนเองและสร้างแรงบันดาลใจ'),
('ธุรกิจ', 'หนังสือเกี่ยวกับการทำธุรกิจและการเงิน'),
('เทคโนโลยี', 'หนังสือเกี่ยวกับเทคโนโลยีและโปรแกรม'),
('วิทยาศาสตร์', 'หนังสือวิทยาศาสตร์และธรรมชาติ'),
('ประวัติศาสตร์', 'หนังสือประวัติศาสตร์และอารยธรรม'),
('อาหาร', 'หนังสือสอนทำอาหารและสูตรอาหาร'),
('สุขภาพ', 'หนังสือเกี่ยวกับสุขภาพและการออกกำลังกาย'),
('เด็กและเยาวชน', 'หนังสือสำหรับเด็กและเยาวชน'),
('จิตวิทยา', 'หนังสือจิตวิทยาและการเข้าใจตนเอง');

-- Insert Authors
INSERT INTO authors (name, bio) VALUES
('สมชาย วรรณกรรม', 'นักเขียนนิยายชื่อดัง'),
('วิชัย พัฒนา', 'ผู้เชี่ยวชาญด้านการพัฒนาตนเอง'),
('อรุณี ธุรกิจ', 'ที่ปรึกษาธุรกิจระดับสากล'),
('ธนา เทคโนโลยี', 'ผู้เชี่ยวชาญด้าน AI และ Machine Learning'),
('ดร. สมศรี วิทยาศาสตร์', 'นักวิจัยด้านชีววิทยา'),
('อาจารย์ประวัติศาสตร์', 'ผู้เชี่ยวชาญด้านประวัติศาสตร์ไทย'),
('เชฟสมศักดิ์', 'เชฟอาหารไทยระดับ Michelin'),
('ดร. สุขภาพดี', 'แพทย์ผู้เชี่ยวชาญด้านโภชนาการ'),
('นักเขียนเด็ก', 'นักเขียนหนังสือเด็ก'),
('ดร. จิตใจ', 'นักจิตวิทยาคลินิก');

-- Insert Ebooks (50+ books)
INSERT INTO ebooks (category_id, author_id, title, description, price, cover_url, download_url, stock, is_active) VALUES
-- นิยาย
(1, 1, 'รักในสายฝน', 'นิยายรักโรแมนติกในกรุงเทพฯ', 199.00, 'https://example.com/covers/rain.jpg', 'https://example.com/files/rain.pdf', 50, TRUE),
(1, 1, 'คืนเดือนมืด', 'นิยายลึกลับสอบสวน', 249.00, 'https://example.com/covers/dark.jpg', 'https://example.com/files/dark.pdf', 30, TRUE),
(1, 1, 'เส้นทางสู่ดวงดาว', 'นิยายผจญภัยในอวกาศ', 299.00, 'https://example.com/covers/stars.jpg', 'https://example.com/files/stars.pdf', 25, TRUE),

-- พัฒนาตนเอง
(2, 2, '7 นิสัยสู่ความสำเร็จ', 'คู่มือพัฒนาตนเอง', 299.00, 'https://example.com/covers/7habits.jpg', 'https://example.com/files/7habits.pdf', 100, TRUE),
(2, 2, 'พลังแห่งปัจจุบัน', 'การมีชีวิตอยู่ในปัจจุบัน', 249.00, 'https://example.com/covers/now.jpg', 'https://example.com/files/now.pdf', 80, TRUE),
(2, 2, 'คิดแบบยิว', 'เคล็ดลับความสำเร็จของชาวยิว', 199.00, 'https://example.com/covers/jewish.jpg', 'https://example.com/files/jewish.pdf', 60, TRUE),

-- ธุรกิจ
(3, 3, 'เริ่มต้นธุรกิจ 101', 'คู่มือสำหรับผู้ประกอบการใหม่', 399.00, 'https://example.com/covers/biz101.jpg', 'https://example.com/files/biz101.pdf', 45, TRUE),
(3, 3, 'การเงินสำหรับทุกคน', 'จัดการเงินส่วนบุคคล', 249.00, 'https://example.com/covers/finance.jpg', 'https://example.com/files/finance.pdf', 70, TRUE),
(3, 3, 'การตลาดดิจิทัล', 'กลยุทธ์การตลาดออนไลน์', 349.00, 'https://example.com/covers/digital.jpg', 'https://example.com/files/digital.pdf', 55, TRUE),

-- เทคโนโลยี
(4, 4, 'Python สำหรับทุกคน', 'เรียนรู้ Python จากศูนย์', 499.00, 'https://example.com/covers/python.jpg', 'https://example.com/files/python.pdf', 120, TRUE),
(4, 4, 'AI และ Machine Learning', 'พื้นฐานปัญญาประดิษฐ์', 599.00, 'https://example.com/covers/ai.jpg', 'https://example.com/files/ai.pdf', 90, TRUE),
(4, 4, 'Web Development 2026', 'พัฒนาเว็บไซต์สมัยใหม่', 449.00, 'https://example.com/covers/web.jpg', 'https://example.com/files/web.pdf', 75, TRUE),

-- วิทยาศาสตร์
(5, 5, 'จักรวาลและกาแล็กซี', 'สำรวจอวกาศ', 349.00, 'https://example.com/covers/universe.jpg', 'https://example.com/files/universe.pdf', 40, TRUE),
(5, 5, 'ชีววิทยาโมเลกุล', 'พื้นฐานชีวิตระดับโมเลกุล', 449.00, 'https://example.com/covers/bio.jpg', 'https://example.com/files/bio.pdf', 35, TRUE),
(5, 5, 'ฟิสิกส์ควอนตัม', 'เข้าใจโลกควอนตัม', 399.00, 'https://example.com/covers/quantum.jpg', 'https://example.com/files/quantum.pdf', 30, TRUE),

-- ประวัติศาสตร์
(6, 6, 'อยุธยาโบราณ', 'ประวัติศาสตร์อาณาจักรอยุธยา', 299.00, 'https://example.com/covers/ayutthaya.jpg', 'https://example.com/files/ayutthaya.pdf', 50, TRUE),
(6, 6, 'สงครามโลกครั้งที่ 2', 'เหตุการณ์สำคัญในประวัติศาสตร์', 349.00, 'https://example.com/covers/ww2.jpg', 'https://example.com/files/ww2.pdf', 45, TRUE),
(6, 6, 'อารยธรรมอียิปต์', 'สำรวจอียิปต์โบราณ', 279.00, 'https://example.com/covers/egypt.jpg', 'https://example.com/files/egypt.pdf', 40, TRUE),

-- อาหาร
(7, 7, 'สูตรอาหารไทย 100 เมนู', 'รวมสูตรอาหารไทยยอดนิยม', 199.00, 'https://example.com/covers/thaifood.jpg', 'https://example.com/files/thaifood.pdf', 85, TRUE),
(7, 7, 'เบเกอรี่สำหรับมือใหม่', 'สอนทำเบเกอรี่ง่ายๆ', 249.00, 'https://example.com/covers/bakery.jpg', 'https://example.com/files/bakery.pdf', 65, TRUE),
(7, 7, 'อาหารญี่ปุ่น', 'สูตรอาหารญี่ปุ่นแท้', 299.00, 'https://example.com/covers/japanese.jpg', 'https://example.com/files/japanese.pdf', 55, TRUE),

-- สุขภาพ
(8, 8, 'อาหารเพื่อสุขภาพ', 'โภชนาการสำหรับสุขภาพดี', 249.00, 'https://example.com/covers/healthy.jpg', 'https://example.com/files/healthy.pdf', 95, TRUE),
(8, 8, 'ออกกำลังกายที่บ้าน', 'ฟิตเนสโดยไม่ต้องไปยิม', 199.00, 'https://example.com/covers/home.jpg', 'https://example.com/files/home.pdf', 110, TRUE),
(8, 8, 'โยคะสำหรับทุกคน', 'เริ่มต้นเล่นโยคะ', 229.00, 'https://example.com/covers/yoga.jpg', 'https://example.com/files/yoga.pdf', 80, TRUE),

-- เด็กและเยาวชน
(9, 9, 'นิทานก่อนนอน', 'นิทานสำหรับเด็ก 3-6 ปี', 149.00, 'https://example.com/covers/bedtime.jpg', 'https://example.com/files/bedtime.pdf', 150, TRUE),
(9, 9, 'การผจญภัยของน้องแมว', 'นิทานภาพสำหรับเด็ก', 129.00, 'https://example.com/covers/cat.jpg', 'https://example.com/files/cat.pdf', 130, TRUE),
(9, 9, 'วิทยาศาสตร์สำหรับเด็ก', 'เรียนรู้วิทยาศาสตร์อย่างสนุก', 179.00, 'https://example.com/covers/kidsci.jpg', 'https://example.com/files/kidsci.pdf', 100, TRUE),

-- จิตวิทยา
(10, 10, 'เข้าใจตนเอง', 'จิตวิทยาการเข้าใจตนเอง', 279.00, 'https://example.com/covers/self.jpg', 'https://example.com/files/self.pdf', 70, TRUE),
(10, 10, 'ความสัมพันธ์ที่ดี', 'จิตวิทยาความสัมพันธ์', 249.00, 'https://example.com/covers/relation.jpg', 'https://example.com/files/relation.pdf', 60, TRUE),
(10, 10, 'จัดการความเครียด', 'เทคนิคจัดการความเครียด', 229.00, 'https://example.com/covers/stress.jpg', 'https://example.com/files/stress.pdf', 85, TRUE),

-- เพิ่มหนังสืออีก 20 เล่ม
(1, 1, 'เงาจันทร์', 'นิยายรักย้อนยุค', 229.00, 'https://example.com/covers/moon.jpg', 'https://example.com/files/moon.pdf', 35, TRUE),
(2, 2, 'ผู้นำในตัวเอง', 'พัฒนาความเป็นผู้นำ', 329.00, 'https://example.com/covers/leader.jpg', 'https://example.com/files/leader.pdf', 50, TRUE),
(3, 3, 'ลงทุนหุ้นสำหรับมือใหม่', 'เริ่มต้นลงทุน', 399.00, 'https://example.com/covers/stock.jpg', 'https://example.com/files/stock.pdf', 65, TRUE),
(4, 4, 'Data Science', 'วิทยาศาสตร์ข้อมูล', 549.00, 'https://example.com/covers/datasci.jpg', 'https://example.com/files/datasci.pdf', 80, TRUE),
(5, 5, 'วิวัฒนาการ', 'ทฤษฎีวิวัฒนาการ', 329.00, 'https://example.com/covers/evolution.jpg', 'https://example.com/files/evolution.pdf', 40, TRUE),
(6, 6, 'รัตนโกสินทร์', 'ประวัติศาสตร์รัตนโกสินทร์', 349.00, 'https://example.com/covers/rattana.jpg', 'https://example.com/files/rattana.pdf', 55, TRUE),
(7, 7, 'อาหารจีน', 'สูตรอาหารจีน', 279.00, 'https://example.com/covers/chinese.jpg', 'https://example.com/files/chinese.pdf', 50, TRUE),
(8, 8, 'นอนหลับให้สนิท', 'เทคนิคการนอนหลับ', 199.00, 'https://example.com/covers/sleep.jpg', 'https://example.com/files/sleep.pdf', 90, TRUE),
(9, 9, 'ไดโนเสาร์', 'หนังสือภาพไดโนเสาร์', 159.00, 'https://example.com/covers/dino.jpg', 'https://example.com/files/dino.pdf', 120, TRUE),
(10, 10, 'จิตวิทยาเชิงบวก', 'สร้างชีวิตบวก', 259.00, 'https://example.com/covers/positive.jpg', 'https://example.com/files/positive.pdf', 75, TRUE),
(1, 1, 'รักสุดท้าย', 'นิยายรักดราม่า', 219.00, 'https://example.com/covers/last.jpg', 'https://example.com/files/last.pdf', 40, TRUE),
(2, 2, 'เวลาไม่เคยรอใคร', 'จัดการเวลาอย่างมีประสิทธิภาพ', 269.00, 'https://example.com/covers/time.jpg', 'https://example.com/files/time.pdf', 85, TRUE),
(3, 3, 'เศรษฐศาสตร์สำหรับทุกคน', 'เข้าใจเศรษฐกิจ', 299.00, 'https://example.com/covers/econ.jpg', 'https://example.com/files/econ.pdf', 70, TRUE),
(4, 4, 'Blockchain', 'เทคโนโลยีบล็อกเชน', 499.00, 'https://example.com/covers/blockchain.jpg', 'https://example.com/files/blockchain.pdf', 60, TRUE),
(5, 5, 'เคมีในชีวิต', 'เคมีรอบตัวเรา', 279.00, 'https://example.com/covers/chem.jpg', 'https://example.com/files/chem.pdf', 45, TRUE),
(1, 1, 'ฤดูร้อนนั้น', 'นิยายรักวัยรุ่น', 189.00, 'https://example.com/covers/summer.jpg', 'https://example.com/files/summer.pdf', 55, TRUE),
(2, 2, 'ความสุขภายใน', 'ค้นหาความสุขจากภายใน', 239.00, 'https://example.com/covers/inner.jpg', 'https://example.com/files/inner.pdf', 95, TRUE),
(3, 3, 'อสังหาริมทรัพย์', 'ลงทุนอสังหา', 449.00, 'https://example.com/covers/property.jpg', 'https://example.com/files/property.pdf', 50, TRUE),
(4, 4, 'Cybersecurity', 'ความปลอดภัยไซเบอร์', 599.00, 'https://example.com/covers/cyber.jpg', 'https://example.com/files/cyber.pdf', 70, TRUE),
(5, 5, 'ดาราศาสตร์', 'ดูดาวและจักรวาล', 349.00, 'https://example.com/covers/astro.jpg', 'https://example.com/files/astro.pdf', 35, TRUE);

-- Insert Users (100+ users)
-- Password hash สำหรับ 'password123' = '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr'
INSERT INTO users (role_id, email, password_hash, name, phone, address, is_active) VALUES
-- Admins (2 คน)
(2, 'admin@ebookmart.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Admin User', '0812345678', '123 Admin St, Bangkok', TRUE),
(2, 'manager@ebookmart.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Manager User', '0823456789', '456 Manager Ave, Bangkok', TRUE),

-- Customers (100 คน)
(1, 'customer1@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'สมชาย ใจดี', '0811111111', '1 ถนนสุขุมวิท กรุงเทพฯ', TRUE),
(1, 'customer2@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'สมหญิง รักเรียน', '0822222222', '2 ถนนพระราม 9 กรุงเทพฯ', TRUE),
(1, 'customer3@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'วิชัย มุ่งมั่น', '0833333333', '3 ถนนลาดพร้าว กรุงเทพฯ', TRUE),
(1, 'customer4@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'อรุณี สดใส', '0844444444', '4 ถนนรัชดา กรุงเทพฯ', TRUE),
(1, 'customer5@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'ธนา ฉลาด', '0855555555', '5 ถนนเอกมัย กรุงเทพฯ', TRUE),
(1, 'customer6@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'สมศรี อบอุ่น', '0866666666', '6 ถนนทองหล่อ กรุงเทพฯ', TRUE),
(1, 'customer7@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'ประเสริฐ มั่นคง', '0877777777', '7 ถนนเพลินจิต กรุงเทพฯ', TRUE),
(1, 'customer8@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'มาลี หวานชื่น', '0888888888', '8 ถนนสีลม กรุงเทพฯ', TRUE),
(1, 'customer9@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'สมศักดิ์ เก่งกาจ', '0899999999', '9 ถนนสาทร กรุงเทพฯ', TRUE),
(1, 'customer10@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'วิภา น่ารัก', '0810101010', '10 ถนนพหลโยธิน กรุงเทพฯ', TRUE);

-- เพิ่มลูกค้าอีก 90 คน (สร้างแบบ loop)
INSERT INTO users (role_id, email, password_hash, name, phone, address, is_active)
SELECT 
    1,
    'customer' || (i + 10) || '@email.com',
    '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr',
    'Customer ' || (i + 10),
    '08' || LPAD((i + 10)::TEXT, 8, '0'),
    (i + 10) || ' Sample Street, Bangkok',
    TRUE
FROM generate_series(1, 90) AS i;

-- Insert Carts (1 cart per user)
INSERT INTO carts (user_id, status)
SELECT id, 'active' FROM users WHERE role_id = 1;

-- Insert Orders (30+ orders with various statuses)
-- Order 1-10: confirmed (paid and confirmed)
INSERT INTO orders (user_id, total_amount, status, payment_slip_url, notes, created_at) VALUES
(3, 797.00, 'confirmed', 'https://example.com/slips/slip1.jpg', 'สั่งซื้อหนังสือพัฒนาตนเอง', CURRENT_TIMESTAMP - INTERVAL '30 days'),
(4, 1048.00, 'confirmed', 'https://example.com/slips/slip2.jpg', 'สั่งซื้อหนังสือเทคโนโลยี', CURRENT_TIMESTAMP - INTERVAL '28 days'),
(5, 598.00, 'confirmed', 'https://example.com/slips/slip3.jpg', 'สั่งซื้อนิยาย', CURRENT_TIMESTAMP - INTERVAL '25 days'),
(6, 1297.00, 'confirmed', 'https://example.com/slips/slip4.jpg', 'สั่งซื้อหนังสือธุรกิจ', CURRENT_TIMESTAMP - INTERVAL '22 days'),
(7, 448.00, 'confirmed', 'https://example.com/slips/slip5.jpg', 'สั่งซื้อหนังสืออาหาร', CURRENT_TIMESTAMP - INTERVAL '20 days'),
(8, 897.00, 'confirmed', 'https://example.com/slips/slip6.jpg', 'สั่งซื้อหนังสือสุขภาพ', CURRENT_TIMESTAMP - INTERVAL '18 days'),
(9, 299.00, 'confirmed', 'https://example.com/slips/slip7.jpg', 'สั่งซื้อหนังสือเด็ก', CURRENT_TIMESTAMP - INTERVAL '15 days'),
(10, 757.00, 'confirmed', 'https://example.com/slips/slip8.jpg', 'สั่งซื้อหนังสือจิตวิทยา', CURRENT_TIMESTAMP - INTERVAL '12 days'),
(11, 1198.00, 'confirmed', 'https://example.com/slips/slip9.jpg', 'สั่งซื้อหนังสือวิทยาศาสตร์', CURRENT_TIMESTAMP - INTERVAL '10 days'),
(12, 648.00, 'confirmed', 'https://example.com/slips/slip10.jpg', 'สั่งซื้อหนังสือประวัติศาสตร์', CURRENT_TIMESTAMP - INTERVAL '8 days');

-- Order 11-20: paid (paid but not confirmed yet)
INSERT INTO orders (user_id, total_amount, status, payment_slip_url, notes, created_at) VALUES
(13, 599.00, 'paid', 'https://example.com/slips/slip11.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(14, 449.00, 'paid', 'https://example.com/slips/slip12.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '4 days'),
(15, 798.00, 'paid', 'https://example.com/slips/slip13.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '3 days'),
(16, 299.00, 'paid', 'https://example.com/slips/slip14.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '2 days'),
(17, 1098.00, 'paid', 'https://example.com/slips/slip15.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(18, 549.00, 'paid', 'https://example.com/slips/slip16.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(19, 399.00, 'paid', 'https://example.com/slips/slip17.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(20, 899.00, 'paid', 'https://example.com/slips/slip18.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(21, 649.00, 'paid', 'https://example.com/slips/slip19.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(22, 1299.00, 'paid', 'https://example.com/slips/slip20.jpg', 'รอตรวจสอบสลิป', CURRENT_TIMESTAMP - INTERVAL '1 day');

-- Order 21-25: pending (waiting for payment)
INSERT INTO orders (user_id, total_amount, status, notes, created_at) VALUES
(23, 599.00, 'pending', 'รอการชำระเงิน', CURRENT_TIMESTAMP - INTERVAL '2 hours'),
(24, 449.00, 'pending', 'รอการชำระเงิน', CURRENT_TIMESTAMP - INTERVAL '3 hours'),
(25, 799.00, 'pending', 'รอการชำระเงิน', CURRENT_TIMESTAMP - INTERVAL '4 hours'),
(26, 299.00, 'pending', 'รอการชำระเงิน', CURRENT_TIMESTAMP - INTERVAL '5 hours'),
(27, 1099.00, 'pending', 'รอการชำระเงิน', CURRENT_TIMESTAMP - INTERVAL '6 hours');

-- Order 26-30: cancelled
INSERT INTO orders (user_id, total_amount, status, notes, created_at) VALUES
(28, 599.00, 'cancelled', 'ลูกค้าขอยกเลิก', CURRENT_TIMESTAMP - INTERVAL '7 days'),
(29, 449.00, 'cancelled', 'ลูกค้าขอยกเลิก', CURRENT_TIMESTAMP - INTERVAL '6 days'),
(30, 799.00, 'cancelled', 'ลูกค้าขอยกเลิก', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(31, 299.00, 'cancelled', 'ลูกค้าขอยกเลิก', CURRENT_TIMESTAMP - INTERVAL '4 days'),
(32, 1099.00, 'cancelled', 'ลูกค้าขอยกเลิก', CURRENT_TIMESTAMP - INTERVAL '3 days');

-- Insert Order Items (for confirmed orders)
-- Order 1: 2 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(1, 4, 1, 299.00, 299.00),
(1, 5, 1, 249.00, 249.00),
(1, 6, 1, 199.00, 199.00);

-- Order 2: 2 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(2, 10, 1, 499.00, 499.00),
(2, 11, 1, 599.00, 599.00);

-- Order 3: 2 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(3, 1, 1, 199.00, 199.00),
(3, 2, 1, 249.00, 249.00);

-- Order 4: 3 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(4, 7, 1, 399.00, 399.00),
(4, 8, 1, 249.00, 249.00),
(4, 9, 1, 349.00, 349.00);

-- Order 5: 2 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(5, 19, 1, 199.00, 199.00),
(5, 20, 1, 249.00, 249.00);

-- Order 6: 3 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(6, 22, 1, 249.00, 249.00),
(6, 23, 1, 199.00, 199.00),
(6, 24, 1, 229.00, 229.00);

-- Order 7: 1 item
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(7, 25, 1, 149.00, 149.00);

-- Order 8: 3 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(8, 28, 1, 279.00, 279.00),
(8, 29, 1, 249.00, 249.00),
(8, 30, 1, 229.00, 229.00);

-- Order 9: 2 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(9, 13, 1, 349.00, 349.00),
(9, 14, 1, 449.00, 449.00);

-- Order 10: 2 items
INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal) VALUES
(10, 16, 1, 299.00, 299.00),
(10, 17, 1, 349.00, 349.00);

-- Insert Payments (for confirmed and paid orders)
INSERT INTO payments (order_id, amount, payment_method, slip_url, status, paid_at) VALUES
(1, 797.00, 'โอนเงิน', 'https://example.com/slips/slip1.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '29 days'),
(2, 1048.00, 'โอนเงิน', 'https://example.com/slips/slip2.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '27 days'),
(3, 598.00, 'QR Code', 'https://example.com/slips/slip3.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '24 days'),
(4, 1297.00, 'โอนเงิน', 'https://example.com/slips/slip4.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '21 days'),
(5, 448.00, 'QR Code', 'https://example.com/slips/slip5.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '19 days'),
(6, 897.00, 'โอนเงิน', 'https://example.com/slips/slip6.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '17 days'),
(7, 299.00, 'QR Code', 'https://example.com/slips/slip7.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '14 days'),
(8, 757.00, 'โอนเงิน', 'https://example.com/slips/slip8.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '11 days'),
(9, 1198.00, 'QR Code', 'https://example.com/slips/slip9.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '9 days'),
(10, 648.00, 'โอนเงิน', 'https://example.com/slips/slip10.jpg', 'verified', CURRENT_TIMESTAMP - INTERVAL '7 days'),
(11, 599.00, 'QR Code', 'https://example.com/slips/slip11.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '5 days'),
(12, 449.00, 'โอนเงิน', 'https://example.com/slips/slip12.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '4 days'),
(13, 798.00, 'QR Code', 'https://example.com/slips/slip13.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '3 days'),
(14, 299.00, 'โอนเงิน', 'https://example.com/slips/slip14.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '2 days'),
(15, 1098.00, 'QR Code', 'https://example.com/slips/slip15.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(16, 549.00, 'โอนเงิน', 'https://example.com/slips/slip16.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(17, 399.00, 'QR Code', 'https://example.com/slips/slip17.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(18, 899.00, 'โอนเงิน', 'https://example.com/slips/slip18.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(19, 649.00, 'QR Code', 'https://example.com/slips/slip19.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '1 day'),
(20, 1299.00, 'โอนเงิน', 'https://example.com/slips/slip20.jpg', 'pending', CURRENT_TIMESTAMP - INTERVAL '1 day');

-- Insert Download Links (for confirmed orders only)
INSERT INTO download_links (order_item_id, token, expires_at, downloaded_at) VALUES
(1, 'token_abc123_def456', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '28 days'),
(2, 'token_ghi789_jkl012', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '28 days'),
(3, 'token_mno345_pqr678', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '28 days'),
(4, 'token_stu901_vwx234', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '26 days'),
(5, 'token_yza567_bcd890', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '26 days'),
(6, 'token_efg123_hij456', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '23 days'),
(7, 'token_klm789_nop012', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '23 days'),
(8, 'token_qrs345_tuv678', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '20 days'),
(9, 'token_wxy901_abc234', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '20 days'),
(10, 'token_def567_ghi890', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '18 days'),
(11, 'token_jkl123_mno456', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '18 days'),
(12, 'token_pqr789_stu012', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '18 days'),
(13, 'token_vwx345_yza678', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '13 days'),
(14, 'token_bcd901_efg234', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '10 days'),
(15, 'token_hij567_klm890', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '10 days'),
(16, 'token_nop123_qrs456', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '8 days'),
(17, 'token_tuv789_wxy012', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '6 days'),
(18, 'token_yza345_bcd678', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '6 days'),
(19, 'token_efg901_hij234', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '6 days'),
(20, 'token_klm567_nop890', CURRENT_TIMESTAMP + INTERVAL '7 days', CURRENT_TIMESTAMP - INTERVAL '6 days');

-- Insert Reviews (for confirmed orders)
INSERT INTO reviews (user_id, ebook_id, rating, comment) VALUES
(3, 4, 5, 'หนังสือดีมาก ได้ความรู้เยอะ'),
(3, 5, 4, 'เนื้อหาดี แต่บางจุดเข้าใจยาก'),
(3, 6, 5, 'ชอบมาก อ่านแล้วได้แรงบันดาลใจ'),
(4, 10, 5, 'สอน Python ได้เข้าใจง่ายมาก'),
(4, 11, 4, 'เนื้อหาครอบคลุม แต่ควรเพิ่มตัวอย่าง'),
(5, 1, 4, 'นิยายสนุก อ่านแล้วอิน'),
(5, 2, 5, 'พล็อตเรื่องน่าสนใจมาก'),
(6, 7, 5, 'คู่มือเริ่มต้นธุรกิจที่ดีมาก'),
(6, 8, 4, 'เนื้อหาดี แต่ควรอัปเดตข้อมูล'),
(6, 9, 4, 'ได้ความรู้การตลาดดิจิทัลเยอะ'),
(7, 19, 5, 'สูตรอาหารทำง่าย อร่อย'),
(7, 20, 4, 'เบเกอรี่ทำไม่ยากเลย'),
(8, 22, 5, 'อาหารสุขภาพทำง่าย'),
(8, 23, 4, 'ออกกำลังกายที่บ้านสะดวกมาก'),
(8, 24, 5, 'โยคะช่วยผ่อนคลายได้ดี'),
(9, 25, 5, 'นิทานน่ารัก ลูกชอบมาก'),
(10, 28, 4, 'เข้าใจตนเองมากขึ้น'),
(10, 29, 5, 'ความสัมพันธ์ดีขึ้นหลังอ่าน'),
(10, 30, 4, 'จัดการความเครียดได้ดีขึ้น'),
(11, 13, 5, 'จักรวาลน่าอัศจรรย์มาก'),
(11, 14, 4, 'ชีววิทยาโมเลกุลเข้าใจยากแต่ดี'),
(12, 16, 5, 'ประวัติศาสตร์อยุธยาสนุก'),
(12, 17, 4, 'สงครามโลกน่าติดตาม');

-- Insert Wishlists
INSERT INTO wishlists (user_id, ebook_id) VALUES
(3, 13),
(3, 15),
(4, 12),
(4, 18),
(5, 3),
(5, 31),
(6, 32),
(6, 33),
(7, 21),
(7, 34),
(8, 35),
(8, 36),
(9, 37),
(9, 38),
(10, 39),
(10, 40),
(11, 41),
(11, 42),
(12, 43),
(12, 44);

-- ============================================================================
-- VIEWS FOR REPORTS
-- ============================================================================

-- View 1: Sales by Time Period
CREATE OR REPLACE VIEW report_sales_by_time AS
SELECT 
    DATE_TRUNC('month', o.created_at) AS month,
    COUNT(DISTINCT o.id) AS total_orders,
    SUM(o.total_amount) AS total_sales,
    AVG(o.total_amount) AS avg_order_value
FROM orders o
WHERE o.status IN ('paid', 'confirmed')
GROUP BY DATE_TRUNC('month', o.created_at)
ORDER BY month;

-- View 2: Best Selling Ebooks
CREATE OR REPLACE VIEW report_best_selling_ebooks AS
SELECT 
    e.id AS ebook_id,
    e.title,
    a.name AS author_name,
    c.name AS category_name,
    SUM(oi.quantity) AS total_sold,
    SUM(oi.subtotal) AS total_revenue
FROM order_items oi
JOIN ebooks e ON oi.ebook_id = e.id
JOIN authors a ON e.author_id = a.id
JOIN categories c ON e.category_id = c.id
JOIN orders o ON oi.order_id = o.id
WHERE o.status IN ('paid', 'confirmed')
GROUP BY e.id, e.title, a.name, c.name
ORDER BY total_sold DESC
LIMIT 10;

-- View 3: Sales by Category
CREATE OR REPLACE VIEW report_sales_by_category AS
SELECT 
    c.id AS category_id,
    c.name AS category_name,
    COUNT(DISTINCT oi.ebook_id) AS unique_ebooks_sold,
    SUM(oi.quantity) AS total_items_sold,
    SUM(oi.subtotal) AS total_revenue
FROM categories c
LEFT JOIN ebooks e ON c.id = e.category_id
LEFT JOIN order_items oi ON e.id = oi.ebook_id
LEFT JOIN orders o ON oi.order_id = o.id AND o.status IN ('paid', 'confirmed')
GROUP BY c.id, c.name
ORDER BY total_revenue DESC;

-- View 4: Customer Analysis
CREATE OR REPLACE VIEW report_customer_analysis AS
SELECT 
    u.id AS user_id,
    u.name,
    u.email,
    COUNT(DISTINCT o.id) AS total_orders,
    SUM(o.total_amount) AS total_spent,
    AVG(o.total_amount) AS avg_order_value,
    MAX(o.created_at) AS last_order_date
FROM users u
LEFT JOIN orders o ON u.id = o.user_id AND o.status IN ('paid', 'confirmed')
WHERE u.role_id = 1
GROUP BY u.id, u.name, u.email
HAVING COUNT(DISTINCT o.id) > 0
ORDER BY total_spent DESC;

-- View 5: Order Status Summary
CREATE OR REPLACE VIEW report_order_status_summary AS
SELECT 
    status,
    COUNT(*) AS order_count,
    SUM(total_amount) AS total_amount
FROM orders
GROUP BY status
ORDER BY order_count DESC;

-- ============================================================================
-- STORED PROCEDURES
-- ============================================================================

-- Procedure: Create Order from Cart
CREATE OR REPLACE FUNCTION create_order_from_cart(
    p_user_id INTEGER,
    p_payment_method VARCHAR,
    p_slip_url VARCHAR
) RETURNS INTEGER AS $$
DECLARE
    v_cart_id INTEGER;
    v_order_id INTEGER;
    v_total_amount DECIMAL(10,2);
BEGIN
    -- Get active cart
    SELECT id INTO v_cart_id FROM carts WHERE user_id = p_user_id AND status = 'active';
    
    IF v_cart_id IS NULL THEN
        RAISE EXCEPTION 'No active cart found for user %', p_user_id;
    END IF;
    
    -- Calculate total
    SELECT COALESCE(SUM(price * quantity), 0) INTO v_total_amount
    FROM cart_items WHERE cart_id = v_cart_id;
    
    IF v_total_amount = 0 THEN
        RAISE EXCEPTION 'Cart is empty';
    END IF;
    
    -- Create order
    INSERT INTO orders (user_id, total_amount, status, payment_slip_url)
    VALUES (p_user_id, v_total_amount, 'pending', p_slip_url)
    RETURNING id INTO v_order_id;
    
    -- Copy cart items to order items
    INSERT INTO order_items (order_id, ebook_id, quantity, price, subtotal)
    SELECT v_order_id, ebook_id, quantity, price, price * quantity
    FROM cart_items WHERE cart_id = v_cart_id;
    
    -- Create payment record
    INSERT INTO payments (order_id, amount, payment_method, slip_url, status)
    VALUES (v_order_id, v_total_amount, p_payment_method, p_slip_url, 'pending');
    
    -- Update cart status
    UPDATE carts SET status = 'converted', updated_at = CURRENT_TIMESTAMP WHERE id = v_cart_id;
    
    -- Clear cart items
    DELETE FROM cart_items WHERE cart_id = v_cart_id;
    
    RETURN v_order_id;
END;
$$ LANGUAGE plpgsql;

-- Procedure: Confirm Order and Generate Download Links
CREATE OR REPLACE FUNCTION confirm_order(p_order_id INTEGER) RETURNS VOID AS $$
DECLARE
    v_order_item RECORD;
    v_token VARCHAR;
BEGIN
    -- Update order status
    UPDATE orders 
    SET status = 'confirmed', updated_at = CURRENT_TIMESTAMP 
    WHERE id = p_order_id;
    
    -- Update payment status
    UPDATE payments 
    SET status = 'verified', paid_at = CURRENT_TIMESTAMP 
    WHERE order_id = p_order_id;
    
    -- Generate download links for each order item
    FOR v_order_item IN 
        SELECT oi.id, e.download_url 
        FROM order_items oi
        JOIN ebooks e ON oi.ebook_id = e.id
        WHERE oi.order_id = p_order_id
    LOOP
        v_token := 'token_' || MD5(RANDOM()::TEXT || CLOCK_TIMESTAMP()::TEXT);
        
        INSERT INTO download_links (order_item_id, token, expires_at)
        VALUES (v_order_item.id, v_token, CURRENT_TIMESTAMP + INTERVAL '7 days');
    END LOOP;
END;
$$ LANGUAGE plpgsql;

-- Procedure: Add to Cart
CREATE OR REPLACE FUNCTION add_to_cart(
    p_user_id INTEGER,
    p_ebook_id INTEGER,
    p_quantity INTEGER DEFAULT 1
) RETURNS VOID AS $$
DECLARE
    v_cart_id INTEGER;
    v_price DECIMAL(10,2);
BEGIN
    -- Get or create cart
    SELECT id INTO v_cart_id FROM carts WHERE user_id = p_user_id AND status = 'active';
    
    IF v_cart_id IS NULL THEN
        INSERT INTO carts (user_id, status) VALUES (p_user_id, 'active') RETURNING id INTO v_cart_id;
    END IF;
    
    -- Get ebook price
    SELECT price INTO v_price FROM ebooks WHERE id = p_ebook_id AND is_active = TRUE;
    
    IF v_price IS NULL THEN
        RAISE EXCEPTION 'Ebook not found or not active';
    END IF;
    
    -- Check if item already in cart
    IF EXISTS (SELECT 1 FROM cart_items WHERE cart_id = v_cart_id AND ebook_id = p_ebook_id) THEN
        UPDATE cart_items 
        SET quantity = quantity + p_quantity, added_at = CURRENT_TIMESTAMP
        WHERE cart_id = v_cart_id AND ebook_id = p_ebook_id;
    ELSE
        INSERT INTO cart_items (cart_id, ebook_id, quantity, price)
        VALUES (v_cart_id, p_ebook_id, p_quantity, v_price);
    END IF;
END;
$$ LANGUAGE plpgsql;

-- ============================================================================
-- SAMPLE QUERIES FOR TESTING
-- ============================================================================

-- Query 1: Get all active ebooks with category and author
SELECT 
    e.id,
    e.title,
    e.price,
    e.stock,
    c.name AS category,
    a.name AS author
FROM ebooks e
JOIN categories c ON e.category_id = c.id
JOIN authors a ON e.author_id = a.id
WHERE e.is_active = TRUE
ORDER BY e.created_at DESC;

-- Query 2: Get user cart with items
SELECT 
    c.id AS cart_id,
    e.title,
    ci.quantity,
    ci.price,
    (ci.quantity * ci.price) AS subtotal
FROM carts c
JOIN cart_items ci ON c.id = ci.cart_id
JOIN ebooks e ON ci.ebook_id = e.id
WHERE c.user_id = 3 AND c.status = 'active';

-- Query 3: Get order details with items
SELECT 
    o.id AS order_id,
    o.status,
    o.total_amount,
    e.title,
    oi.quantity,
    oi.price,
    oi.subtotal
FROM orders o
JOIN order_items oi ON o.id = oi.order_id
JOIN ebooks e ON oi.ebook_id = e.id
WHERE o.user_id = 3
ORDER BY o.created_at DESC;

-- Query 4: Get download links for confirmed order
SELECT 
    dl.token,
    dl.expires_at,
    e.title,
    e.download_url
FROM download_links dl
JOIN order_items oi ON dl.order_item_id = oi.id
JOIN orders o ON oi.order_id = o.id
JOIN ebooks e ON oi.ebook_id = e.id
WHERE o.id = 1 AND o.status = 'confirmed';

-- ============================================================================
-- END OF SCHEMA
-- ============================================================================