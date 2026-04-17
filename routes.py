from flask_login import current_user, login_user
import sqlalchemy as sa
from app import db
from app.models import User

app = Flask(__name__, template_folder='.')
app.secret_key = "tvbloginkey114115"

#tvb userlogin
@app.route('/login', methods=['GET', 'POST'])
def tvb_login(): 
    if current_member:
        print(f"\n Log in to TVB Membership：{current_member}")
        return

    print("\n--- TVB userlogin ---")
    username = input("帳號：")
    password = input("密碼：")

    if username in tvb_users and tvb_users[username] == password:
        current_member = username
        print(f"Login successful! Welcome to TVB，{current_member}！")
    else:
        print("Error: Username or password incorrect.")

#tvb userlogout
@app.route('/logout')
def tvb_logout():
    session.pop('user', None)
    return redirect('/')

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')