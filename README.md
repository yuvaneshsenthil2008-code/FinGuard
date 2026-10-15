# FinBehaviour / FinGuard AI

A **prototype** financial-awareness application with a Flutter frontend and a FastAPI backend. The app explores transaction tracking, spending insights, financial scoring, payment warnings, and Gemini-powered financial chat.

## Stack
- **Frontend:** Flutter (Dart)
- **Backend:** FastAPI (Python), Pydantic
- **AI:** Google Generative AI (Gemini)

## Project layout
- `frontend/` — Flutter app source and platform projects
- `backend/` — FastAPI routes, in-memory sample data, and analysis logic
- `backend/.env.example` — environment variable template (no real credentials)

## Run locally

### Backend
1. Install Python and open a terminal in `backend/`.
2. Create a virtual environment: `python -m venv venv`.
3. Activate it (Windows PowerShell): `./venv/Scripts/Activate.ps1` (or use the activation command appropriate for your shell).
4. Install dependencies: `pip install -r requirements.txt`.
5. Copy `.env.example` to `.env` and provide your own Gemini API key.
6. Launch: `uvicorn main:app --reload`.
7. API docs: `http://127.0.0.1:8000/docs`.

### Flutter frontend
1. Install Flutter SDK.
2. In `frontend/`, run `flutter pub get`.
3. Run `flutter run -d chrome` for local web testing.

**Network note:** The API currently defaults to `http://127.0.0.1:8000` in `frontend/lib/services/api_service.dart`. To run on an Android phone, configure the reachable IP address of the backend machine. Emulator/device network permissions and HTTP configuration may also need changes.

## Prototype limitations
- Login is a demonstration UI, **not real authentication**.
- Demo data uses a hardcoded `user1` and is stored **in memory**; restarting the backend clears transaction changes.
- Payment checks are advisory simulations, not actual payments.
- AI responses depend on valid API credentials, SDK compatibility, and a supported model identifier; test your Gemini configuration before using the AI feature.
- Do not enter genuine financial credentials or sensitive personal financial records. Not production-ready.

## Security
- Never commit `.env` files or API keys. The repository includes only `.env.example`.
- Rotate any credentials that were ever exposed in a public repository.

## Status
Educational/hackathon prototype. Run and test the frontend and backend locally before describing it as fully operational.
