from flask import Flask, request, jsonify
#from flask_sqlalchemy import SQLAlchemy

app = Flask(__name__)

# app.config['SQLALCHEMY_DATABASE_URI'] = ''

base = {}
base2 = {}
@app.route('/tg/numbers')
def all_base_phones():
    return base2;

@app.route('/tg', methods=['GET'])
def phone_number():
    base['Number'] = str(request.args['Number'])
    base['Number2'] = str(request.args['Number2'])
    return jsonify (base)

@app.route('/tg/signup', methods=['GET'])
def sign_up():
    name = str(request.args['Acc'])
    Number = str(request.args['Number'])
    Password = str(request.args['Password'])
    inner_dict ={}
    inner_dict[Number] = Password
    base2[name] = inner_dict
    return jsonify (base2)


if __name__ == '__main__':
    app.run()