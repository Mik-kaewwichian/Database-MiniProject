from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from models.ebook import EbookCreate, EbookUpdate
from models.order import OrderUpdate
from utils.auth import get_current_admin
from utils.response import success_response

router = APIRouter(prefix="/api/admin", tags=["Admin"])

# E-book Management
@router.get("/ebooks")
async def get_all_ebooks(admin=Depends(get_current_admin)):
    """Get all ebooks (admin only)"""
    db = get_db()
    
    ebooks = db.table("ebooks").select("*, categories(name), authors(name)").order("created_at", desc=True).execute()
    
    return success_response(ebooks.data)

@router.post("/ebooks")
async def create_ebook(ebook_data: EbookCreate, admin=Depends(get_current_admin)):
    """Create new ebook (admin only)"""
    db = get_db()
    
    new_ebook = db.table("ebooks").insert(ebook_data.dict()).execute()
    
    return success_response(new_ebook.data[0], "Ebook created")

@router.put("/ebooks/{ebook_id}")
async def update_ebook(ebook_id: int, ebook_data: EbookUpdate, admin=Depends(get_current_admin)):
    """Update ebook (admin only)"""
    db = get_db()
    
    update_data = {k: v for k, v in ebook_data.dict().items() if v is not None}
    if not update_data:
        raise HTTPException(status_code=400, detail="No data to update")
    
    updated = db.table("ebooks").update(update_data).eq("id", ebook_id).execute()
    
    return success_response(updated.data[0], "Ebook updated")

# Order Management
@router.get("/orders")
async def get_all_orders(admin=Depends(get_current_admin)):
    """Get all orders (admin only)"""
    db = get_db()
    
    orders = db.table("orders").select("*, users(name, email), order_items(*, ebooks(title))").order("created_at", desc=True).execute()
    
    return success_response(orders.data)

@router.put("/orders/{order_id}")
async def update_order_status(order_id: int, order_data: OrderUpdate, admin=Depends(get_current_admin)):
    """Update order status (admin only)"""
    db = get_db()
    
    update_data = {k: v for k, v in order_data.dict().items() if v is not None}
    if not update_data:
        raise HTTPException(status_code=400, detail="No data to update")
    
    # If confirming order, generate download links
    if update_data.get("status") == "confirmed":
        # Get order items
        order_items = db.table("order_items").select("id, ebook_id, ebooks(download_url)").eq("order_id", order_id).execute()
        
        # Generate download links
        import secrets
        from datetime import datetime, timedelta
        
        for item in order_items.data:
            token = f"token_{secrets.token_urlsafe(32)}"
            expires_at = (datetime.now() + timedelta(days=7)).isoformat()
            
            db.table("download_links").insert({
                "order_item_id": item["id"],
                "token": token,
                "expires_at": expires_at
            }).execute()
        
        # Update payment status
        db.table("payments").update({"status": "verified", "paid_at": "now()"}).eq("order_id", order_id).execute()
    
    updated = db.table("orders").update(update_data).eq("id", order_id).execute()
    
    return success_response(updated.data[0], "Order updated")

# User Management
@router.get("/users")
async def get_all_users(admin=Depends(get_current_admin)):
    """Get all users (admin only)"""
    db = get_db()
    
    users = db.table("users").select("*, roles(name)").order("created_at", desc=True).execute()
    
    return success_response(users.data)

# Reports
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