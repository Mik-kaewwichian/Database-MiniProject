from fastapi import APIRouter, Depends, HTTPException
from database import get_db
from utils.auth import get_current_user
from utils.response import success_response

router = APIRouter(prefix="/api/authors", tags=["Authors"])


@router.get("")
async def get_authors():
    """Get all authors (public)"""
    db = get_db()
    authors = db.table("authors").select("*").order("name").execute()
    return success_response(authors.data)