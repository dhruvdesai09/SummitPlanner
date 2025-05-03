from flask import Blueprint, request, jsonify
from llama_service import get_advice
from database import get_user_profile_by_email

chat_bp = Blueprint('chat', __name__)

@chat_bp.route('/chat', methods=['POST'])
def chat_with_bot():
    data = request.get_json()
    email = data.get('email')
    message = data.get('message')

    profile = get_user_profile_by_email(email)
    if not profile:
        return jsonify({'error': 'User profile not found'}), 404

    prompt = f"""User's profile: Income: ₹{profile['income_level']}, Currency: {profile['currency']}, 
    Risk Tolerance: Low. Question: {message}"""

    response = get_advice(prompt)
    return jsonify({'response': response})
