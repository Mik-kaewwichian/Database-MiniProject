import { useState, useEffect } from 'react';
import AdminLayout from "../../components/admin/AdminLayout";
import api from '../../services/api';
import { Plus, Edit, Trash2, Search, X } from 'lucide-react';
import toast from 'react-hot-toast';

const ManageEbooks = () => {
  const [ebooks, setEbooks] = useState([]);
  const [authors, setAuthors] = useState([]);
  const [categories, setCategories] = useState([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [showModal, setShowModal] = useState(false);
  const [editEbook, setEditEbook] = useState(null);
  const [formData, setFormData] = useState({
    title: '', author_id: '', category_id: '', price: '', stock: '',
    description: '', cover_url: '', download_url: '', is_active: true,
  });

  useEffect(() => { loadData(); }, []);

  const loadData = async () => {
    try {
      const [ebooksRes, authorsRes, categoriesRes] = await Promise.all([
        api.get('/api/admin/ebooks'),
        api.get('/api/authors'),
        api.get('/api/categories'),
      ]);
      setEbooks(ebooksRes.data.data || []);
      setAuthors(authorsRes.data.data || []);
      setCategories(categoriesRes.data.data || []);
    } catch (error) {
      toast.error('ไม่สามารถโหลดข้อมูลได้');
    } finally {
      setLoading(false);
    }
  };

  const handleDelete = async (id) => {
    if (!confirm('คุณแน่ใจหรือว่าต้องการปิดการใช้งานหนังสือเล่มนี้?')) return;
    try {
      await api.delete(`/api/admin/ebooks/${id}`);
      toast.success('ดำเนินการสำเร็จ');
      loadData();
    } catch (error) {
      toast.error('ดำเนินการไม่สำเร็จ');
    }
  };

  const handleEdit = (ebook) => {
    setEditEbook(ebook);
    setFormData({
      title: ebook.title || '',
      author_id: ebook.author_id || ebook.authors?.id || '',
      category_id: ebook.category_id || ebook.categories?.id || '',
      price: ebook.price || '',
      stock: ebook.stock || '',
      description: ebook.description || '',
      cover_url: ebook.cover_url || '',
      download_url: ebook.download_url || '',
      is_active: ebook.is_active !== false,
    });
    setShowModal(true);
  };

  const handleAdd = () => {
    setEditEbook(null);
    setFormData({ title: '', author_id: '', category_id: '', price: '', stock: '', description: '', cover_url: '', download_url: '', is_active: true });
    setShowModal(true);
  };

  const handleSubmit = async (e) => {
    e.preventDefault();
    const payload = {
      ...formData,
      author_id: parseInt(formData.author_id),
      category_id: parseInt(formData.category_id),
      price: parseFloat(formData.price),
      stock: parseInt(formData.stock),
    };

    try {
      if (editEbook) {
        await api.put(`/api/admin/ebooks/${editEbook.id}`, payload);
        toast.success('อัปเดตหนังสือสำเร็จ');
      } else {
        await api.post('/api/admin/ebooks', payload);
        toast.success('สร้างหนังสือสำเร็จ');
      }
      setShowModal(false);
      loadData();
    } catch (error) {
      toast.error(error.response?.data?.detail || 'บันทึกไม่สำเร็จ');
    }
  };

  const handleChange = (e) => {
    const { name, value, type, checked } = e.target;
    setFormData({ ...formData, [name]: type === 'checkbox' ? checked : value });
  };

  const filteredEbooks = ebooks.filter((ebook) =>
    ebook.title?.toLowerCase().includes(search.toLowerCase()) ||
    ebook.authors?.name?.toLowerCase().includes(search.toLowerCase())
  );

  if (loading) return <AdminLayout><div className="flex items-center justify-center min-h-[50vh]"><div className="animate-spin rounded-full h-12 w-12 border-b-2 border-blue-600"></div></div></AdminLayout>;

  return (
    <AdminLayout>
      <div className="space-y-6">
        <div className="flex flex-col sm:flex-row justify-between items-start sm:items-center gap-4">
          <h1 className="text-2xl font-bold text-gray-900">จัดการหนังสือ</h1>
          <button onClick={handleAdd} className="flex items-center space-x-2 bg-blue-600 text-white px-4 py-2 rounded-lg hover:bg-blue-700">
            <Plus className="h-5 w-5" /><span>เพิ่มหนังสือ</span>
          </button>
        </div>

        <div className="relative">
          <Search className="absolute left-3 top-1/2 transform -translate-y-1/2 h-5 w-5 text-gray-400" />
          <input type="text" value={search} onChange={(e) => setSearch(e.target.value)} placeholder="ค้นหาหนังสือ..." className="w-full pl-10 pr-4 py-3 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
        </div>

        <div className="bg-white rounded-lg shadow-md overflow-hidden">
          <div className="overflow-x-auto">
            <table className="w-full">
              <thead className="bg-gray-50">
                <tr>
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">ชื่อหนังสือ</th>
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">ผู้แต่ง</th>
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">หมวดหมู่</th>
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">ราคา</th>
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">สต็อก</th>
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">สถานะ</th>
                  <th className="text-left py-3 px-4 text-sm font-medium text-gray-600">จัดการ</th>
                </tr>
              </thead>
              <tbody className="divide-y divide-gray-200">
                {filteredEbooks.map((ebook) => (
                  <tr key={ebook.id} className="hover:bg-gray-50">
                    <td className="py-3 px-4 text-sm text-gray-900 font-medium">{ebook.title}</td>
                    <td className="py-3 px-4 text-sm text-gray-600">{ebook.authors?.name || '-'}</td>
                    <td className="py-3 px-4 text-sm text-gray-600">{ebook.categories?.name || '-'}</td>
                    <td className="py-3 px-4 text-sm text-gray-900">฿{Number(ebook.price).toLocaleString()}</td>
                    <td className="py-3 px-4 text-sm">
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${ebook.stock > 0 ? 'bg-green-100 text-green-800' : 'bg-red-100 text-red-800'}`}>{ebook.stock}</span>
                    </td>
                    <td className="py-3 px-4 text-sm">
                      <span className={`px-2 py-1 rounded-full text-xs font-medium ${ebook.is_active !== false ? 'bg-blue-100 text-blue-800' : 'bg-gray-100 text-gray-600'}`}>
                        {ebook.is_active !== false ? 'เปิดใช้งาน' : 'ปิดใช้งาน'}
                      </span>
                    </td>
                    <td className="py-3 px-4 text-sm">
                      <div className="flex space-x-2">
                        <button onClick={() => handleEdit(ebook)} className="text-blue-600 hover:text-blue-800"><Edit className="h-4 w-4" /></button>
                        <button onClick={() => handleDelete(ebook.id)} className="text-red-600 hover:text-red-800"><Trash2 className="h-4 w-4" /></button>
                      </div>
                    </td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        </div>

        {showModal && (
          <div className="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50 p-4">
            <div className="bg-white rounded-lg shadow-xl max-w-2xl w-full max-h-[90vh] overflow-y-auto">
              <div className="flex items-center justify-between p-6 border-b">
                <h2 className="text-xl font-bold text-gray-900">{editEbook ? 'แก้ไขหนังสือ' : 'เพิ่มหนังสือใหม่'}</h2>
                <button onClick={() => setShowModal(false)} className="text-gray-400 hover:text-gray-600"><X className="h-6 w-6" /></button>
              </div>
              <form onSubmit={handleSubmit} className="p-6 space-y-4">
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">ชื่อหนังสือ *</label>
                  <input type="text" name="title" value={formData.title} onChange={handleChange} required className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">ผู้แต่ง *</label>
                    <select name="author_id" value={formData.author_id} onChange={handleChange} required className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                      <option value="">เลือกผู้แต่ง</option>
                      {authors.map((a) => <option key={a.id} value={a.id}>{a.name}</option>)}
                    </select>
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">หมวดหมู่ *</label>
                    <select name="category_id" value={formData.category_id} onChange={handleChange} required className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500">
                      <option value="">เลือกหมวดหมู่</option>
                      {categories.map((c) => <option key={c.id} value={c.id}>{c.name}</option>)}
                    </select>
                  </div>
                </div>
                <div className="grid grid-cols-1 md:grid-cols-2 gap-4">
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">ราคา (บาท) *</label>
                    <input type="number" name="price" value={formData.price} onChange={handleChange} required min="0" step="0.01" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                  </div>
                  <div>
                    <label className="block text-sm font-medium text-gray-700 mb-2">จำนวนสต็อก *</label>
                    <input type="number" name="stock" value={formData.stock} onChange={handleChange} required min="0" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                  </div>
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">URL รูปปก</label>
                  <input type="url" name="cover_url" value={formData.cover_url} onChange={handleChange} className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">URL ไฟล์ดาวน์โหลด</label>
                  <input type="url" name="download_url" value={formData.download_url} onChange={handleChange} className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                </div>
                <div>
                  <label className="block text-sm font-medium text-gray-700 mb-2">คำอธิบาย</label>
                  <textarea name="description" value={formData.description} onChange={handleChange} rows="3" className="w-full px-4 py-2 border border-gray-300 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500" />
                </div>
                <div className="flex items-center space-x-3 p-4 bg-gray-50 rounded-lg">
                  <input type="checkbox" name="is_active" id="is_active" checked={formData.is_active} onChange={handleChange} className="h-5 w-5 text-blue-600 rounded focus:ring-blue-500" />
                  <label htmlFor="is_active" className="text-sm font-medium text-gray-700">{formData.is_active ? 'เปิดใช้งาน (แสดงในหน้าร้าน)' : 'ปิดใช้งาน (ซ่อนจากหน้าร้าน)'}</label>
                </div>
                <div className="flex space-x-3 pt-4">
                  <button type="submit" className="flex-1 bg-blue-600 text-white py-3 rounded-lg font-semibold hover:bg-blue-700">{editEbook ? '💾 อัปเดต' : '➕ สร้างหนังสือ'}</button>
                  <button type="button" onClick={() => setShowModal(false)} className="flex-1 bg-gray-200 text-gray-700 py-3 rounded-lg font-semibold hover:bg-gray-300">ยกเลิก</button>
                </div>
              </form>
            </div>
          </div>
        )}
      </div>
    </AdminLayout>
  );
};

export default ManageEbooks;