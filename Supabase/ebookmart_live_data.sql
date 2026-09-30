SET session_replication_role = replica;

--
-- PostgreSQL database dump
--

-- \restrict JgGdgMm35i9q6ZdeoMe1UKS2Wz9l9oFlKiwScDyYqvJkVy344hVh1VFZuU66tic

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Data for Name: authors; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."authors" ("id", "name", "bio", "created_at") VALUES
	(1, 'สมชาย วรรณกรรม', 'นักเขียนนิยายชื่อดัง', '2026-09-22 04:47:53.158015'),
	(2, 'วิชัย พัฒนา', 'ผู้เชี่ยวชาญด้านการพัฒนาตนเอง', '2026-09-22 04:47:53.158015'),
	(3, 'อรุณี ธุรกิจ', 'ที่ปรึกษาธุรกิจระดับสากล', '2026-09-22 04:47:53.158015'),
	(4, 'ธนา เทคโนโลยี', 'ผู้เชี่ยวชาญด้าน AI และ Machine Learning', '2026-09-22 04:47:53.158015'),
	(5, 'ดร. สมศรี วิทยาศาสตร์', 'นักวิจัยด้านชีววิทยา', '2026-09-22 04:47:53.158015'),
	(6, 'อาจารย์ประวัติศาสตร์', 'ผู้เชี่ยวชาญด้านประวัติศาสตร์ไทย', '2026-09-22 04:47:53.158015'),
	(7, 'เชฟสมศักดิ์', 'เชฟอาหารไทยระดับ Michelin', '2026-09-22 04:47:53.158015'),
	(8, 'ดร. สุขภาพดี', 'แพทย์ผู้เชี่ยวชาญด้านโภชนาการ', '2026-09-22 04:47:53.158015'),
	(9, 'นักเขียนเด็ก', 'นักเขียนหนังสือเด็ก', '2026-09-22 04:47:53.158015'),
	(10, 'ดร. จิตใจ', 'นักจิตวิทยาคลินิก', '2026-09-22 04:47:53.158015'),
	(11, 'เตชสิทธิ์ แก้ววิเชียร', '67332110245-5', '2026-09-26 23:47:53.978904');


--
-- Data for Name: roles; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."roles" ("id", "name", "description", "created_at") VALUES
	(1, 'customer', 'ลูกค้าทั่วไป', '2026-09-22 04:47:53.158015'),
	(2, 'admin', 'ผู้ดูแลระบบ', '2026-09-22 04:47:53.158015');


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."users" ("id", "role_id", "email", "password_hash", "name", "phone", "address", "is_active", "created_at", "updated_at") VALUES
	(2, 2, 'manager@ebookmart.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Manager User', '0823456789', '456 Manager Ave, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(13, 1, 'customer11@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 11', '0800000011', '11 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(14, 1, 'customer12@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 12', '0800000012', '12 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(15, 1, 'customer13@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 13', '0800000013', '13 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(16, 1, 'customer14@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 14', '0800000014', '14 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(17, 1, 'customer15@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 15', '0800000015', '15 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(18, 1, 'customer16@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 16', '0800000016', '16 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(19, 1, 'customer17@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 17', '0800000017', '17 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(20, 1, 'customer18@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 18', '0800000018', '18 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(21, 1, 'customer19@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 19', '0800000019', '19 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(22, 1, 'customer20@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 20', '0800000020', '20 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(23, 1, 'customer21@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 21', '0800000021', '21 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(24, 1, 'customer22@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 22', '0800000022', '22 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(25, 1, 'customer23@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 23', '0800000023', '23 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(26, 1, 'customer24@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 24', '0800000024', '24 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(27, 1, 'customer25@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 25', '0800000025', '25 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(28, 1, 'customer26@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 26', '0800000026', '26 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(29, 1, 'customer27@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 27', '0800000027', '27 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(30, 1, 'customer28@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 28', '0800000028', '28 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(31, 1, 'customer29@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 29', '0800000029', '29 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(32, 1, 'customer30@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 30', '0800000030', '30 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(33, 1, 'customer31@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 31', '0800000031', '31 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(34, 1, 'customer32@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 32', '0800000032', '32 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(35, 1, 'customer33@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 33', '0800000033', '33 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(36, 1, 'customer34@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 34', '0800000034', '34 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(37, 1, 'customer35@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 35', '0800000035', '35 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(38, 1, 'customer36@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 36', '0800000036', '36 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(39, 1, 'customer37@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 37', '0800000037', '37 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(40, 1, 'customer38@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 38', '0800000038', '38 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(41, 1, 'customer39@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 39', '0800000039', '39 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(42, 1, 'customer40@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 40', '0800000040', '40 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(43, 1, 'customer41@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 41', '0800000041', '41 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(44, 1, 'customer42@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 42', '0800000042', '42 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(45, 1, 'customer43@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 43', '0800000043', '43 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(46, 1, 'customer44@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 44', '0800000044', '44 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(47, 1, 'customer45@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 45', '0800000045', '45 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(48, 1, 'customer46@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 46', '0800000046', '46 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(49, 1, 'customer47@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 47', '0800000047', '47 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(50, 1, 'customer48@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 48', '0800000048', '48 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(51, 1, 'customer49@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 49', '0800000049', '49 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(52, 1, 'customer50@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 50', '0800000050', '50 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(53, 1, 'customer51@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 51', '0800000051', '51 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(54, 1, 'customer52@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 52', '0800000052', '52 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(55, 1, 'customer53@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 53', '0800000053', '53 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(56, 1, 'customer54@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 54', '0800000054', '54 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(57, 1, 'customer55@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 55', '0800000055', '55 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(58, 1, 'customer56@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 56', '0800000056', '56 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(59, 1, 'customer57@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 57', '0800000057', '57 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(60, 1, 'customer58@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 58', '0800000058', '58 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(61, 1, 'customer59@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 59', '0800000059', '59 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(62, 1, 'customer60@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 60', '0800000060', '60 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(63, 1, 'customer61@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 61', '0800000061', '61 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(64, 1, 'customer62@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 62', '0800000062', '62 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(65, 1, 'customer63@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 63', '0800000063', '63 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(66, 1, 'customer64@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 64', '0800000064', '64 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(67, 1, 'customer65@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 65', '0800000065', '65 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(68, 1, 'customer66@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 66', '0800000066', '66 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(69, 1, 'customer67@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 67', '0800000067', '67 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(70, 1, 'customer68@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 68', '0800000068', '68 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(71, 1, 'customer69@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 69', '0800000069', '69 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(72, 1, 'customer70@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 70', '0800000070', '70 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(73, 1, 'customer71@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 71', '0800000071', '71 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(74, 1, 'customer72@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 72', '0800000072', '72 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(75, 1, 'customer73@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 73', '0800000073', '73 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(76, 1, 'customer74@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 74', '0800000074', '74 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(77, 1, 'customer75@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 75', '0800000075', '75 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(78, 1, 'customer76@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 76', '0800000076', '76 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(79, 1, 'customer77@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 77', '0800000077', '77 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(80, 1, 'customer78@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 78', '0800000078', '78 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(81, 1, 'customer79@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 79', '0800000079', '79 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(82, 1, 'customer80@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 80', '0800000080', '80 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(83, 1, 'customer81@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 81', '0800000081', '81 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(84, 1, 'customer82@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 82', '0800000082', '82 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(85, 1, 'customer83@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 83', '0800000083', '83 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(86, 1, 'customer84@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 84', '0800000084', '84 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(87, 1, 'customer85@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 85', '0800000085', '85 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(88, 1, 'customer86@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 86', '0800000086', '86 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(89, 1, 'customer87@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 87', '0800000087', '87 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(90, 1, 'customer88@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 88', '0800000088', '88 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(91, 1, 'customer89@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 89', '0800000089', '89 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(92, 1, 'customer90@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 90', '0800000090', '90 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(93, 1, 'customer91@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 91', '0800000091', '91 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(94, 1, 'customer92@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 92', '0800000092', '92 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(95, 1, 'customer93@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 93', '0800000093', '93 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(96, 1, 'customer94@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 94', '0800000094', '94 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(97, 1, 'customer95@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 95', '0800000095', '95 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(98, 1, 'customer96@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 96', '0800000096', '96 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(99, 1, 'customer97@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 97', '0800000097', '97 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(100, 1, 'customer98@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 98', '0800000098', '98 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(101, 1, 'customer99@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 99', '0800000099', '99 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(102, 1, 'customer100@email.com', '$2b$12$LQv3c1yqBWVHxkd0LHAkCOYz6T0MQCgHfQrQrQrQrQrQrQrQrQrQr', 'Customer 100', '0800000100', '100 Sample Street, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(12, 1, 'customer10@email.com', '$2b$12$YOUR_HASH_HERE', 'วิภา น่ารัก', '0810101010', '10 ถนนพหลโยธิน กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(6, 1, 'customer4@email.com', '$2b$12$YOUR_HASH_HERE', 'อรุณี สดใส', '0844444444', '4 ถนนรัชดา กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(7, 1, 'customer5@email.com', '$2b$12$YOUR_HASH_HERE', 'ธนา ฉลาด', '0855555555', '5 ถนนเอกมัย กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(8, 1, 'customer6@email.com', '$2b$12$YOUR_HASH_HERE', 'สมศรี อบอุ่น', '0866666666', '6 ถนนทองหล่อ กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(9, 1, 'customer7@email.com', '$2b$12$YOUR_HASH_HERE', 'ประเสริฐ มั่นคง', '0877777777', '7 ถนนเพลินจิต กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(10, 1, 'customer8@email.com', '$2b$12$YOUR_HASH_HERE', 'มาลี หวานชื่น', '0888888888', '8 ถนนสีลม กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(11, 1, 'customer9@email.com', '$2b$12$YOUR_HASH_HERE', 'สมศักดิ์ เก่งกาจ', '0899999999', '9 ถนนสาทร กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(1, 2, 'admin@ebookmart.com', '$2b$12$SIF0YnnZ5PnbKlA3zYyoDuHAQtenbIxqlHFwMtRuitKsxPva7u9qy', 'Admin User', '0812345678', '123 Admin St, Bangkok', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(5, 1, 'customer3@email.com', '$2b$12$R9h/cIPz0gi.URNNX3kh2OPST9/PgBkqquzi.Ss7KIUgO2t0jWMUW', 'วิชัย มุ่งมั่น', '0833333333', '3 ถนนลาดพร้าว กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(4, 1, 'customer2@email.com', '$2b$12$olHMxwAPGDRn5RXiwurW4.vItu/YhyVoFh6FHrDr9ryxGazIsruw.', 'สมหญิง รักเรียน', '0822222222', '2 ถนนพระราม 9 กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(103, 1, 'user@example.com', '$2b$12$shP14pC8plFY6G9fMHo4Q.Ktx/N3.JvQdyOeOvoWrw.WKUi6Pn8mS', 'string', 'string', 'string', true, '2026-09-22 09:23:36.407962', '2026-09-22 09:23:36.407962'),
	(3, 1, 'customer1@email.com', '$2b$12$olHMxwAPGDRn5RXiwurW4.vItu/YhyVoFh6FHrDr9ryxGazIsruw.', 'สมชาย ใจดี', '0812345678', '123 ถนนทดสอบ กรุงเทพฯ', true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(104, 1, 'soso1@gmail.com', '$2b$12$QAuQbytL.M3Vitwe9VNf3uYQd5azIy/USp0crx9BB1nrk.3N5Zaam', 'มรกต สมพง', '0805253369', NULL, true, '2026-09-27 03:40:10.241507', '2026-09-27 03:40:10.241507'),
	(105, 1, 'wave@gmail.vom', '$2b$12$2tBxRsaY26KoAyBtDUfW5u1/RkCcJ/EnSaazeuPpo0x3hE1nZ1hUS', 'นายเวฟ', '0957980405', NULL, true, '2026-09-27 06:55:31.935801', '2026-09-27 06:55:31.935801');


--
-- Data for Name: carts; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."carts" ("id", "user_id", "status", "created_at", "updated_at") VALUES
	(2, 4, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(3, 5, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(4, 6, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(5, 7, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(6, 8, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(7, 9, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(8, 10, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(9, 11, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(10, 12, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(11, 13, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(12, 14, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(13, 15, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(14, 16, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(15, 17, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(16, 18, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(17, 19, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(18, 20, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(19, 21, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(20, 22, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(21, 23, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(22, 24, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(23, 25, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(24, 26, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(25, 27, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(26, 28, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(27, 29, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(28, 30, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(29, 31, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(30, 32, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(31, 33, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(32, 34, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(33, 35, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(34, 36, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(35, 37, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(36, 38, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(37, 39, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(38, 40, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(39, 41, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(40, 42, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(41, 43, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(42, 44, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(43, 45, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(44, 46, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(45, 47, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(46, 48, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(47, 49, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(48, 50, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(49, 51, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(50, 52, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(51, 53, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(52, 54, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(53, 55, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(54, 56, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(55, 57, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(56, 58, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(57, 59, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(58, 60, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(59, 61, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(60, 62, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(61, 63, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(62, 64, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(63, 65, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(64, 66, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(65, 67, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(66, 68, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(67, 69, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(68, 70, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(69, 71, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(70, 72, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(71, 73, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(72, 74, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(73, 75, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(74, 76, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(75, 77, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(76, 78, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(77, 79, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(78, 80, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(79, 81, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(80, 82, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(81, 83, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(82, 84, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(83, 85, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(84, 86, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(85, 87, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(86, 88, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(87, 89, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(88, 90, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(89, 91, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(90, 92, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(91, 93, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(92, 94, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(93, 95, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(94, 96, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(95, 97, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(96, 98, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(97, 99, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(98, 100, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(99, 101, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(100, 102, 'active', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(101, 103, 'active', '2026-09-22 09:23:36.584518', '2026-09-22 09:23:36.584518'),
	(1, 3, 'converted', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(102, 3, 'converted', '2026-09-23 13:12:12.192219', '2026-09-23 13:12:12.192219'),
	(103, 3, 'converted', '2026-09-24 06:22:32.100688', '2026-09-24 06:22:32.100688'),
	(104, 3, 'converted', '2026-09-24 06:36:08.443209', '2026-09-24 06:36:08.443209'),
	(105, 3, 'converted', '2026-09-24 06:40:30.945864', '2026-09-24 06:40:30.945864'),
	(106, 3, 'converted', '2026-09-24 06:44:26.87296', '2026-09-24 06:44:26.87296'),
	(107, 3, 'converted', '2026-09-24 06:47:26.370989', '2026-09-24 06:47:26.370989'),
	(108, 1, 'active', '2026-09-24 20:03:12.4638', '2026-09-24 20:03:12.4638'),
	(109, 104, 'active', '2026-09-27 03:40:10.467033', '2026-09-27 03:40:10.467033'),
	(110, 105, 'active', '2026-09-27 06:55:32.580928', '2026-09-27 06:55:32.580928');


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."categories" ("id", "name", "description", "is_active", "created_at") VALUES
	(1, 'นิยาย', 'นิยายทั่วไปและนิยายแปล', true, '2026-09-22 04:47:53.158015'),
	(2, 'พัฒนาตนเอง', 'หนังสือพัฒนาตนเองและสร้างแรงบันดาลใจ', true, '2026-09-22 04:47:53.158015'),
	(3, 'ธุรกิจ', 'หนังสือเกี่ยวกับการทำธุรกิจและการเงิน', true, '2026-09-22 04:47:53.158015'),
	(4, 'เทคโนโลยี', 'หนังสือเกี่ยวกับเทคโนโลยีและโปรแกรม', true, '2026-09-22 04:47:53.158015'),
	(5, 'วิทยาศาสตร์', 'หนังสือวิทยาศาสตร์และธรรมชาติ', true, '2026-09-22 04:47:53.158015'),
	(6, 'ประวัติศาสตร์', 'หนังสือประวัติศาสตร์และอารยธรรม', true, '2026-09-22 04:47:53.158015'),
	(7, 'อาหาร', 'หนังสือสอนทำอาหารและสูตรอาหาร', true, '2026-09-22 04:47:53.158015'),
	(8, 'สุขภาพ', 'หนังสือเกี่ยวกับสุขภาพและการออกกำลังกาย', true, '2026-09-22 04:47:53.158015'),
	(9, 'เด็กและเยาวชน', 'หนังสือสำหรับเด็กและเยาวชน', true, '2026-09-22 04:47:53.158015'),
	(10, 'จิตวิทยา', 'หนังสือจิตวิทยาและการเข้าใจตนเอง', true, '2026-09-22 04:47:53.158015'),
	(11, 'หนังสือการ์ตูน', 'หนังสือการ์ตูน', true, '2026-09-26 23:48:32.159806'),
	(12, 'นวนิยาย', 'นิยาย', true, '2026-09-26 23:48:48.255351'),
	(13, 'วิชาการ', 'วิชาการ', true, '2026-09-26 23:53:47.368295');


--
-- Data for Name: ebooks; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."ebooks" ("id", "category_id", "author_id", "title", "description", "price", "cover_url", "download_url", "stock", "is_active", "created_at", "updated_at") VALUES
	(1, 1, 1, 'รักในสายฝน', 'นิยายรักโรแมนติกในกรุงเทพฯ', 199.00, 'https://example.com/covers/rain.jpg', 'https://example.com/files/rain.pdf', 50, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(2, 1, 1, 'คืนเดือนมืด', 'นิยายลึกลับสอบสวน', 249.00, 'https://example.com/covers/dark.jpg', 'https://example.com/files/dark.pdf', 30, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(3, 1, 1, 'เส้นทางสู่ดวงดาว', 'นิยายผจญภัยในอวกาศ', 299.00, 'https://example.com/covers/stars.jpg', 'https://example.com/files/stars.pdf', 25, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(31, 1, 1, 'เงาจันทร์', 'นิยายรักย้อนยุค', 229.00, 'https://example.com/covers/moon.jpg', 'https://example.com/files/moon.pdf', 35, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(32, 2, 2, 'ผู้นำในตัวเอง', 'พัฒนาความเป็นผู้นำ', 329.00, 'https://example.com/covers/leader.jpg', 'https://example.com/files/leader.pdf', 50, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(5, 2, 2, 'พลังแห่งปัจจุบัน', 'การมีชีวิตอยู่ในปัจจุบัน', 249.00, 'https://example.com/covers/now.jpg', 'https://example.com/files/now.pdf', 80, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(7, 3, 3, 'เริ่มต้นธุรกิจ 101', 'คู่มือสำหรับผู้ประกอบการใหม่', 399.00, 'https://example.com/covers/biz101.jpg', 'https://example.com/files/biz101.pdf', 45, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(6, 2, 2, 'คิดแบบยิว', 'เคล็ดลับความสำเร็จของชาวยิว', 199.00, 'https://example.com/covers/jewish.jpg', 'https://example.com/files/jewish.pdf', 60, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(8, 3, 3, 'การเงินสำหรับทุกคน', 'จัดการเงินส่วนบุคคล', 249.00, 'https://example.com/covers/finance.jpg', 'https://example.com/files/finance.pdf', 70, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(9, 3, 3, 'การตลาดดิจิทัล', 'กลยุทธ์การตลาดออนไลน์', 349.00, 'https://example.com/covers/digital.jpg', 'https://example.com/files/digital.pdf', 55, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(10, 4, 4, 'Python สำหรับทุกคน', 'เรียนรู้ Python จากศูนย์', 499.00, 'https://example.com/covers/python.jpg', 'https://example.com/files/python.pdf', 120, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(11, 4, 4, 'AI และ Machine Learning', 'พื้นฐานปัญญาประดิษฐ์', 599.00, 'https://example.com/covers/ai.jpg', 'https://example.com/files/ai.pdf', 90, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(12, 4, 4, 'Web Development 2026', 'พัฒนาเว็บไซต์สมัยใหม่', 449.00, 'https://example.com/covers/web.jpg', 'https://example.com/files/web.pdf', 75, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(13, 5, 5, 'จักรวาลและกาแล็กซี', 'สำรวจอวกาศ', 349.00, 'https://example.com/covers/universe.jpg', 'https://example.com/files/universe.pdf', 40, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(14, 5, 5, 'ชีววิทยาโมเลกุล', 'พื้นฐานชีวิตระดับโมเลกุล', 449.00, 'https://example.com/covers/bio.jpg', 'https://example.com/files/bio.pdf', 35, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(15, 5, 5, 'ฟิสิกส์ควอนตัม', 'เข้าใจโลกควอนตัม', 399.00, 'https://example.com/covers/quantum.jpg', 'https://example.com/files/quantum.pdf', 30, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(17, 6, 6, 'สงครามโลกครั้งที่ 2', 'เหตุการณ์สำคัญในประวัติศาสตร์', 349.00, 'https://example.com/covers/ww2.jpg', 'https://example.com/files/ww2.pdf', 45, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(18, 6, 6, 'อารยธรรมอียิปต์', 'สำรวจอียิปต์โบราณ', 279.00, 'https://example.com/covers/egypt.jpg', 'https://example.com/files/egypt.pdf', 40, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(19, 7, 7, 'สูตรอาหารไทย 100 เมนู', 'รวมสูตรอาหารไทยยอดนิยม', 199.00, 'https://example.com/covers/thaifood.jpg', 'https://example.com/files/thaifood.pdf', 85, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(20, 7, 7, 'เบเกอรี่สำหรับมือใหม่', 'สอนทำเบเกอรี่ง่ายๆ', 249.00, 'https://example.com/covers/bakery.jpg', 'https://example.com/files/bakery.pdf', 65, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(21, 7, 7, 'อาหารญี่ปุ่น', 'สูตรอาหารญี่ปุ่นแท้', 299.00, 'https://example.com/covers/japanese.jpg', 'https://example.com/files/japanese.pdf', 55, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(22, 8, 8, 'อาหารเพื่อสุขภาพ', 'โภชนาการสำหรับสุขภาพดี', 249.00, 'https://example.com/covers/healthy.jpg', 'https://example.com/files/healthy.pdf', 95, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(23, 8, 8, 'ออกกำลังกายที่บ้าน', 'ฟิตเนสโดยไม่ต้องไปยิม', 199.00, 'https://example.com/covers/home.jpg', 'https://example.com/files/home.pdf', 110, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(24, 8, 8, 'โยคะสำหรับทุกคน', 'เริ่มต้นเล่นโยคะ', 229.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/dba28d579eda85affbfc2f9ed97e02f4.jpg', 'https://example.com/files/yoga.pdf', 80, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(25, 9, 9, 'นิทานก่อนนอน', 'นิทานสำหรับเด็ก 3-6 ปี', 149.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/483b0df82c9a59e27e835dbf87fa5ea8.jpg', 'https://example.com/files/bedtime.pdf', 150, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(27, 9, 9, 'วิทยาศาสตร์สำหรับเด็ก', 'เรียนรู้วิทยาศาสตร์อย่างสนุก', 179.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/4aad48d149b9176ad12ca909e3627b6c.jpg', 'https://example.com/files/kidsci.pdf', 100, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(28, 10, 10, 'เข้าใจตนเอง', 'จิตวิทยาการเข้าใจตนเอง', 279.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/3201e3ab99e16a172557b8c226e74060.jpg', 'https://example.com/files/self.pdf', 70, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(29, 10, 10, 'ความสัมพันธ์ที่ดี', 'จิตวิทยาความสัมพันธ์', 249.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/7898f2af564a83b2463033cdb62fef6c.jpg', 'https://example.com/files/relation.pdf', 60, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(33, 3, 3, 'ลงทุนหุ้นสำหรับมือใหม่', 'เริ่มต้นลงทุน', 399.00, 'https://example.com/covers/stock.jpg', 'https://example.com/files/stock.pdf', 65, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(34, 4, 4, 'Data Science', 'วิทยาศาสตร์ข้อมูล', 549.00, 'https://example.com/covers/datasci.jpg', 'https://example.com/files/datasci.pdf', 80, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(35, 5, 5, 'วิวัฒนาการ', 'ทฤษฎีวิวัฒนาการ', 329.00, 'https://example.com/covers/evolution.jpg', 'https://example.com/files/evolution.pdf', 40, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(36, 6, 6, 'รัตนโกสินทร์', 'ประวัติศาสตร์รัตนโกสินทร์', 349.00, 'https://example.com/covers/rattana.jpg', 'https://example.com/files/rattana.pdf', 55, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(37, 7, 7, 'อาหารจีน', 'สูตรอาหารจีน', 279.00, 'https://example.com/covers/chinese.jpg', 'https://example.com/files/chinese.pdf', 50, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(38, 8, 8, 'นอนหลับให้สนิท', 'เทคนิคการนอนหลับ', 199.00, 'https://example.com/covers/sleep.jpg', 'https://example.com/files/sleep.pdf', 90, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(39, 9, 9, 'ไดโนเสาร์', 'หนังสือภาพไดโนเสาร์', 159.00, 'https://example.com/covers/dino.jpg', 'https://example.com/files/dino.pdf', 120, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(40, 10, 10, 'จิตวิทยาเชิงบวก', 'สร้างชีวิตบวก', 259.00, 'https://example.com/covers/positive.jpg', 'https://example.com/files/positive.pdf', 75, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(41, 1, 1, 'รักสุดท้าย', 'นิยายรักดราม่า', 219.00, 'https://example.com/covers/last.jpg', 'https://example.com/files/last.pdf', 40, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(42, 2, 2, 'เวลาไม่เคยรอใคร', 'จัดการเวลาอย่างมีประสิทธิภาพ', 269.00, 'https://example.com/covers/time.jpg', 'https://example.com/files/time.pdf', 85, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(43, 3, 3, 'เศรษฐศาสตร์สำหรับทุกคน', 'เข้าใจเศรษฐกิจ', 299.00, 'https://example.com/covers/econ.jpg', 'https://example.com/files/econ.pdf', 70, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(44, 4, 4, 'Blockchain', 'เทคโนโลยีบล็อกเชน', 499.00, 'https://example.com/covers/blockchain.jpg', 'https://example.com/files/blockchain.pdf', 60, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(45, 5, 5, 'เคมีในชีวิต', 'เคมีรอบตัวเรา', 279.00, 'https://example.com/covers/chem.jpg', 'https://example.com/files/chem.pdf', 45, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(46, 1, 1, 'ฤดูร้อนนั้น', 'นิยายรักวัยรุ่น', 189.00, 'https://example.com/covers/summer.jpg', 'https://example.com/files/summer.pdf', 55, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(47, 2, 2, 'ความสุขภายใน', 'ค้นหาความสุขจากภายใน', 239.00, 'https://example.com/covers/inner.jpg', 'https://example.com/files/inner.pdf', 95, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(48, 3, 3, 'อสังหาริมทรัพย์', 'ลงทุนอสังหา', 449.00, 'https://example.com/covers/property.jpg', 'https://example.com/files/property.pdf', 50, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(49, 4, 4, 'Cybersecurity', 'ความปลอดภัยไซเบอร์', 599.00, 'https://example.com/covers/cyber.jpg', 'https://example.com/files/cyber.pdf', 70, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(50, 5, 5, 'ดาราศาสตร์', 'ดูดาวและจักรวาล', 349.00, 'https://example.com/covers/astro.jpg', 'https://example.com/files/astro.pdf', 35, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(54, 12, 11, 'รักที่มองไม่เห็นด้วยตา กับเธอในค่ำคืนที่แสนจะเลือนลาง', 'C++', 70.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/1a0d8493cec71c39c70245f99ac40b55.jpg', 'https://drive.google.com/file/d/1GeBfymmUoi0p4L4ei8GT2WC3w18djrXr/view?usp=sharing', 50, true, '2026-09-24 21:58:05.975899', '2026-09-24 21:58:05.975899'),
	(53, 1, 1, 'คู่มือการเขียนโปรแกรม Python', 'หนังสือสอนเขียนโปรแกรมตั้งแต่เริ่มต้น', 250.00, 'https://example.com/cover.jpg', 'https://example.com/book.pdf', 50, false, '2026-09-24 20:48:48.889129', '2026-09-24 20:48:48.889129'),
	(52, 1, 1, 'คู่มือการเขียนโปรแกรม Python', 'หนังสือสอนเขียนโปรแกรมตั้งแต่เริ่มต้น', 250.00, 'https://example.com/cover.jpg', 'https://example.com/book.pdf', 50, false, '2026-09-24 20:46:42.536271', '2026-09-24 20:46:42.536271'),
	(4, 2, 2, '7 นิสัยสู่ความสำเร็จ', 'คู่มือพัฒนาตนเอง', 299.00, 'https://example.com/covers/7habits.jpg', 'https://example.com/files/7habits.pdf', 100, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(16, 6, 6, 'อยุธยาโบราณ', 'ประวัติศาสตร์อาณาจักรอยุธยา', 299.00, 'https://example.com/covers/ayutthaya.jpg', 'https://example.com/files/ayutthaya.pdf', 50, false, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(26, 9, 9, 'การผจญภัยของน้องแมว', 'นิทานภาพสำหรับเด็ก', 129.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/98617b2c0fc91a083406e4a7fda4b825.jpg', 'https://example.com/files/cat.pdf', 130, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(30, 10, 10, 'จัดการความเครียด', 'เทคนิคจัดการความเครียด', 229.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/4ac9217881f846abacaec2989a4ce186.jpg', 'https://example.com/files/stress.pdf', 85, true, '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(55, 13, 11, 'Calculus2', 'ซื้อนะครับถ้าคุณอยากผ่านCalculus2', 300.00, 'https://lapzffbungbrwonfjems.supabase.co/storage/v1/object/public/ebook-covers/9d463273083ed60e7b8415d3ed3634cc.jpg', 'https://drive.google.com/file/d/1t4by6-tNYk7sdZHajlUcE11Tdj5EUTPA/view?usp=sharing', 100, true, '2026-09-26 23:55:17.083801', '2026-09-26 23:55:17.083801');


--
-- Data for Name: cart_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."cart_items" ("id", "cart_id", "ebook_id", "quantity", "price", "added_at") VALUES
	(2, 101, 10, 2, 499.00, '2026-09-23 12:46:36.848461');


--
-- Data for Name: orders; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."orders" ("id", "user_id", "total_amount", "status", "payment_slip_url", "notes", "created_at", "updated_at", "payment_method") VALUES
	(1, 3, 797.00, 'confirmed', 'https://example.com/slips/slip1.jpg', 'สั่งซื้อหนังสือพัฒนาตนเอง', '2026-08-23 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(2, 4, 1048.00, 'confirmed', 'https://example.com/slips/slip2.jpg', 'สั่งซื้อหนังสือเทคโนโลยี', '2026-08-25 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(3, 5, 598.00, 'confirmed', 'https://example.com/slips/slip3.jpg', 'สั่งซื้อนิยาย', '2026-08-28 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(4, 6, 1297.00, 'confirmed', 'https://example.com/slips/slip4.jpg', 'สั่งซื้อหนังสือธุรกิจ', '2026-08-31 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(5, 7, 448.00, 'confirmed', 'https://example.com/slips/slip5.jpg', 'สั่งซื้อหนังสืออาหาร', '2026-09-02 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(6, 8, 897.00, 'confirmed', 'https://example.com/slips/slip6.jpg', 'สั่งซื้อหนังสือสุขภาพ', '2026-09-04 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(7, 9, 299.00, 'confirmed', 'https://example.com/slips/slip7.jpg', 'สั่งซื้อหนังสือเด็ก', '2026-09-07 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(8, 10, 757.00, 'confirmed', 'https://example.com/slips/slip8.jpg', 'สั่งซื้อหนังสือจิตวิทยา', '2026-09-10 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(9, 11, 1198.00, 'confirmed', 'https://example.com/slips/slip9.jpg', 'สั่งซื้อหนังสือวิทยาศาสตร์', '2026-09-12 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(10, 12, 648.00, 'confirmed', 'https://example.com/slips/slip10.jpg', 'สั่งซื้อหนังสือประวัติศาสตร์', '2026-09-14 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(11, 13, 599.00, 'paid', 'https://example.com/slips/slip11.jpg', 'รอตรวจสอบสลิป', '2026-09-17 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(12, 14, 449.00, 'paid', 'https://example.com/slips/slip12.jpg', 'รอตรวจสอบสลิป', '2026-09-18 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(13, 15, 798.00, 'paid', 'https://example.com/slips/slip13.jpg', 'รอตรวจสอบสลิป', '2026-09-19 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(14, 16, 299.00, 'paid', 'https://example.com/slips/slip14.jpg', 'รอตรวจสอบสลิป', '2026-09-20 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(15, 17, 1098.00, 'paid', 'https://example.com/slips/slip15.jpg', 'รอตรวจสอบสลิป', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(16, 18, 549.00, 'paid', 'https://example.com/slips/slip16.jpg', 'รอตรวจสอบสลิป', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(17, 19, 399.00, 'paid', 'https://example.com/slips/slip17.jpg', 'รอตรวจสอบสลิป', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(18, 20, 899.00, 'paid', 'https://example.com/slips/slip18.jpg', 'รอตรวจสอบสลิป', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(19, 21, 649.00, 'paid', 'https://example.com/slips/slip19.jpg', 'รอตรวจสอบสลิป', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(20, 22, 1299.00, 'paid', 'https://example.com/slips/slip20.jpg', 'รอตรวจสอบสลิป', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(26, 28, 599.00, 'cancelled', NULL, 'ลูกค้าขอยกเลิก', '2026-09-15 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(27, 29, 449.00, 'cancelled', NULL, 'ลูกค้าขอยกเลิก', '2026-09-16 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(28, 30, 799.00, 'cancelled', NULL, 'ลูกค้าขอยกเลิก', '2026-09-17 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(29, 31, 299.00, 'cancelled', NULL, 'ลูกค้าขอยกเลิก', '2026-09-18 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(30, 32, 1099.00, 'cancelled', NULL, 'ลูกค้าขอยกเลิก', '2026-09-19 04:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(40, 1, 299.00, 'cancelled', 'https://example.com/slips/default.jpg', NULL, '2026-09-24 20:03:21.677829', '2026-09-24 20:03:21.677829', 'โอนเงิน'),
	(39, 3, 299.00, 'cancelled', 'https://example.com/slips/default.jpg', NULL, '2026-09-24 18:12:21.740475', '2026-09-24 18:12:21.740475', 'โอนเงิน'),
	(38, 3, 299.00, 'cancelled', 'https://example.com/slips/default.jpg', NULL, '2026-09-24 17:52:57.04362', '2026-09-24 17:52:57.04362', 'โอนเงิน'),
	(37, 3, 1644.00, 'cancelled', 'https://example.com/slips/default.jpg', NULL, '2026-09-24 17:32:10.311071', '2026-09-24 17:32:10.311071', NULL),
	(36, 3, 548.00, 'cancelled', 'https://example.com/slips/default.jpg', NULL, '2026-09-24 06:44:56.845245', '2026-09-24 06:44:56.845245', NULL),
	(35, 3, 249.00, 'cancelled', 'https://example.com/slips/default.jpg', NULL, '2026-09-24 06:40:50.5354', '2026-09-24 06:40:50.5354', NULL),
	(34, 3, 249.00, 'cancelled', 'https://example.com/slips/default.jpg', NULL, '2026-09-24 06:36:26.851799', '2026-09-24 06:36:26.851799', NULL),
	(33, 3, 498.00, 'cancelled', 'https://example.com/slips/default.jpg', NULL, '2026-09-24 06:35:33.315555', '2026-09-24 06:35:33.315555', NULL),
	(32, 3, 1497.00, 'cancelled', 'https://example.com/slip.jpg', NULL, '2026-09-23 13:19:54.494246', '2026-09-23 13:19:54.494246', NULL),
	(31, 3, 998.00, 'cancelled', 'string', NULL, '2026-09-22 09:43:47.255342', '2026-09-22 09:43:47.255342', NULL),
	(21, 23, 599.00, 'cancelled', NULL, 'รอการชำระเงิน', '2026-09-22 02:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(22, 24, 449.00, 'cancelled', NULL, 'รอการชำระเงิน', '2026-09-22 01:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(23, 25, 799.00, 'cancelled', NULL, 'รอการชำระเงิน', '2026-09-22 00:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(24, 26, 299.00, 'cancelled', NULL, 'รอการชำระเงิน', '2026-09-21 23:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(25, 27, 1099.00, 'cancelled', NULL, 'รอการชำระเงิน', '2026-09-21 22:47:53.158015', '2026-09-22 04:47:53.158015', NULL),
	(41, 1, 500.00, 'confirmed', 'https://example.com/slips/default.jpg', NULL, '2026-09-26 17:52:01.094341', '2026-09-26 17:52:01.094341', 'โอนเงิน'),
	(42, 1, 500.00, 'confirmed', 'https://example.com/slips/default.jpg', NULL, '2026-09-26 21:03:46.180992', '2026-09-26 21:03:46.180992', 'โอนเงิน'),
	(43, 1, 300.00, 'confirmed', 'https://example.com/slips/1790467447089.jpg', NULL, '2026-09-27 00:04:08.545253', '2026-09-27 00:04:08.545253', 'โอนเงิน'),
	(44, 3, 70.00, 'confirmed', 'https://example.com/slips/default.jpg', NULL, '2026-09-27 03:27:00.82649', '2026-09-27 03:27:00.82649', 'โอนเงิน'),
	(45, 104, 300.00, 'pending', 'https://example.com/slips/default.jpg', NULL, '2026-09-27 03:41:02.807363', '2026-09-27 03:41:02.807363', 'โอนเงิน'),
	(46, 105, 229.00, 'confirmed', 'https://example.com/slips/default.jpg', NULL, '2026-09-27 06:56:17.84438', '2026-09-27 06:56:17.84438', 'บัตรเครดิต');


--
-- Data for Name: order_items; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."order_items" ("id", "order_id", "ebook_id", "quantity", "price", "subtotal") VALUES
	(1, 1, 4, 1, 299.00, 299.00),
	(2, 1, 5, 1, 249.00, 249.00),
	(3, 1, 6, 1, 199.00, 199.00),
	(4, 2, 10, 1, 499.00, 499.00),
	(5, 2, 11, 1, 599.00, 599.00),
	(6, 3, 1, 1, 199.00, 199.00),
	(7, 3, 2, 1, 249.00, 249.00),
	(8, 4, 7, 1, 399.00, 399.00),
	(9, 4, 8, 1, 249.00, 249.00),
	(10, 4, 9, 1, 349.00, 349.00),
	(11, 5, 19, 1, 199.00, 199.00),
	(12, 5, 20, 1, 249.00, 249.00),
	(13, 6, 22, 1, 249.00, 249.00),
	(14, 6, 23, 1, 199.00, 199.00),
	(15, 6, 24, 1, 229.00, 229.00),
	(16, 7, 25, 1, 149.00, 149.00),
	(17, 8, 28, 1, 279.00, 279.00),
	(18, 8, 29, 1, 249.00, 249.00),
	(19, 8, 30, 1, 229.00, 229.00),
	(20, 9, 13, 1, 349.00, 349.00),
	(21, 9, 14, 1, 449.00, 449.00),
	(22, 10, 16, 1, 299.00, 299.00),
	(23, 10, 17, 1, 349.00, 349.00),
	(24, 31, 10, 2, 499.00, 998.00),
	(25, 32, 10, 3, 499.00, 1497.00),
	(26, 33, 2, 2, 249.00, 498.00),
	(27, 34, 2, 1, 249.00, 249.00),
	(28, 35, 2, 1, 249.00, 249.00),
	(29, 36, 2, 1, 249.00, 249.00),
	(30, 36, 3, 1, 299.00, 299.00),
	(31, 37, 3, 3, 299.00, 897.00),
	(32, 37, 2, 3, 249.00, 747.00),
	(33, 38, 3, 1, 299.00, 299.00),
	(34, 39, 3, 1, 299.00, 299.00),
	(35, 40, 3, 1, 299.00, 299.00),
	(36, 41, 54, 1, 500.00, 500.00),
	(37, 42, 54, 1, 500.00, 500.00),
	(38, 43, 55, 1, 300.00, 300.00),
	(39, 44, 54, 1, 70.00, 70.00),
	(40, 45, 55, 1, 300.00, 300.00),
	(41, 46, 24, 1, 229.00, 229.00);


--
-- Data for Name: download_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."download_links" ("id", "order_item_id", "token", "expires_at", "downloaded_at", "created_at") VALUES
	(1, 1, 'token_abc123_def456', '2026-09-29 04:47:53.158015', '2026-08-25 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(2, 2, 'token_ghi789_jkl012', '2026-09-29 04:47:53.158015', '2026-08-25 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(3, 3, 'token_mno345_pqr678', '2026-09-29 04:47:53.158015', '2026-08-25 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(4, 4, 'token_stu901_vwx234', '2026-09-29 04:47:53.158015', '2026-08-27 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(5, 5, 'token_yza567_bcd890', '2026-09-29 04:47:53.158015', '2026-08-27 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(6, 6, 'token_efg123_hij456', '2026-09-29 04:47:53.158015', '2026-08-30 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(7, 7, 'token_klm789_nop012', '2026-09-29 04:47:53.158015', '2026-08-30 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(8, 8, 'token_qrs345_tuv678', '2026-09-29 04:47:53.158015', '2026-09-02 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(9, 9, 'token_wxy901_abc234', '2026-09-29 04:47:53.158015', '2026-09-02 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(10, 10, 'token_def567_ghi890', '2026-09-29 04:47:53.158015', '2026-09-04 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(11, 11, 'token_jkl123_mno456', '2026-09-29 04:47:53.158015', '2026-09-04 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(12, 12, 'token_pqr789_stu012', '2026-09-29 04:47:53.158015', '2026-09-04 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(13, 13, 'token_vwx345_yza678', '2026-09-29 04:47:53.158015', '2026-09-09 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(14, 14, 'token_bcd901_efg234', '2026-09-29 04:47:53.158015', '2026-09-12 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(15, 15, 'token_hij567_klm890', '2026-09-29 04:47:53.158015', '2026-09-12 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(16, 16, 'token_nop123_qrs456', '2026-09-29 04:47:53.158015', '2026-09-14 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(17, 17, 'token_tuv789_wxy012', '2026-09-29 04:47:53.158015', '2026-09-16 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(18, 18, 'token_yza345_bcd678', '2026-09-29 04:47:53.158015', '2026-09-16 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(19, 19, 'token_efg901_hij234', '2026-09-29 04:47:53.158015', '2026-09-16 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(20, 20, 'token_klm567_nop890', '2026-09-29 04:47:53.158015', '2026-09-16 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(21, 36, 'token_uXTS5boWonwmX-Q89SHvRzWw-40mxpkMNdk3mGgpRxs', '2026-10-04 00:52:25.354084', NULL, '2026-09-26 17:52:25.25472'),
	(22, 37, 'token_lrcQ0qTKPk7wQAax79BXriRDSDEkYOYRnzId6vl29lA', '2026-10-04 04:04:16.751997', NULL, '2026-09-26 21:04:16.503176'),
	(23, 38, 'token_9UyrZ4bXI_HrL89V1w-ntlZlTflz8JJ2IkKZQ4Npprk', '2026-10-04 07:04:40.827126', '2026-09-27 07:04:51.52138', '2026-09-27 00:04:41.227182'),
	(24, 39, 'token_8d5vUwUolnjW5BXWyrQOwrY3uYBf3ykZJ7Ei1paLJME', '2026-10-04 03:27:50.498619', '2026-09-27 03:28:16.639494', '2026-09-27 03:27:50.588605'),
	(25, 41, 'token__SCka7bKbENg0Q_feZaxoqq702N-zg0umt9pSKS-fug', '2026-10-04 06:57:47.709836', '2026-09-27 06:57:58.251723', '2026-09-27 06:57:47.812636');


--
-- Data for Name: payments; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."payments" ("id", "order_id", "amount", "payment_method", "slip_url", "status", "paid_at", "created_at") VALUES
	(1, 1, 797.00, 'โอนเงิน', 'https://example.com/slips/slip1.jpg', 'verified', '2026-08-24 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(2, 2, 1048.00, 'โอนเงิน', 'https://example.com/slips/slip2.jpg', 'verified', '2026-08-26 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(3, 3, 598.00, 'QR Code', 'https://example.com/slips/slip3.jpg', 'verified', '2026-08-29 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(4, 4, 1297.00, 'โอนเงิน', 'https://example.com/slips/slip4.jpg', 'verified', '2026-09-01 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(5, 5, 448.00, 'QR Code', 'https://example.com/slips/slip5.jpg', 'verified', '2026-09-03 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(6, 6, 897.00, 'โอนเงิน', 'https://example.com/slips/slip6.jpg', 'verified', '2026-09-05 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(7, 7, 299.00, 'QR Code', 'https://example.com/slips/slip7.jpg', 'verified', '2026-09-08 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(8, 8, 757.00, 'โอนเงิน', 'https://example.com/slips/slip8.jpg', 'verified', '2026-09-11 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(9, 9, 1198.00, 'QR Code', 'https://example.com/slips/slip9.jpg', 'verified', '2026-09-13 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(10, 10, 648.00, 'โอนเงิน', 'https://example.com/slips/slip10.jpg', 'verified', '2026-09-15 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(11, 11, 599.00, 'QR Code', 'https://example.com/slips/slip11.jpg', 'pending', '2026-09-17 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(12, 12, 449.00, 'โอนเงิน', 'https://example.com/slips/slip12.jpg', 'pending', '2026-09-18 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(13, 13, 798.00, 'QR Code', 'https://example.com/slips/slip13.jpg', 'pending', '2026-09-19 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(14, 14, 299.00, 'โอนเงิน', 'https://example.com/slips/slip14.jpg', 'pending', '2026-09-20 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(15, 15, 1098.00, 'QR Code', 'https://example.com/slips/slip15.jpg', 'pending', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(16, 16, 549.00, 'โอนเงิน', 'https://example.com/slips/slip16.jpg', 'pending', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(17, 17, 399.00, 'QR Code', 'https://example.com/slips/slip17.jpg', 'pending', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(18, 18, 899.00, 'โอนเงิน', 'https://example.com/slips/slip18.jpg', 'pending', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(19, 19, 649.00, 'QR Code', 'https://example.com/slips/slip19.jpg', 'pending', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(20, 20, 1299.00, 'โอนเงิน', 'https://example.com/slips/slip20.jpg', 'pending', '2026-09-21 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(21, 31, 998.00, 'string', 'string', 'pending', NULL, '2026-09-22 09:43:47.57114'),
	(22, 32, 1497.00, 'โอนเงิน', 'https://example.com/slip.jpg', 'pending', NULL, '2026-09-23 13:19:54.808933'),
	(23, 33, 498.00, 'โอนเงิน', 'https://example.com/slips/default.jpg', 'pending', NULL, '2026-09-24 06:35:33.627674'),
	(24, 34, 249.00, 'โอนเงิน', 'https://example.com/slips/default.jpg', 'pending', NULL, '2026-09-24 06:36:27.154456'),
	(25, 35, 249.00, 'โอนเงิน', 'https://example.com/slips/default.jpg', 'pending', NULL, '2026-09-24 06:40:50.916962'),
	(26, 36, 548.00, 'โอนเงิน', 'https://example.com/slips/default.jpg', 'pending', NULL, '2026-09-24 06:44:57.274145'),
	(27, 37, 1644.00, 'โอนเงิน', 'https://example.com/slips/default.jpg', 'pending', NULL, '2026-09-24 17:32:10.929905');


--
-- Data for Name: reviews; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."reviews" ("id", "user_id", "ebook_id", "rating", "comment", "created_at", "updated_at") VALUES
	(1, 3, 4, 5, 'หนังสือดีมาก ได้ความรู้เยอะ', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(2, 3, 5, 4, 'เนื้อหาดี แต่บางจุดเข้าใจยาก', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(3, 3, 6, 5, 'ชอบมาก อ่านแล้วได้แรงบันดาลใจ', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(4, 4, 10, 5, 'สอน Python ได้เข้าใจง่ายมาก', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(5, 4, 11, 4, 'เนื้อหาครอบคลุม แต่ควรเพิ่มตัวอย่าง', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(6, 5, 1, 4, 'นิยายสนุก อ่านแล้วอิน', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(7, 5, 2, 5, 'พล็อตเรื่องน่าสนใจมาก', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(8, 6, 7, 5, 'คู่มือเริ่มต้นธุรกิจที่ดีมาก', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(9, 6, 8, 4, 'เนื้อหาดี แต่ควรอัปเดตข้อมูล', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(10, 6, 9, 4, 'ได้ความรู้การตลาดดิจิทัลเยอะ', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(11, 7, 19, 5, 'สูตรอาหารทำง่าย อร่อย', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(12, 7, 20, 4, 'เบเกอรี่ทำไม่ยากเลย', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(13, 8, 22, 5, 'อาหารสุขภาพทำง่าย', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(14, 8, 23, 4, 'ออกกำลังกายที่บ้านสะดวกมาก', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(15, 8, 24, 5, 'โยคะช่วยผ่อนคลายได้ดี', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(16, 9, 25, 5, 'นิทานน่ารัก ลูกชอบมาก', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(17, 10, 28, 4, 'เข้าใจตนเองมากขึ้น', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(18, 10, 29, 5, 'ความสัมพันธ์ดีขึ้นหลังอ่าน', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(19, 10, 30, 4, 'จัดการความเครียดได้ดีขึ้น', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(20, 11, 13, 5, 'จักรวาลน่าอัศจรรย์มาก', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(21, 11, 14, 4, 'ชีววิทยาโมเลกุลเข้าใจยากแต่ดี', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(22, 12, 16, 5, 'ประวัติศาสตร์อยุธยาสนุก', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(23, 12, 17, 4, 'สงครามโลกน่าติดตาม', '2026-09-22 04:47:53.158015', '2026-09-22 04:47:53.158015'),
	(24, 3, 10, 5, 'หนังสือดีมาก ได้ความรู้เยอะ แนะนำเลยครับ!', '2026-09-23 13:25:01.516627', '2026-09-23 13:25:01.516627'),
	(25, 3, 1, 4, 'หนังสือดีมาก ได้ความรู้เยอะ แนะนำเลยครับ!', '2026-09-23 13:25:30.873978', '2026-09-23 13:25:30.873978'),
	(26, 1, 54, 5, 'test', '2026-09-26 17:41:40.610348', '2026-09-26 17:41:40.610348');


--
-- Data for Name: wishlists; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO "public"."wishlists" ("id", "user_id", "ebook_id", "created_at") VALUES
	(2, 3, 15, '2026-09-22 04:47:53.158015'),
	(3, 4, 12, '2026-09-22 04:47:53.158015'),
	(4, 4, 18, '2026-09-22 04:47:53.158015'),
	(5, 5, 3, '2026-09-22 04:47:53.158015'),
	(6, 5, 31, '2026-09-22 04:47:53.158015'),
	(7, 6, 32, '2026-09-22 04:47:53.158015'),
	(8, 6, 33, '2026-09-22 04:47:53.158015'),
	(9, 7, 21, '2026-09-22 04:47:53.158015'),
	(10, 7, 34, '2026-09-22 04:47:53.158015'),
	(11, 8, 35, '2026-09-22 04:47:53.158015'),
	(12, 8, 36, '2026-09-22 04:47:53.158015'),
	(13, 9, 37, '2026-09-22 04:47:53.158015'),
	(14, 9, 38, '2026-09-22 04:47:53.158015'),
	(15, 10, 39, '2026-09-22 04:47:53.158015'),
	(16, 10, 40, '2026-09-22 04:47:53.158015'),
	(17, 11, 41, '2026-09-22 04:47:53.158015'),
	(18, 11, 42, '2026-09-22 04:47:53.158015'),
	(19, 12, 43, '2026-09-22 04:47:53.158015'),
	(20, 12, 44, '2026-09-22 04:47:53.158015'),
	(23, 3, 54, '2026-09-26 17:57:54.871589'),
	(24, 3, 53, '2026-09-26 19:19:09.324003'),
	(25, 1, 54, '2026-09-26 20:27:49.509239'),
	(26, 1, 55, '2026-09-27 15:11:01.996558');


--
-- Name: authors_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."authors_id_seq"', 11, true);


--
-- Name: cart_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."cart_items_id_seq"', 42, true);


--
-- Name: carts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."carts_id_seq"', 110, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."categories_id_seq"', 13, true);


--
-- Name: download_links_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."download_links_id_seq"', 25, true);


--
-- Name: ebooks_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."ebooks_id_seq"', 55, true);


--
-- Name: order_items_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."order_items_id_seq"', 41, true);


--
-- Name: orders_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."orders_id_seq"', 46, true);


--
-- Name: payments_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."payments_id_seq"', 27, true);


--
-- Name: reviews_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."reviews_id_seq"', 26, true);


--
-- Name: roles_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."roles_id_seq"', 2, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."users_id_seq"', 105, true);


--
-- Name: wishlists_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('"public"."wishlists_id_seq"', 26, true);


--
-- PostgreSQL database dump complete
--

-- \unrestrict JgGdgMm35i9q6ZdeoMe1UKS2Wz9l9oFlKiwScDyYqvJkVy344hVh1VFZuU66tic

RESET ALL;
