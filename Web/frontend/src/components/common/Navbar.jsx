import { Link, useNavigate } from 'react-router-dom';
import { ShoppingCart, Heart, User, LogOut, BookOpen } from 'lucide-react';
import { useAuth } from '../../context/AuthContext';
import { useCart } from '../../context/CartContext';


const Navbar = () => {
  const { user, logout } = useAuth();
  const { cartCount } = useCart();
  const navigate = useNavigate();

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  return (
    <nav className="bg-white shadow-sm border-b border-gray-200">
      <div className="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div className="flex justify-between h-16">
          {/* Logo */}
          <div className="flex items-center">
            <Link to="/" className="flex items-center space-x-2">
              <BookOpen className="h-8 w-8 text-primary-600" />
              <span className="text-xl font-bold text-gray-900">E-Book Mart</span>
            </Link>
          </div>

          {/* Navigation */}
          <div className="flex items-center space-x-6">
            <Link to="/" className="text-gray-700 hover:text-primary-600 font-medium">
              หน้าแรก
            </Link>
            <Link to="/ebooks" className="text-gray-700 hover:text-primary-600 font-medium">
              หนังสือ
            </Link>
            <Link to="/my-reviews" className="text-gray-700 hover:text-primary-600 font-medium">
              รีวิวของฉัน
            </Link>
            {user ? (
              <>
                  <Link to="/wishlist" className="text-gray-700 hover:text-primary-600">
                    <Heart className="h-6 w-6" />
                  </Link>
                  <Link to="/cart" className="text-gray-700 hover:text-primary-600 relative">
                    <ShoppingCart className="h-6 w-6" />
                    {cartCount > 0 && (
                      <span className="absolute -top-2 -right-2 bg-red-500 text-white text-xs font-bold rounded-full h-5 w-5 flex items-center justify-center">
                        {cartCount}
                      </span>
                    )}
                  </Link>
                  <div className="flex items-center space-x-3">
                    <Link to="/profile" className="text-gray-700 hover:text-primary-600">
                      <User className="h-6 w-6" />
                    </Link>
                    <button
                      onClick={handleLogout}
                      className="text-gray-700 hover:text-red-600"
                    >
                      <LogOut className="h-6 w-6" />
                    </button>
                  </div>
                </>
              ) : (
                <div className="flex items-center space-x-3">
                  <Link
                    to="/login"
                    className="text-primary-600 hover:text-primary-700 font-medium"
                  >
                    เข้าสู่ระบบ
                  </Link>
                  <Link
                    to="/register"
                    className="bg-primary-600 text-white px-4 py-2 rounded-lg hover:bg-primary-700"
                  >
                    สมัครสมาชิก
                  </Link>
                </div>
              )}
          </div>
        </div>
      </div>
    </nav>
  );
};

export default Navbar;