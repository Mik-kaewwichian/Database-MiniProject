import { Link } from 'react-router-dom';
import { ShoppingCart, Star } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useCart } from '../../context/CartContext'; // ✅ เพิ่มบรรทัดนี้
import toast from 'react-hot-toast';

const BookCard = ({ book }) => {
  const { user } = useAuth();
  const { addItem } = useCart(); // ✅ ใช้ addItem จาก CartContext

  const handleAddToCart = async (e) => {
    e.preventDefault();
    e.stopPropagation();

    if (!user) {
      toast.error('กรุณาเข้าสู่ระบบก่อนเพิ่มสินค้าลงตะกร้า');
      return;
    }

    // ✅ เรียก addItem จาก CartContext (จะ loadCart อัตโนมัติ)
    await addItem(book.id, 1);
  };

  return (
    <Link to={`/ebooks/${book.id}`} className="block group">
      <div className="bg-white rounded-lg shadow-md overflow-hidden hover:shadow-xl transition-shadow duration-300">
        {/* Cover Image */}
        <div className="relative h-64 bg-gray-200 overflow-hidden">
          <img
            src={book.cover_url || 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=300&h=400&fit=crop'}
            alt={book.title}
            className="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
            onError={(e) => {
              e.target.src = 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=300&h=400&fit=crop';
            }}
          />
          {book.stock === 0 && (
            <div className="absolute inset-0 bg-black bg-opacity-50 flex items-center justify-center">
              <span className="text-white font-bold text-lg">หมดสต็อก</span>
            </div>
          )}
        </div>

        {/* Content */}
        <div className="p-4">
          {/* Category */}
          <span className="text-xs text-primary-600 font-medium">
            {book.categories?.name || 'ไม่ระบุหมวดหมู่'}
          </span>

          {/* Title */}
          <h3 className="text-lg font-semibold text-gray-900 mt-1 line-clamp-2 group-hover:text-primary-600">
            {book.title}
          </h3>

          {/* Author */}
          <p className="text-sm text-gray-600 mt-1">
            โดย {book.authors?.name || 'ไม่ระบุผู้แต่ง'}
          </p>

          {/* Rating & Price */}
          <div className="flex items-center justify-between mt-3">
            <div className="flex items-center space-x-1">
              <Star className="h-4 w-4 text-yellow-400 fill-current" />
              <span className="text-sm font-medium text-gray-700">
                {book.average_rating || '0.0'}
              </span>
            </div>
            <span className="text-xl font-bold text-primary-600">
              ฿{book.price?.toLocaleString()}
            </span>
          </div>

          {/* Add to Cart Button */}
          <button
            onClick={handleAddToCart}
            disabled={book.stock === 0}
            className="w-full mt-3 flex items-center justify-center space-x-2 bg-primary-600 text-white py-2 px-4 rounded-lg hover:bg-primary-700 disabled:bg-gray-300 disabled:cursor-not-allowed transition-colors"
          >
            <ShoppingCart className="h-4 w-4" />
            <span>{book.stock === 0 ? 'หมดสต็อก' : 'เพิ่มลงตะกร้า'}</span>
          </button>
        </div>
      </div>
    </Link>
  );
};

export default BookCard;