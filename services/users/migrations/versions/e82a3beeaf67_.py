"""empty message

Revision ID: e82a3beeaf67
Revises: 2ec5731b96e6
Create Date: 2018-12-08 06:10:17.107298

"""
from alembic import op
import sqlalchemy as sa


# revision identifiers, used by Alembic.
revision = 'e82a3beeaf67'
down_revision = '2ec5731b96e6'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('users', sa.Column('password', sa.String(length=255)))
    op.execute('UPDATE users SET password=email')
    op.alter_column('users', 'password', nullable=False)
    # ### end Alembic commands ###
