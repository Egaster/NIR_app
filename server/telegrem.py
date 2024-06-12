from quart import Quart, request, redirect, session, jsonify
from telethon import TelegramClient, events, sync, errors
import sqlite3 as sq
from werkzeug.security import generate_password_hash, check_password_hash
import os

app = Quart(__name__)
app.secret_key = os.urandom(24)  # Установите ваш секретный ключ

# Замените эти значения на свои собственные
api_id = 23231412
api_hash = 'd6271b00b787a84b90c28fe059f4706e'
session_name = 'makar.session'


# Создаем клиент Telegram
client = TelegramClient(session_name, api_id, api_hash, system_version="4.16.30-vxCUSTOM")

@app.route('/', methods = ['GET'])
def defoult():
    if 'username' in session:
        return jsonify({'status': 'success', 'user': session['username']})
    else:
        return jsonify({'status': 'error', 'message': 'Fuck u'})
   

@app.route('/register', methods=['GET', 'POST'])
def register():
   # if request.method == 'POST':
   username = request.args['username']
   password = str(request.args['password'])
   hash_pass = generate_password_hash(password, 'pbkdf2:sha256')
   connction = sq.connect('users.db')
   curs = connction.cursor()
   curs.execute('''INSERT INTO Users (username, password) VALUES (?, ?)''', (username, hash_pass))    
   connction.commit()
   connction.close()
   return jsonify({'status': 'success', 'message':'Person Registred'})

@app.route('/login', methods=['GET'])
def login():
   username = request.args['username']
   password = request.args['password']
   connction = sq.connect('users.db')
   curs = connction.cursor()
   curs.execute('''SELECT username, password FROM Users WHERE username = ?''', (username,))
   user = curs.fetchone()
   connction.close()
   if user and check_password_hash(user[1], password):
      session['username'] = username
      return jsonify({'user': user[0], 'status': 'Logged In'})
   else:
      return jsonify({'status': 'Wrong'})


@app.route('/logout', methods=['GET'])
def logout():
   session.pop('username', None)
   return jsonify({'status': 'Logged out'})

<<<<<<< HEAD
base = {}
base2 = {}
@app.route('/vk/numbers')
def all_base_phones():
    return base2;
=======
>>>>>>> 069bbccc520f4bdbc09585eadd42b42deacd3e84

@app.route('/tg', methods=['GET'])
def phone_number():
    if 'phone_number' in session:
        return jsonify({'account': session['phone_number']}) #f"Вы авторизованы как {session['phone_number']}"
    else:
        return jsonify({'status': 'False'})

@app.route('/tg/login', methods=['GET', 'POST'])
async def login_tg():
    # if request.method == 'POST':
    phone_number = request.args['phone_number']
    session['phone_number'] = phone_number

    try:
            # Запускаем клиента Telegram
        await client.start()

            # Отправляем запрос на авторизацию
            # await client.send_code_request(phone_number)

            # # Ожидаем ввода кода авторизации
            # code = await client.get_code_from_user()

            # # Проверяем код авторизации
            # await client.sign_in(phone_number, code)
        return redirect('/')
    except Exception as e:
        return f'Ошибка авторизации: {e}'

    return jsonify({'status':'User is aythorized'})

@app.route('/tg/getdialogs', methods=['GET', 'POST'])
async def get_dialogs_tg():
    if 'phone_number' not in session:
        return jsonify({'status': 'False', 'error': 'Not authorized'})
    

    try:
        # await client.start()
        dialogs = await client.get_dialogs()
        all = {}
        for dialog in dialogs:
            info = {}
            info['name'] = dialog.name
            info['archive'] = dialog.archived
            info['date'] = dialog.date
            info['unread'] = dialog.unread_count
            info['message'] = dialog.message.text
            all[dialog.id] = info
    
        return jsonify({'status': 'True', 'dialogs': all})
    
    except Exception as e:
        return jsonify({'status': 'False', 'error': str(e)})


@app.route('/tg/getmessages', methods=['GET'])
async def get_messages_tg():
    if 'phone_number' not in session:
        return jsonify({'status': 'False', 'error': 'Not authorized'})
    
    dialog_id = request.args['dialog_id']

    try:
        # await client.start()
        messages = await client.get_messages(dialog_id)
        all = {}
        for message in messages:
            info = {}
            info['text'] = message.text
            info['sender'] = message.sender_id
            info['is_reply'] = message.is_reply
            info['is_photo'] = message.photo
            all[dialog_id] = info
    
        return jsonify({'status': 'True', 'messages': all})
    
    except Exception as e:
        return jsonify({'status': 'False', 'error': str(e)})



<<<<<<< HEAD
@app.route('/vk/signup', methods=['GET'])
def sign_up():
    Number = str(request.args['Number'])
    Password = str(request.args['Password'])
    base2[Number] = Password
    return jsonify (base2)
=======
>>>>>>> 069bbccc520f4bdbc09585eadd42b42deacd3e84


if __name__ == '__main__':
    app.run()