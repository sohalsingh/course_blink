# Globally set cse_api_key in google in rails credentials
CSE_API_KEY = Rails.application.credentials.dig(:google, :cse_api_key)
SEARCH_ENGINE_ID = Rails.application.credentials.dig(:google, :search_engine_id)
