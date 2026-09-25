import { useState, useEffect } from 'react';
import AdminLayout from '../../components/admin/AdminLayout';
import api from '../../services/api';
import { BarChart, Bar, XAxis, YAxis, CartesianGrid, Tooltip, ResponsiveContainer, PieChart, Pie, Cell } from 'recharts';
import { BookOpen, ShoppingCart, Users, DollarSign } from 'lucide-react';
import toast from 'react-hot-toast';

const Dashboard = () => {
  const [stats, setStats] = useState({ totalOrders: 0, totalRevenue: 0, totalUsers: 0, totalEbooks: 0 });
  const [salesData, setSalesData] = useState([]);
  const [categoryData, setCategoryData] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => { loadDashboardData(); }, []);

  const loadDashboardData = async () => {
    try {
      const [ordersRes, usersRes, ebooksRes, salesRes, categoryRes] = await Promise.all([
        api.get('/api/admin/orders').catch(() => ({ data: { data: [] } })),
        api.get('/api/admin/users').catch(() => ({ data: { data: [] } })),
        api.get('/api/admin/ebooks').catch(() => ({ data: { data: [] } })),
        api.get('/api/admin/reports/sales-by-time').catch(() => ({ data: { data: [] } })),
        api.get('/api/admin/reports/sales-by-category').catch(() => ({ data: { data: [] } })),
      ]);

      const orders = ordersRes.data.data || [];
      const users = usersRes.data.data || [];
      const ebooks = ebooksRes.data.data || [];
      const sales = salesRes.data.data || [];
      const categories = categoryRes.data.data || [];

      const totalRevenue = orders.reduce((sum, o) => sum + (o.total_amount || 0), 0);

      setStats({
        totalOrders: orders.length,
        totalRevenue,
        totalUsers: users.length,
        totalEbooks: ebooks.length,
      });

      setSalesData(sales.map(s => ({ month: s.month, sales: Number(s.total_sales) })).reverse());
      setCategoryData(categories.map(c => ({ name: c.category_name, value: Number(c.total_sales) })));
    } catch (error) {
      console.error('Failed to load dashboard:', error);
      toast.error('ไม่สามารถโหลดข้อมูล Dashboard ได้');
    } finally {
      setLoading(false);
    }
  };

  const COLORS = ['#2563eb', '#f59e0b', '#10b981', '#ef4444', '#8b5cf6'];

  if (loading) {
    return (
      <AdminLayout>
        <div className="flex items-center justify-center min-h-[50vh]">
          <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div>
        </div>
      </AdminLayout>
    );
  }

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div className="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
          <StatCard title="คำสั่งซื้อทั้งหมด" value={stats.totalOrders} icon={ShoppingCart} color="text-blue-600" bg="bg-blue-100" />
          <StatCard title="ยอดขายรวม" value={`฿${stats.totalRevenue.toLocaleString()}`} icon={DollarSign} color="text-green-600" bg="bg-green-100" />
          <StatCard title="จำนวนลูกค้า" value={stats.totalUsers} icon={Users} color="text-purple-600" bg="bg-purple-100" />
          <StatCard title="จำนวนหนังสือ" value={stats.totalEbooks} icon={BookOpen} color="text-orange-600" bg="bg-orange-100" />
        </div>

        <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
          <div className="bg-white rounded-lg shadow-md p-6">
            <h3 className="text-lg font-semibold text-gray-900 mb-4">ยอดขายรายเดือน</h3>
            <ResponsiveContainer width="100%" height={300}>
              <BarChart data={salesData}>
                <CartesianGrid strokeDasharray="3 3" />
                <XAxis dataKey="month" />
                <YAxis />
                <Tooltip formatter={(value) => `฿${Number(value).toLocaleString()}`} />
                <Bar dataKey="sales" fill="#2563eb" radius={[4, 4, 0, 0]} />
              </BarChart>
            </ResponsiveContainer>
          </div>

          <div className="bg-white rounded-lg shadow-md p-6">
            <h3 className="text-lg font-semibold text-gray-900 mb-4">ยอดขายตามหมวดหมู่</h3>
            <ResponsiveContainer width="100%" height={300}>
              <PieChart>
                <Pie data={categoryData} cx="50%" cy="50%" outerRadius={100} dataKey="value" label>
                  {categoryData.map((entry, index) => (
                    <Cell key={`cell-${index}`} fill={COLORS[index % COLORS.length]} />
                  ))}
                </Pie>
                <Tooltip formatter={(value) => `฿${Number(value).toLocaleString()}`} />
              </PieChart>
            </ResponsiveContainer>
          </div>
        </div>
      </div>
    </AdminLayout>
  );
};

const StatCard = ({ title, value, icon: Icon, color, bg }) => (
  <div className="bg-white rounded-lg shadow-md p-6 flex items-center justify-between">
    <div>
      <p className="text-sm text-gray-600">{title}</p>
      <p className="text-3xl font-bold text-gray-900 mt-2">{value}</p>
    </div>
    <div className={`p-3 rounded-full ${bg}`}>
      <Icon className={`h-8 w-8 ${color}`} />
    </div>
  </div>
);

export default Dashboard;