import google.generativeai as genai
from .prompts import system_prompt,chat_prompt


class GeminiAI:


    def __init__(self,key):

        genai.configure(
            api_key=key
        )

        self.model = genai.GenerativeModel(
    "gemini-3.6-flash"
)



    def ask(
        self,
        question,
        data
    ):


        prompt=chat_prompt(
            question,
            data
        )


        try:

            response=self.model.generate_content(
                prompt
            )

            return response.text


        except Exception as e:

            return str(e)