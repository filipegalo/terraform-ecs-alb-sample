from extensions import db

class Product(db.Model):
    __tablename__ = 'products'

    id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(100), nullable=False)
    price = db.Column(db.Numeric(10, 2), nullable=False)
    description = db.Column(db.Text)

    def to_dict(self):
        """Convert model instance to dictionary."""
        return {
            'id': self.id,
            'name': self.name,
            'price': float(self.price),  # Convert Decimal to float for JSON
            'description': self.description
        }