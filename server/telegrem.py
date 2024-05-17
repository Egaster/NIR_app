from flask import Flask, request, jsonify
from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# app.config['SQLALCHEMY_DATABASE_URI'] = ''

base = {}
@app.route('/tg/numbers')
def all_base_phones():
    return base;

@app.route('/tg', methods=['GET'])
def phone_number():
    base['Number'] = str(request.args['Number'])
    base['Number2'] = str(request.args['Number2'])
    return jsonify (base)

if __name__ == '__main__':
    app.run()