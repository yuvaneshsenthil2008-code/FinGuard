import pandas as pd


def analyze_spending(transactions):

    if not transactions:

        return {
            "total_spending":0,
            "category_breakdown":{},
            "top_category":None,
            "average_transaction":0,
            "transaction_count":0
        }


    df=pd.DataFrame(transactions)


    df["amount"]=pd.to_numeric(
        df["amount"],
        errors="coerce"
    ).fillna(0)


    # Only expenses

    expense_df=df[
        df["type"]=="debit"
    ]


    if expense_df.empty:

        return {
            "total_spending":0,
            "category_breakdown":{},
            "top_category":None,
            "average_transaction":0,
            "transaction_count":0
        }



    total=float(
        expense_df["amount"].sum()
    )


    category=(
        expense_df
        .groupby("category")["amount"]
        .sum()
        .to_dict()
    )


    top=max(
        category,
        key=category.get
    )


    return {


        "total_spending":total,

        "category_breakdown":category,

        "top_category":top,

        "average_transaction":
        round(
            float(expense_df["amount"].mean()),
            2
        ),

        "transaction_count":
        len(expense_df)

    }