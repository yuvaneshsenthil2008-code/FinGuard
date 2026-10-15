def system_prompt():

    return """
You are FinGuard AI.

You help students manage money.

Give simple financial advice.

Do not encourage unnecessary spending.
"""


def chat_prompt(question,data):

    return f"""

User financial data:

{data}


Question:

{question}


Give short practical advice.

"""