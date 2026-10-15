def check_payment_warnings(
    amount,
    current_spending,
    monthly_income,
    category
):
    warnings = []

    projected_spending = current_spending + amount

    # Large single transaction
    if amount >= monthly_income * 0.25:
        warnings.append(
            "This is a large transaction compared with your monthly income."
        )

    # Monthly spending limit
    if projected_spending > monthly_income:
        warnings.append(
            "This payment would make your monthly spending exceed your income."
        )

    elif projected_spending >= monthly_income * 0.80:
        warnings.append(
            "Warning: this payment will take your monthly spending above 80% of your income."
        )

    # Shopping behaviour
    if category.lower() == "shopping" and amount >= 1000:
        warnings.append(
            "You are making a significant shopping purchase. Consider whether it is necessary."
        )

    if not warnings:
        warnings.append(
            "Payment looks safe."
        )

    return warnings