from flask import Flask
from config import Config
from extensions import db, migrate
from routes.api import api_bp
from models.products import Product

app = Flask(__name__)

app.config.from_object(Config)

db.init_app(app)
migrate.init_app(app, db)

app.register_blueprint(api_bp, url_prefix='/api')

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000)