from fastapi import APIRouter, Depends, HTTPException, status
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
            quantity,
            price,
            subtotal,
            ebooks (title)
        )
    """).eq("user_id", current_user["id"]).order("created_at", desc=True).execute()
    
    return success_response(data=orders.data)


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
            quantity,
            price,
            subtotal,
            ebooks (title, cover_url)
        )
    """).eq("id", order_id).eq