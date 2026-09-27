from datetime import datetime
from fastapi import APIRouter, Depends, HTTPException, status
from fastapi.responses import RedirectResponse
from database import get_db
from models.order import OrderCreate
from utils.auth import get_current_user
from utils.response import success_response

router = APIRouter(prefix="/api/orders", tags=["Orders"])


@router.post("", status_code=status.HTTP_201_CREATED)
async def create_order(
    order_data: OrderCreate,
    current_user=Depends(get_current_user)
):
    """Create new order from cart"""
    db = get_db()
    
    print(f"=== DEBUG CREATE ORDER ===")
    print(f"User ID: {current_user['id']}")
    
    # 1. Get user's cart
    cart = db.table("carts").select("*").eq("user_id", current_user["id"]).execute()
    print(f"Cart query result: {cart.data}")
    
    if not cart.data:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Cart not found")
    
    cart_id = cart.data[0]["id"]
    print(f"Cart ID: {cart_id}")
    
    # 2. Get cart items
    cart_items = db.table("cart_items").select("*").eq("cart_id", cart_id).execute()
    print(f"Cart items query result: {cart_items.data}")
    
    if not cart_items.data or len(cart_items.data) == 0:
        raise HTTPException(status_code=status.HTTP_400_BAD_REQUEST, detail="Cart is empty")
    
    # 3. Calculate total and prepare order items
    total = 0
    order_items_data = []
    
    for item in cart_items.data:
        # Get ebook price
        ebook = db.table("ebooks").select("price, title").eq("id", item["ebook_id"]).execute()
        
        if not ebook.data:
            raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail=f"Ebook {item['ebook_id']} not found")
        
        price = ebook.data[0]["price"]
        subtotal = price * item["quantity"]
        total += subtotal
        
        order_items_data.append({
            "ebook_id": item["ebook_id"],
            "quantity": item["quantity"],
            "price": price,
            "subtotal": subtotal
        })
    
    # 4. Create order
    order = db.table("orders").insert({
        "user_id": current_user["id"],
        "total_amount": total,
        "status": "pending",
        "payment_method": order_data.payment_method,
        "payment_slip_url": order_data.slip_url
    }).execute()
    
    order_id = order.data[0]["id"]
    print(f"✅ Created Order ID: {order_id}")
    
    # 5. Create order items
    for item_data in order_items_data:
        db.table("order_items").insert({
            "order_id": order_id,
            **item_data
        }).execute()
    
    # 6. Clear cart
    db.table("cart_items").delete().eq("cart_id", cart_id).execute()
    print("✅ Cart cleared successfully")
    
    return success_response(
        data={"order_id": order_id},
        message="Order created successfully"
    )


@router.get("")
async def get_orders(current_user=Depends(get_current_user)):
    """Get current user's orders"""
    db = get_db()
    
    orders = db.table("orders").select("""
        *,
        order_items (
            id,
            ebook_id,
            quantity,
            price,
            subtotal,
            ebooks (title, cover_url, download_url),
            download_links (token, expires_at)
        )
    """).eq("user_id", current_user["id"]).order("created_at", desc=True).execute()

    return success_response(data=_add_download_paths(orders.data))


def _add_download_paths(orders):
    now = datetime.now()
    for order in orders:
        for item in order.get("order_items") or []:
            ebook = item.get("ebooks") or {}
            download_links = item.get("download_links")
            links = download_links if isinstance(download_links, list) else [download_links] if download_links else []
            item["title"] = ebook.get("title", "หนังสือ")
            item["cover_url"] = ebook.get("cover_url")
            item["download_path"] = None
            item.pop("ebooks", None)

            if order.get("status") != "confirmed" or not ebook.get("download_url"):
                continue

            for link in links:
                expires_at = link.get("expires_at")
                if not expires_at:
                    continue
                expiry = datetime.fromisoformat(expires_at.replace("Z", "+00:00"))
                current_time = datetime.now(expiry.tzinfo) if expiry.tzinfo else now
                if expiry > current_time:
                    item["download_path"] = f"/api/orders/download/{link['token']}"
                    item["download_expires_at"] = expires_at
                    break
    return orders


@router.get("/download/{token}")
async def download_order_item(token: str):
    """Validate a time-limited order token and redirect to its ebook file."""
    db = get_db()
    link = db.table("download_links").select("order_item_id, expires_at").eq("token", token).execute()
    if not link.data:
        raise HTTPException(status_code=404, detail="Download link not found")

    download_link = link.data[0]
    expires_at = datetime.fromisoformat(download_link["expires_at"].replace("Z", "+00:00"))
    current_time = datetime.now(expires_at.tzinfo) if expires_at.tzinfo else datetime.now()
    if expires_at <= current_time:
        raise HTTPException(status_code=410, detail="Download link has expired")

    order_item = db.table("order_items").select("order_id, ebooks(download_url)").eq(
        "id", download_link["order_item_id"]
    ).execute()
    if not order_item.data:
        raise HTTPException(status_code=404, detail="Order item not found")

    item_data = order_item.data[0]
    order = db.table("orders").select("status").eq("id", item_data["order_id"]).execute()
    if not order.data or order.data[0]["status"] != "confirmed":
        raise HTTPException(status_code=403, detail="Order is not confirmed")

    ebook = item_data.get("ebooks") or {}
    download_url = ebook.get("download_url")
    if not download_url:
        raise HTTPException(status_code=404, detail="PDF file is not available")

    db.table("download_links").update({"downloaded_at": current_time.isoformat()}).eq(
        "order_item_id", download_link["order_item_id"]
    ).execute()
    return RedirectResponse(download_url, status_code=status.HTTP_302_FOUND)


@router.get("/{order_id}")
async def get_order(
    order_id: int,
    current_user=Depends(get_current_user)
):
    """Get specific order details"""
    db = get_db()
    
    order = db.table("orders").select("""
        *,
        order_items (
            id,
            ebook_id,
            quantity,
            price,
            subtotal,
            ebooks (title, cover_url, download_url),
            download_links (token, expires_at)
        )
    """).eq("id", order_id).eq("user_id", current_user["id"]).execute()
    if not order.data:
        raise HTTPException(status_code=404, detail="Order not found")

    return success_response(data=_add_download_paths(order.data)[0])


@router.post("/{order_id}/cancel")
async def cancel_order(
    order_id: int,
    current_user=Depends(get_current_user)
):
    """Cancel an order owned by the current user while it is still pending."""
    db = get_db()
    order = db.table("orders").select("id, status").eq(
        "id", order_id
    ).eq("user_id", current_user["id"]).execute()

    if not order.data:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="Order not found")
    if order.data[0]["status"] != "pending":
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="Only pending orders can be cancelled",
        )

    cancelled = db.table("orders").update({
        "status": "cancelled",
        "updated_at": datetime.now().isoformat(),
    }).eq("id", order_id).eq("user_id", current_user["id"]).eq(
        "status", "pending"
    ).execute()

    if not cancelled.data:
        raise HTTPException(
            status_code=status.HTTP_409_CONFLICT,
            detail="Order status changed; refresh and try again",
        )

    return success_response(data=cancelled.data[0], message="Order cancelled")