import pandas as pd


def calculate_financial_score(
    transactions,
    monthly_income
):

    if monthly_income <= 0:
        return {
            "score": 0,
            "rating": "No Income Data",
            "spent": 0,
            "saving": 0
        }

    if not transactions:
        return {
            "score": 100,
            "rating": "Excellent",
            "spent": 0,
            "saving": float(monthly_income)
        }

    df = pd.DataFrame(transactions)

    df["amount"] = pd.to_numeric(
        df["amount"],
        errors="coerce"
    ).fillna(0)

    expenses = df[
        df["type"] == "debit"
    ]

    spent = float(
        expenses["amount"].sum()
    )

    saving = monthly_income - spent

    saving_ratio = saving / monthly_income

    score = 100

    # -----------------------------
    # Savings behaviour
    # -----------------------------

    if saving_ratio < 0:
        score -= 40

    elif saving_ratio < 0.10:
        score -= 30

    elif saving_ratio < 0.30:
        score -= 15

    # -----------------------------
    # Overall spending
    # -----------------------------

    if spent >= monthly_income:
        score -= 25

    elif spent >= monthly_income * 0.80:
        score -= 20

    # -----------------------------
    # Shopping behaviour
    # -----------------------------

    if spent > 0:

        shopping = float(
            expenses[
                expenses["category"].str.lower()
                == "shopping"
            ]["amount"].sum()
        )

        if shopping > spent * 0.40:
            score -= 15

    score = max(
        0,
        min(int(score), 100)
    )

    if score >= 80:
        rating = "Excellent"

    elif score >= 60:
        rating = "Good"

    elif score >= 40:
        rating = "Average"

    else:
        rating = "Needs Improvement"

    return {
        "score": score,
        "rating": rating,
        "spent": spent,
        "saving": float(saving)
    }