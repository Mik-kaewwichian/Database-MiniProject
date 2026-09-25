from fastapi import APIRouter, Depends, HTTPException, status
from database import get_db
from models.ebook import EbookCreate, EbookUpdate
from models.order import OrderUpdate
from utils.auth import get_current_admin
from utils.response import success_response
from decimal import Decimal

router = APIRouter(prefix="/api/admin", tags=["Admin"])


# ==================== E-BOOK MANAGEMENT ====================

@router.get("/ebooks")
async def get_all_ebooks(admin=Depends(get_current_admin)):
    """Get all ebooks (admin only)"""
    db = get_db()
    ebooks = db.table("ebooks").select("""
        *,
        categories (id, name),
        authors (id, name)
    """).order("created_at", desc=True).execute()
    return success_response(ebooks.data)


@router.post("/ebooks", status_code=status.HTTP_201_CREATED)
async def create_ebook(ebook_data: EbookCreate, admin=Depends(get_current_admin)):
    """Create new ebook (admin only)"""
    db = get_db()
    
    # ✅ แก้ปัญหา Decimal → float
    insert_data = ebook_data.dict()
    insert_data["price"] = float(insert_data["price"])
    
    new_ebook = db.table("ebooks").insert(insert_data).execute()
    return success_response(new_ebook.data[0], "Ebook created")


@router.put("/ebooks/{ebook_id}")
async def update_ebook(ebook_id: int, ebook_data: EbookUpdate, admin=Depends(get_current_admin)):
    """Update ebook (admin only)"""
    db = get_db()
    
    update_data = {k: v for k, v in ebook_data.dict().items() if v is not None}
    
    # ✅ แก้ปัญหา Decimal → float
    if "price" in update_data:
        update_data["price"] = float(update_data["price"])
    
    if not update_data:
        raise HTTPException(status_code=400, detail="No data to update")
    
    updated = db.table("ebooks").update(update_data).eq("id", ebook_id).execute()
    return success_response(updated.data[0], "Ebook updated")


@router.delete("/ebooks/{ebook_id}")
async def delete_ebook(ebook_id: int, admin=Depends(get_current_admin)):
    """Soft delete ebook (admin only)"""
    db = get_db()
    db.table("ebooks").update({"is_active": False}).eq("id", ebook_id).execute()
    return success_response(message="Ebook deleted")


# ==================== CATEGORY MANAGEMENT ====================

@router.get("/categories")
async def get_all_categories(admin=Depends(get_current_admin)):
    """Get all categories"""
    db = get_db()
    categories = db.table("categories").select("*").order("name").execute()
    return success_response(categories.data)


@router.post("/categories", status_code=status.HTTP_201_CREATED)
async def create_category(category_data: dict, admin=Depends(get_current_admin)):
    """Create new category"""
    db = get_db()
    new_cat = db.table("categories").insert(category_data).execute()
    return success_response(new_cat.data[0], "Category created")


@router.put("/categories/{category_id}")
async def update_category(category_id: int, category_data: dict, admin=Depends(get_current_admin)):
    """Update category"""
    db = get_db()
    update_data = {k: v for k, v in category_data.items() if v is not None}
    if not update_data:
        raise HTTPException(status_code=400, detail="No data to update")
    updated = db.table("categories").update(update_data).eq("id", category_id).execute()
    return success_response(updated.data[0], "Category updated")


@router.delete("/categories/{category_id}")
async def delete_category(category_id: int, admin=Depends(get_current_admin)):
    """Delete category"""
    db = get_db()
    db.table("categories").update({"is_active": False}).eq("id", category_id).execute()
    return success_response(message="Category deleted")


# ==================== ORDER MANAGEMENT ====================

@router.get("/orders")
async def get_all_orders(admin=Depends(get_current_admin)):
    """Get all orders (admin only)"""
    db = get_db()
    orders = db.table("orders").select("""
        *,
        users (id, name, email),
        order_items (
            id,
            quantity,
            price,
            subtotal,
            ebooks (id, title, cover_url)
        ),
        payments (id, status, slip_url, paid_at)
    """).order("created_at", desc=True).execute()
    return success_response(orders.data)


@router.put("/orders/{order_id}")
async def update_order_status(order_id: int, order_data: OrderUpdate, admin=Depends(get_current_admin)):
    """Update order status (admin only)"""
    db = get_db()
    
    update_data = {k: v for k, v in order_data.dict().items() if v is not None}
    if not update_data:
        raise HTTPException(status_code=400, detail="No data to update")
    
    # ถ้าเป็นการยืนยันคำสั่งซื้อ → สร้าง download links + อัปเดต payment
    if update_data.get("status") == "confirmed":
        import secrets
        from datetime import datetime, timedelta
        
        order_items = db.table("order_items").select("id, ebook_id, ebooks(download_url)").eq("order_id", order_id).execute()
        
        for item in order_items.data:
            token = f"token_{secrets.token_urlsafe(32)}"
            expires_at = (datetime.now() + timedelta(days=7)).isoformat()
            
            db.table("download_links").insert({
                "order_item_id": item["id"],
                "token": token,
                "expires_at": expires_at
            }).execute()
        
        # อัปเดต payment status
        db.table("payments").update({
            "status": "verified",
            "paid_at": datetime.now().isoformat()
        }).eq("order_id", order_id).execute()
    
    updated = db.table("orders").update(update_data).eq("id", order_id).execute()
    return success_response(updated.data[0], "Order updated")


# ==================== USER MANAGEMENT ====================

@router.get("/users")
async def get_all_users(admin=Depends(get_current_admin)):
    """Get all users (admin only)"""
    db = get_db()
    users = db.table("users").select("*, roles(name)").order("created_at", desc=True).execute()
    return success_response(users.data)


@router.put("/users/{user_id}/role")
async def update_user_role(user_id: int, role_data: dict, admin=Depends(get_current_admin)):
    """Update user role"""
    db = get_db()
    
    if "role_id" not in role_data:
        raise HTTPException(status_code=400, detail="role_id is required")
    
    updated = db.table("users").update({"role_id": role_data["role_id"]}).eq("id", user_id).execute()
    return success_response(updated.data[0], "User role updated")


@router.put("/users/{user_id}/active")
async def update_user_active(user_id: int, active_data: dict, admin=Depends(get_current_admin)):
    """Activate/Deactivate user"""
    db = get_db()
    
    if "is_active" not in active_data:
        raise HTTPException(status_code=400, detail="is_active is required")
    
    updated = db.table("users").update({"is_active": active_data["is_active"]}).eq("id", user_id).execute()
    return success_response(updated.data[0], "User status updated")


# ==================== REPORTS ====================

@router.get("/reports/sales-by-time")
async def report_sales_by_time(admin=Depends(get_current_admin)):
    """Sales by time report"""
    db = get_db()
    result = db.rpc("report_sales_by_time").execute()
    return success_response(result.data)


@router.get("/reports/best-selling")
async def report_best_selling(admin=Depends(get_current_admin)):
    """Best selling ebooks report"""
    db = get_db()
    result = db.rpc("report_best_selling_ebooks").execute()
    return success_response(result.data)


@router.get("/reports/sales-by-category")
async def report_sales_by_category(admin=Depends(get_current_admin)):
    """Sales by category report"""
    db = get_db()
    result = db.rpc("report_sales_by_category").execute()
    return success_response(result.data)


@router.get("/reports/customer-analysis")
async def report_customer_analysis(admin=Depends(get_current_admin)):
    """Customer analysis report"""
    db = get_db()
    result = db.rpc("report_customer_analysis").execute()
    return success_response(result.data)


@router.get("/reports/order-status")
async def report_order_status(admin=Depends(get_current_admin)):
    """Order status report"""
    db = get_db()
    result = db.rpc("report_order_status").execute()
    return success_response(result.data)