import { useState, useEffect } from 'react';
import AdminLayout from '../../components/admin/AdminLayout';
import api from '../../services/api';
import { Eye } from 'lucide-react';
import toast from 'react-hot-toast';

const ManageOrders = () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);

  useEffect(() => { loadOrders(); }, []);

  const loadOrders = async () => {
    try {
      const res = await api.get('/api/admin/orders');
      setOrders(res.data.data || []);
    } catch (error) {
      toast.error('ไม่สามารถโหลดข้อมูลได้');
    } finally {
      setLoading(false);
    }
  };

  const handleStatusChange = async (orderId, newStatus) => {
    try {
      await api.put(`/api/admin/orders/${orderId}`, { status: newStatus });
      toast.success('อัปเดตสถานะสำเร็จ');
      loadOrders();
    } catch (error) {
      toast.error('อัปเดตไม่สำเร็จ');
    }
  };

  const getStatusBadge = (status) => {
    const styles = {
      pending: 'bg-yellow-100 text-yellow-800',
      confirmed: 'bg-green-100 text-green-800',
      cancelled: 'bg-red-100 text-red-800',
    };
    const labels = { pending: 'รอชำระ', confirmed: 'ยืนยันแล้ว', cancelled: 'ยกเลิก' };
    return <span className={`px-2 py-1 rounded-full text-xs font-medium ${styles[status] || 'bg-gray-100'}`}>{labels[status] || status}</span>;
  };

  if (loading) return <AdminLayout><div className="flex items-center justify-center min-h-[50vh]"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div></AdminLayout>;

  return (
    <AdminLayout>
      <div className="space-y-6">
        <h1 className="text-2xl font-bold text-gray-900">จัดการคำสั่งซื้อ</h1>

        <div className="bg-white rounded-lg shadow overflow-hidden">
          <table className="w-full">
            <thead className="bg-gray-50">
              <tr>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">Order ID</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">ลูกค้า</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">ยอดรวม</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">สถานะ</th>
                <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">จัดการ</th>
              </tr>
            </thead>
            <tbody className="divide-y">
              {orders.map((order) => (
                <tr key={order.id} className="hover:bg-gray-50">
                  <td className="py-3 px-4 text-sm font-medium">#{order.id}</td>
                  <td className="py-3 px-4 text-sm">{order.users?.name || '-'}</td>
                  <td className="py-3 px-4 text-sm">฿{Number(order.total_amount).toLocaleString()}</td>
                  <td className="py-3 px-4 text-sm">{getStatusBadge(order.status)}</td>
                  <td className="py-3 px-4 text-sm">
                    <select value={order.status} onChange={(e) => handleStatusChange(order.id, e.target.value)} className="border rounded px-2 py-1 text-sm">
                      <option value="pending">รอชำระ</option>
                      <option value="confirmed">ยืนยันแล้ว</option>
                      <option value="cancelled">ยกเลิก</option>
                    </select>
                  </td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      </div>
    </AdminLayout>
  );
};

export default ManageOrders;