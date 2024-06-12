from flask import Flask, request, jsonify
#from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# app.config['SQLALCHEMY_DATABASE_URI'] = ''

base = {}
base2 = {}
@app.route('/vk/numbers')
def all_base_phones():
    return base2;

@app.route('/tg', methods=['GET'])
def phone_number():
    base['Number'] = str(request.args['Number'])
    base['Number2'] = str(request.args['Number2'])
    return jsonify (base)

@app.route('/vk/signup', methods=['GET'])
def sign_up():
    Number = str(request.args['Number'])
    Password = str(request.args['Password'])
    base2[Number] = Password
    return jsonify (base2)


if __name__ == '__main__':
    app.run()