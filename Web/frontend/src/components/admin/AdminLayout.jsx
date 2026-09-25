import { Link, useLocation, useNavigate } from 'react-router-dom';
import { useAuth } from '../../context/AuthContext';
import {
  LayoutDashboard, BookOpen, ShoppingCart, Users, BarChart3, LogOut, Menu, X
} from 'lucide-react';
import { useState } from 'react';

const AdminLayout = ({ children }) => {
  const { user, logout } = useAuth();
  const location = useLocation();
  const navigate = useNavigate();
  const [sidebarOpen, setSidebarOpen] = useState(false);

  const handleLogout = () => {
    logout();
    navigate('/login');
  };

  const menuItems = [
    { path: '/admin', icon: LayoutDashboard, label: 'Dashboard' },
    { path: '/admin/ebooks', icon: BookOpen, label: 'จัดการหนังสือ' },
    { path: '/admin/categories', icon: BookOpen, label: 'จัดการหมวดหมู่' }, // จะสร้างในขั้นตอนถัดไป
    { path: '/admin/orders', icon: ShoppingCart, label: 'จัดการคำสั่งซื้อ' },
    { path: '/admin/users', icon: Users, label: 'จัดการผู้ใช้' },
    { path: '/admin/reports', icon: BarChart3, label: 'รายงาน' },
  ];

  const isActive = (path) => {
    if (path === '/admin') return location.pathname === '/admin';
    return location.pathname.startsWith(path);
  };

  return (
    <div className="min-h-screen bg-gray-100 flex">
      {/* Sidebar - Desktop */}
      <aside className="hidden md:flex w-64 bg-gray-900 text-white flex-col fixed h-full">
        <div className="p-6 border-b border-gray-800">
          <h1 className="text-xl font-bold">📚 E-Book Mart</h1>
          <p className="text-sm text-gray-400 mt-1">Admin Panel</p>
        </div>

        <nav className="flex-1 p-4 space-y-2 overflow-y-auto">
          {menuItems.map((item) => (
            <Link
              key={item.path}
              to={item.path}
              className={`flex items-center space-x-3 px-4 py-3 rounded-lg transition-colors ${
                isActive(item.path)
                  ? 'bg-blue-600 text-white'
                  : 'text-gray-300 hover:bg-gray-800'
              }`}
            >
              <item.icon className="h-5 w-5" />
              <span>{item.label}</span>
            </Link>
          ))}
        </nav>

        <div className="p-4 border-t border-gray-800">
          <div className="flex items-center space-x-3 mb-4">
            <div className="w-10 h-10 bg-blue-600 rounded-full flex items-center justify-center font-bold">
              {user?.name?.charAt(0) || 'A'}
            </div>
            <div>
              <p className="text-sm font-medium truncate">{user?.name}</p>
              <p className="text-xs text-gray-400">ผู้ดูแลระบบ</p>
            </div>
          </div>
          <button
            onClick={handleLogout}
            className="w-full flex items-center justify-center space-x-2 bg-red-600 text-white py-2 rounded-lg hover:bg-red-700 transition"
          >
            <LogOut className="h-4 w-4" />
            <span>ออกจากระบบ</span>
          </button>
        </div>
      </aside>

      {/* Mobile Sidebar Overlay */}
      {sidebarOpen && (
        <div className="md:hidden fixed inset-0 z-50 flex">
          <div className="fixed inset-0 bg-black bg-opacity-50" onClick={() => setSidebarOpen(false)} />
          <aside className="relative w-64 bg-gray-900 text-white flex-col flex h-full">
            <div className="p-4 flex justify-between items-center border-b border-gray-800">
              <h1 className="text-lg font-bold">📚 E-Book Mart</h1>
              <button onClick={() => setSidebarOpen(false)}><X className="h-6 w-6" /></button>
            </div>
            <nav className="flex-1 p-4 space-y-2 overflow-y-auto">
              {menuItems.map((item) => (
                <Link
                  key={item.path}
                  to={item.path}
                  onClick={() => setSidebarOpen(false)}
                  className={`flex items-center space-x-3 px-4 py-3 rounded-lg ${
                    isActive(item.path) ? 'bg-blue-600' : 'hover:bg-gray-800'
                  }`}
                >
                  <item.icon className="h-5 w-5" />
                  <span>{item.label}</span>
                </Link>
              ))}
            </nav>
          </aside>
        </div>
      )}

      {/* Main Content */}
      <div className="flex-1 md:ml-64 flex flex-col min-h-screen">
        {/* Top Bar */}
        <header className="bg-white shadow-sm border-b border-gray-200 px-6 py-4 flex items-center justify-between sticky top-0 z-40">
          <button onClick={() => setSidebarOpen(true)} className="md:hidden text-gray-600">
            <Menu className="h-6 w-6" />
          </button>
          <h2 className="text-xl font-semibold text-gray-900">
            {menuItems.find((item) => isActive(item.path))?.label || 'Admin'}
          </h2>
          <Link to="/" className="text-blue-600 hover:text-blue-700 text-sm font-medium">
            ← กลับหน้าร้าน
          </Link>
        </header>

        {/* Page Content */}
        <main className="flex-1 p-6 overflow-auto">
          {children}
        </main>
      </div>
    </div>
  );
};

export default AdminLayout;