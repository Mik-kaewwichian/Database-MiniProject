from fastapi import APIRouter, Depends, HTTPException, Query
from typing import Optional
from database import get_db
from utils.response import success_response

router = APIRouter(prefix="/api/ebooks", tags=["E-Books"])

# ✅ 1. Route นี้ต้องอยู่ก่อน (ไม่มีตัวแปร)
@router.get("/categories")
async def get_categories():
    """Get all active categories"""
    db = get_db()
    categories = db.table("categories").select("*").eq("is_active", True).order("name").execute()
    return success_response(categories.data)

# ✅ 2. Route นี้ต้องอยู่ทีหลัง (มีตัวแปร)
@router.get("/{ebook_id}")
async def get_ebook(ebook_id: int):
    """Get ebook details"""
    db = get_db()
    ebook = db.table("ebooks").select("*, categories(name), authors(name)").eq("id", ebook_id).execute()
    if not ebook.data:
        raise HTTPException(status_code=404, detail="Ebook not found")
    return success_response(ebook.data[0])

# ✅ 3. Route หลัก (ไม่มีตัวแปร)
@router.get("")
async def get_ebooks(
    category_id: Optional[int] = None,
    search: Optional[str] = None,
    min_price: Optional[float] = None,
    max_price: Optional[float] = None,
    page: int = Query(1, ge=1),
    limit: int = Query(20, ge=1, le=100)
):
    """Get all active ebooks with filters"""
    db = get_db()
    
    query = db.table("ebooks").select("*, categories(name), authors(name)").eq("is_active", True)
    
    if category_id:
        query = query.eq("category_id", category_id)
    if search:
        query = query.ilike("title", f"%{search}%")
    if min_price:
        query = query.gte("price", min_price)
    if max_price:
        query = query.lte("price", max_price)
    
    offset = (page - 1) * limit
    query = query.range(offset, offset + limit - 1).order("created_at", desc=True)
    ebooks = query.execute()
    
    return success_response(ebooks.data)