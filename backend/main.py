import os
import uuid

from datetime import datetime

from dotenv import load_dotenv

from fastapi import FastAPI, HTTPException
from fastapi.middleware.cors import CORSMiddleware

from pydantic import BaseModel

from database import transactions, users

from ai.analysis import analyze_spending
from ai.financial_score import calculate_financial_score
from ai.rules import check_payment_warnings
from ai.ai_chat import GeminiAI


# --------------------------------
# Environment
# --------------------------------

load_dotenv()

GEMINI_API_KEY = os.getenv(
    "GEMINI_API_KEY"
)


# --------------------------------
# FastAPI
# --------------------------------

app = FastAPI(
    title="FinGuard AI Backend",
    version="1.0.0"
)


# Flutter Web support

app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)


# --------------------------------
# Gemini
# --------------------------------

ai = GeminiAI(
    GEMINI_API_KEY
)


# --------------------------------
# Models
# --------------------------------

class Transaction(BaseModel):

    user_id: str

    amount: float

    category: str

    type: str

    description: str


class ChatRequest(BaseModel):

    user_id: str

    question: str


# --------------------------------
# Helper
# --------------------------------

def get_user(user_id):

    user = users.get(user_id)

    if not user:

        raise HTTPException(
            status_code=404,
            detail="User not found"
        )

    return user


def get_user_transactions(user_id):

    return [

        transaction

        for transaction in transactions

        if transaction["user_id"]
        == user_id

    ]


# --------------------------------
# Home
# --------------------------------

@app.get("/")
def home():

    return {
        "message":
        "FinGuard AI Backend Running"
    }


# --------------------------------
# Add Transaction
# --------------------------------

@app.post("/add-transaction")
def add_transaction(
    txn: Transaction
):

    get_user(txn.user_id)

    if txn.amount <= 0:

        raise HTTPException(
            status_code=400,
            detail="Amount must be positive"
        )

    transaction = txn.model_dump()

    transaction["id"] = str(
        uuid.uuid4()
    )

    transaction["date"] = (
        datetime.now().isoformat()
    )

    transactions.append(
        transaction
    )

    return {
        "message":
        "Transaction Added",

        "transaction":
        transaction
    }


# --------------------------------
# Transactions
# --------------------------------

@app.get(
    "/transactions/{user_id}"
)
def get_transactions(user_id: str):

    get_user(user_id)

    user_transactions = (
        get_user_transactions(
            user_id
        )
    )

    return {
        "transactions":
        user_transactions
    }


# --------------------------------
# Financial Score
# --------------------------------

@app.get(
    "/financial-score/{user_id}"
)
def financial_score(user_id: str):

    user = get_user(user_id)

    user_transactions = (
        get_user_transactions(
            user_id
        )
    )

    income = user["income"]

    score_result = (
        calculate_financial_score(
            user_transactions,
            income
        )
    )

    analysis = analyze_spending(
        user_transactions
    )

    return {

        "score":
            score_result["score"],

        "rating":
            score_result["rating"],

        "spent":
            score_result["spent"],

        "saving":
            score_result["saving"],

        "income":
            income,

        "analysis":
            analysis
    }


# --------------------------------
# AI
# --------------------------------

@app.post("/ask-ai")
def ask_ai(chat: ChatRequest):

    user = get_user(
        chat.user_id
    )

    user_transactions = (
        get_user_transactions(
            chat.user_id
        )
    )

    analysis = analyze_spending(
        user_transactions
    )

    score = (
        calculate_financial_score(
            user_transactions,
            user["income"]
        )
    )

    financial_data = {

        "income":
            user["income"],

        "score":
            score,

        "spending_analysis":
            analysis
    }

    response = ai.ask(
        chat.question,
        financial_data
    )

    return {
        "response":
        response
    }


# --------------------------------
# Smart Payment Warning
# --------------------------------

@app.post("/check-payment")
def check_payment(
    txn: Transaction
):

    user = get_user(
        txn.user_id
    )

    user_transactions = (
        get_user_transactions(
            txn.user_id
        )
    )

    analysis = analyze_spending(
        user_transactions
    )

    current_spending = (
        analysis["total_spending"]
    )

    warnings = (
        check_payment_warnings(

            amount=txn.amount,

            current_spending=
                current_spending,

            monthly_income=
                user["income"],

            category=
                txn.category
        )
    )

    return {

        "warning":
            warnings,

        "current_spending":
            current_spending,

        "projected_spending":
            current_spending
            + txn.amount,

        "monthly_income":
            user["income"]
    }