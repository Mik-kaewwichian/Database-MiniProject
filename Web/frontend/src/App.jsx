import { BrowserRouter as Router, Routes, Route } from 'react-router-dom';
import { Toaster } from 'react-hot-toast';
import { AuthProvider } from './context/AuthContext';
import { CartProvider } from './context/CartContext'; // <-- เพิ่ม
import Navbar from './components/common/Navbar';
import Footer from './components/common/Footer';
import Login from './pages/Login';
import Register from './pages/Register';
import Home from './pages/Home';
import Ebooks from './pages/Ebooks';
import EbookDetail from './pages/EbookDetail';
import Cart from './pages/Cart'; // <-- เพิ่ม
import Checkout from './pages/Checkout'; // <-- เพิ่ม
import OrderSuccess from './pages/OrderSuccess'; // <-- เพิ่ม
import OrderHistory from './pages/OrderHistory'; // <-- เพิ่ม
import ProtectedRoute from './components/common/ProtectedRoute';

function App() {
  return (
    <AuthProvider>
      <CartProvider> {/* <-- ห่อด้วย CartProvider */}
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