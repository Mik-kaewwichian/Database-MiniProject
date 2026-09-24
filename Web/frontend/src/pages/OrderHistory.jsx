import { useState, useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { ordersAPI } from '../services/api';
import { Package, Clock, CheckCircle, XCircle } from 'lucide-react';

const OrderHistory = () => {
  const [orders, setOrders] = useState([]);
  const [loading, setLoading] = useState(true);
  const navigate = useNavigate();

  useEffect(() => {
    loadOrders();
  }, []);

  const loadOrders = async () => {
    try {
      const response = await ordersAPI.getAll();
      setOrders(response.data.data || []);
    } catch (error) {
      console.error('Failed to load orders:', error);
    } finally {
      setLoading(false);
    }
  };

  const getStatusIcon = (status) => {
    switch (status) {
      case 'pending': return <Clock className="h-5 w-5 text-yellow-500" />;
      case 'confirmed': return <CheckCircle className="h-5 w-5 text-green-500" />;
      case 'cancelled': return <XCircle className="h-5 w-5 text-red-500" />;
      default: return <Package className="h-5 w-5 text-gray-500" />;
    }
  };

  const getStatusText = (status) => {
    switch (status) {
      case 'pending': return 'รอการยืนยัน';
      case 'confirmed': return 'ยืนยันแล้ว';
      case 'cancelled': return 'ยกเลิก';
      default: return status;
    }
  };

  if (loading) {
    return (
      <div className="flex items-center justify-center min-h-[50vh]">
        <div className="animate-spin rounded-full h-12 w-12 border-b-2 border-primary-600"></div>
      </div>
    );
  }

  return (
    <div className="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <h1 className="text-3xl font-bold text-gray-900 mb-8">ประวัติคำสั่งซื้อ</h1>

      {orders.length === 0 ? (
        <div className="text-center py-12 bg-white rounded-lg shadow-md">
          <Package className="h-16 w-16 text-gray-400 mx-auto mb-4" />
          <h3 className="text-lg font-medium text-gray-900 mb-2">ยังไม่มีคำสั่งซื้อ</h3>
          <button
            onClick={() => navigate('/ebooks')}
            className="text-primary-600 hover:text-primary-700 font-medium"
          >
            เริ่มเลือกซื้อหนังสือ
          </button>
        </div>
      ) : (
        <div className="space-y-4">
          {orders.map((order) => (
            <div key={order.id} className="bg-white rounded-lg shadow-md p-6">
              <div className="flex flex-col sm:flex-row sm:items-center justify-between mb-4 pb-4 border-b">
                <div>
                  <p className="text-sm text-gray-500">หมายเลขคำสั่งซื้อ</p>
                  <p className="font-bold text-gray-900">#{order.id}</p>
                </div>
                <div className="mt-2 sm:mt-0 text-right">
                  <p className="text-sm text-gray-500">วันที่สั่งซื้อ</p>
                  <p className="text-gray-900">{new Date(order.created_at).toLocaleDateString('th-TH')}</p>
                </div>
                <div className="mt-2 sm:mt-0 flex items-center space-x-2">
                  {getStatusIcon(order.status)}
                  <span className="font-medium text-gray-900">{getStatusText(order.status)}</span>
                </div>
              </div>

              <div className="space-y-3 mb-4">
                {order.order_items?.map((item, idx) => (
                  <div key={idx} className="flex justify-between text-gray-700">
                    <span>{item.title} x {item.quantity}</span>
                    <span>฿{(item.price * item.quantity).toLocaleString()}</span>
                  </div>
                ))}
              </div>

              <div className="flex justify-between items-center pt-4 border-t">
                <span className="text-gray-600">วิธีชำระเงิน: {order.payment_method}</span>
                <span className="text-xl font-bold text-primary-600">
                  รวม: ฿{order.total_amount?.toLocaleString()}
                </span>
              </div>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default OrderHistory;