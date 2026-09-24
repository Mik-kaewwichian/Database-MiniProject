from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from models.order import OrderCreate, PaymentCreate
from utils.auth import get_current_user
from utils.response import success_response

router = APIRouter(prefix="/api/orders", tags=["Orders"])

@router.post("")
async def create_order(order_data: OrderCreate, current_user=Depends(get_current_user)):
    """Create order from cart"""
    db = get_db()
    
    # Get active cart
    cart = db.table("carts").select("*, cart_items(*, ebooks(title, price, stock))").eq("user_id", current_user["id"]).eq("status", "active").execute()
    
    if not cart.data or not cart.data[0].get("cart_items"):
        raise HTTPException(status_code=400, detail="Cart is empty")
    
    cart = cart.data[0]
    cart_items = cart["cart_items"]
    
    # Check stock for all items
    for item in cart_items:
        if item["ebooks"]["stock"] < item["quantity"]:
            raise HTTPException(status_code=400, detail=f"Insufficient stock for {item['ebooks']['title']}")
    
    # Calculate total
    total = sum(item["quantity"] * float(item["price"]) for item in cart_items)
    
    # Create order
    new_order = db.table("orders").insert({
        "user_id": current_user["id"],
        "total_amount": total,
        "status": "pending",
        "payment_slip_url": order_data.slip_url
    }).execute()
    
    order_id = new_order.data[0]["id"]
    
    # Create order items
    for item in cart_items:
        db.table("order_items").insert({
            "order_id": order_id,
            "ebook_id": item["ebook_id"],
            "quantity": item["quantity"],
            "price": float(item["price"]),
            "subtotal": float(item["quantity"] * item["price"])
        }).execute()
    
    # Create payment record
    db.table("payments").insert({
        "order_id": order_id,
        "amount": total,
        "payment_method": order_data.payment_method,
        "slip_url": order_data.slip_url,
        "status": "pending"
    }).execute()
    
    # Update cart status
    db.table("carts").update({"status": "converted"}).eq("id", cart["id"]).execute()
    
    # Clear cart items
    db.table("cart_items").delete().eq("cart_id", cart["id"]).execute()
    
    return success_response({"order_id": order_id}, "Order created successfully")

@router.get("")
async def get_orders(current_user=Depends(get_current_user)):
    """Get user's orders"""
    db = get_db()
    
    orders = db.table("orders").select("*, order_items(*, ebooks(title))").eq("user_id", current_user["id"]).order("created_at", desc=True).execute()
    
    return success_response(orders.data)

@router.get("/{order_id}")
async def get_order(order_id: int, current_user=Depends(get_current_user)):
    """Get order details"""
    db = get_db()
    
    order = db.table("orders").select("*, order_items(*, ebooks(title, download_url)), payments(*)").eq("id", order_id).execute()
    
    if not order.data:
        raise HTTPException(status_code=404, detail="Order not found")
    
    order = order.data[0]
    
    # Verify ownership
    if order["user_id"] != current_user["id"] and current_user["roles"]["name"] != "admin":
        raise HTTPException(status_code=403, detail="Not authorized")
    
    # Add download tokens if order is confirmed
    if order["status"] == "confirmed":
        for item in order["order_items"]:
            download_link = db.table("download_links").select("token").eq("order_item_id", item["id"]).execute()
            if download_link.data:
                item["download_token"] = download_link.data[0]["token"]
    
    return success_response(order)

@router.post("/{order_id}/payment")
async def submit_payment(order_id: int, payment_data: PaymentCreate, current_user=Depends(get_current_user)):
    """Submit payment for order"""
    db = get_db()
    
    # Verify order belongs to user
    order = db.table("orders").select("*").eq("id", order_id).eq("user_id", current_user["id"]).execute()
    
    if not order.data:
        raise HTTPException(status_code=404, detail="Order not found")
    
    if order.data[0]["status"] != "pending":
        raise HTTPException(status_code=400, detail="Order is not pending")
    
    # Update order
    db.table("orders").update({
        "status": "paid",
        "payment_slip_url": payment_data.slip_url
    }).eq("id", order_id).execute()
    
    # Update payment
    db.table("payments").update({
        "status": "pending",
        "slip_url": payment_data.slip_url,
        "paid_at": "now()"
    }).eq("order_id", order_id).execute()
    
    return success_response(message="Payment submitted")

@router.get("/{order_id}/download/{item_id}")
async def download_ebook(order_id: int, item_id: int, current_user=Depends(get_current_user)):
    """Get download link for order item"""
    db = get_db()
    
    # Verify order belongs to user and is confirmed
    order = db.table("orders").select("*").eq("id", order_id).eq("user_id", current_user["id"]).execute()
    
    if not order.data:
        raise HTTPException(status_code=404, detail="Order not found")
    
    if order.data[0]["status"] != "confirmed":
        raise HTTPException(status_code=403, detail="Order not confirmed yet")
    
    # Get order item
    order_item = db.table("order_items").select("*, ebooks(download_url)").eq("id", item_id).eq("order_id", order_id).execute()
    
    if not order_item.data:
        raise HTTPException(status_code=404, detail="Order item not found")
    
    # Get download link
    download_link = db.table("download_links").select("*").eq("order_item_id", item_id).execute()
    
    if not download_link.data:
        raise HTTPException(status_code=404, detail="Download link not found")
    
    link = download_link.data[0]
    
    # Check if expired
    from datetime import datetime
    if datetime.fromisoformat(link["expires_at"].replace("Z", "+00:00")) < datetime.now():
        raise HTTPException(status_code=410, detail="Download link expired")
    
    return success_response({
        "download_url": order_item.data[0]["ebooks"]["download_url"],
        "token": link["token"],
        "expires_at": link["expires_at"]
    })