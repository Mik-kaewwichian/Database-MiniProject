import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Toaster } from 'react-hot-toast';
import { AuthProvider } from './context/AuthContext';
import { CartProvider } from './context/CartContext';
import Navbar from './components/common/Navbar';
import Footer from './components/common/Footer';
import Login from './pages/Login';
import Register from './pages/Register';
import Home from './pages/Home';
import Ebooks from './pages/Ebooks';
import EbookDetail from './pages/EbookDetail';
import Cart from './pages/Cart';
import Checkout from './pages/Checkout';
import OrderSuccess from './pages/OrderSuccess';
import OrderHistory from './pages/OrderHistory';
import Profile from './pages/Profile'; // เพิ่ม
import Wishlist from './pages/Wishlist'; // เพิ่ม
import MyReviews from './pages/MyReviews'; // เพิ่ม
import ProtectedRoute from './components/common/ProtectedRoute';

function App() {
  return (
    <AuthProvider>
      <CartProvider>
        <Router>
          <div className="min-h-screen flex flex-col">
            <Toaster position="top-right" />
            
            <Routes>
              <Route path="/login" element={<Login />} />
              <Route path="/register" element={<Register />} />
              <Route
                path="/*"
                element={
                  <>
                    <Navbar />
                    <main className="flex-grow">
                      <Routes>
                        <Route path="/" element={<Home />} />
                        <Route path="/ebooks" element={<Ebooks />} />
                        <Route path="/ebooks/:id" element={<EbookDetail />} />
                        
                        {/* Protected Routes */}
                        <Route path="/cart" element={<ProtectedRoute><Cart /></ProtectedRoute>} />
                        <Route path="/checkout" element={<ProtectedRoute><Checkout /></ProtectedRoute>} />
                        <Route path="/order-success" element={<ProtectedRoute><OrderSuccess /></ProtectedRoute>} />
                        <Route path="/orders" element={<ProtectedRoute><OrderHistory /></ProtectedRoute>} />
                        <Route path="/profile" element={<ProtectedRoute><Profile /></ProtectedRoute>} />
                        <Route path="/wishlist" element={<ProtectedRoute><Wishlist /></ProtectedRoute>} />
                        <Route path="/my-reviews" element={<ProtectedRoute><MyReviews /></ProtectedRoute>} />
                      </Routes>
                    </main>
                    <Footer />
                  </>
                }
              />
            </Routes>
          </div>
        </Router>
      </CartProvider>
    </AuthProvider>
  );
}

export default App;