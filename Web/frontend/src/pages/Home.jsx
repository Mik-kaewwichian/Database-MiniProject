import { useState, useEffect } from 'react';
import { Link } from 'react-router-dom';
import { ebooksAPI } from '../services/api';
import BookCard from '../components/book/BookCard';
import { BookOpen, TrendingUp, Users, Download } from 'lucide-react';

const Home = () => {
  const [featuredBooks, setFeaturedBooks] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    loadData();
  }, []);

  const loadData = async () => {
    try {
      const [booksRes, categoriesRes] = await Promise.all([
        ebooksAPI.getAll({ limit: 8 }),
        ebooksAPI.getCategories(),
      ]);
      setFeaturedBooks(booksRes.data.data);
      setCategories(categoriesRes.data.data);
    } catch (error) {
      console.error('Failed to load data:', error);
    } finally {
      setLoading(false);
    }
  };

  return (
    <div>
      {/* Hero Section */}
      <div className="bg-gradient-to-r from-primary-600 to-primary-800 text-white py-20">
        <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 text-center">
          <h1 className="text-5xl font-bold mb-4">
            ยินดีต้อนรับสู่ E-Book Mart
          </h1>
          <p className="text-xl mb-8">
            ร้านหนังสืออิเล็กทรอนิกส์ชั้นนำ รวมหนังสือคุณภาพจากนักเขียนชั้นนำ
          </p>
          <Link
            to="/ebooks"
            className="inline-block bg-white text-primary-600 px-8 py-3 rounded-lg font-semibold hover:bg-gray-100 transition-colors"
          >
            เลือกซื้อหนังสือ
          </Link>
        </div>
      </div>

      {/* Features */}
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
        <div className="grid grid-cols-1 md:grid-cols-3 gap-8 mb-12">
          <div className="bg-white p-6 rounded-lg shadow-md text-center">
            <BookOpen className="h-12 w-12 text-primary-600 mx-auto mb-4" />
            <h3 className="text-lg font-semibold mb-2">หนังสือหลากหลาย</h3>
            <p className="text-gray-600">หนังสือทุกหมวดหมู่ พร้อมให้อ่านทันที</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-md text-center">
            <Download className="h-12 w-12 text-secondary-600 mx-auto mb-4" />
            <h3 className="text-lg font-semibold mb-2">ดาวน์โหลดง่าย</h3>
            <p className="text-gray-600">ซื้อแล้วดาวน์โหลดได้ทันที ทุกที่ทุกเวลา</p>
          </div>
          <div className="bg-white p-6 rounded-lg shadow-md text-center">
            <Users className="h-12 w-12 text-green-600 mx-auto mb-4" />
            <h3 className="text-lg font-semibold mb-2">ราคาพิเศษ</h3>
            <p className="text-gray-600">ส่วนลดพิเศษสำหรับสมาชิก</p>
          </div>
        </div>

        {/* Categories */}
        <div className="mb-12">
          <h2 className="text-3xl font-bold text-gray-900 mb-6">หมวดหมู่หนังสือ</h2>
          <div className="grid grid-cols-2 md:grid-cols-5 gap-4">
            {categories.slice(0, 10).map((category) => (
              <Link
                key={category.id}
                to={`/ebooks?category=${category.id}`}
                className="bg-white p-4 rounded-lg shadow-md hover:shadow-lg transition-shadow text-center"
              >
                <h3 className="font-semibold text-gray-900">{category.name}</h3>
              </Link>
            ))}
          </div>
        </div>

        {/* Featured Books */}
        <div>
          <div className="flex items-center justify-between mb-6">
            <h2 className="text-3xl font-bold text-gray-900">หนังสือแนะนำ</h2>
            <Link to="/ebooks" className="text-primary-600 hover:text-primary-700 font-medium">
              ดูทั้งหมด →
            </Link>
          </div>

          {loading ? (
            <div className="flex items-center justify-center py-20">
              <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
            </div>
          ) : (
            <div className="grid grid-cols-1 sm:grid-cols-2 lg:grid-cols-4 gap-6">
              {featuredBooks.map((book) => (
                <BookCard key={book.id} book={book} />
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
};

export default Home;