.PHONY: start backend frontend

start:
	@echo "📦 Start backend in venster 1..."
	osascript -e 'tell app "Terminal" to do script "cd \"$(pwd)/backend\" && source venv/bin/activate && python app.py"'

	@echo "⚛️ Start frontend in venster 2..."
	osascript -e 'tell app "Terminal" to do script "cd \"$(pwd)/frontend\" && npm run dev"'


backend:
	cd backend && source venv/bin/activate && python app.py

frontend:
	cd frontend && npm run dev
