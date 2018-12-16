# services/users/project/tests/utils.py
from project import db
from project.api.models import User
import json


def add_user(username, email, password):

    user = User(username=username, email=email, password=password)
    db.session.add(user)
    db.session.commit()
    return user


def login_user(self, email, password):

    resp_login = self.client.post(
        '/auth/login',
        data=json.dumps({
            'email': email,
            'password': password
        }),
        content_type='application/json'
    )
    token = json.loads(resp_login.data.decode())['auth_token']
    return token
