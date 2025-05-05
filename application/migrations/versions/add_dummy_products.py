"""Add Dummy Products

Revision ID: add_dummy_products
Revises: 585cdef8ff72
Create Date: 2024-05-02 23:45:00.000000

"""
from alembic import op
import sqlalchemy as sa
from datetime import datetime


# revision identifiers, used by Alembic.
revision = 'add_dummy_products'
down_revision = '585cdef8ff72'
branch_labels = None
depends_on = None


def upgrade():
    # Insert dummy products
    op.execute("""
        INSERT INTO products (name, price, description) VALUES
        ('Laptop Pro', 1299.99, 'High-performance laptop with 16GB RAM and 512GB SSD'),
        ('Wireless Mouse', 29.99, 'Ergonomic wireless mouse with 2.4GHz connectivity'),
        ('Mechanical Keyboard', 89.99, 'RGB mechanical keyboard with blue switches'),
        ('Gaming Monitor', 299.99, '27-inch 144Hz gaming monitor with 1ms response time'),
        ('Noise-Cancelling Headphones', 199.99, 'Premium wireless headphones with active noise cancellation')
    """)


def downgrade():
    # Remove the dummy products
    op.execute("""
        DELETE FROM products WHERE name IN (
            'Laptop Pro',
            'Wireless Mouse',
            'Mechanical Keyboard',
            'Gaming Monitor',
            'Noise-Cancelling Headphones'
        )
    """) 