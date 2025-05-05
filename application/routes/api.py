from flask import Blueprint, jsonify
from models.products import Product, db

api_bp = Blueprint('api', __name__)

@api_bp.route('/products', methods=['GET'])
def get_products():
    """Retrieve and return a list of products."""
    try:
        products = Product.query.all()
        return jsonify([product.to_dict() for product in products]), 200
    except Exception as e:
        return jsonify({'error': f'Failed to fetch products: {str(e)}'}), 500
    
@api_bp.route('/health', methods=['GET'])
def health_check():
    """Check the health of the application."""
    return jsonify({'status': 'ok'}), 200
