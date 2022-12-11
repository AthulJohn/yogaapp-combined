from flask import Flask,render_template,request
from flask_migrate import Migrate
from models import Person,db
from flask import Response
from apscheduler.schedulers.background import BackgroundScheduler
import time
import atexit
 
app = Flask(__name__)
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://yogaapp_user:7aEjMGhA9mZwtPq6LNZjCY0vNvhMLmYv@dpg-ceaneqmn6mphc8u1dgjg-a/yogaapp"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False
db.init_app(app)
migrate = Migrate(app, db)

def resetSlot():
    db.session.query(Person).update({Person.slot: Person.changedSlot})
    db.session.commit()

scheduler = BackgroundScheduler()
scheduler.add_job(func=resetSlot, trigger="cron" , hour= '1', minute= '1',day=1,month='*')
scheduler.start()

#general Flask Code
@app.route('/')
def index():
    return "Hello World"

@app.route('/register', methods = ['POST'])
def register():
    db.create_all()
    name = request.json['name']
    age = request.json['age']
    slot=request.json['slot']
    phone=request.json['phone']
    new_user = Person(name=name,phone=phone, age=int(age),slot=int(slot))
    db.session.add(new_user)
    db.session.commit()
    return {'id':db.session.query(Person).filter(Person.name==name).first().reg_id}

@app.route('/changeslot', methods = ['PUT'])
def changeslot():
    rid=request.json['reg-id']
    slot=request.json['slot']
    try:
        db.session.query(Person).filter(Person.reg_id==rid).update({Person.changedSlot: slot})
        db.session.commit()
    except:
        return Response(
        "Slot Change failed",
        status=400,
        )
    return {"message": "Slot Changed successfully."}

#This is only a temporary authorization. For permanent authorization, we will use a different method, like password or otp.
#This authorization is not secure as the users registration id and phone number is used to the purpose, 
#   and also because GET request is used.
@app.route('/authorize', methods = ['GET'])
def authorize():
    rid=request.args['reg-id']
    phone=request.args['phone']
    targetPerson=db.session.query(Person).filter(Person.reg_id==rid)
    if(targetPerson.count()==0):
        return Response(
        "Authentication failed",
        status=400,
        )
    if(targetPerson[0].phone!=phone):
        return Response(
        "Authentication failed",
        status=400,
        )
    return targetPerson[0].to_json()
  
@app.route('/payfees', methods = ['PUT'])
def payfees():
    rid=request.json['reg-id']
    targetPerson=db.session.query(Person).filter(Person.reg_id==rid)
    if(targetPerson.count()==0):
        return Response(
        "Person not Found",
        status=400,
        )
    targetPerson[0].payFee()
    # values(reg_id=0,name=name,age=age,slot=1)
    db.session.commit()
    return {"message": "Fees Payed successfully."}
  
@app.route('/getfeestatus', methods = ['GET'])
def getfeestatus():
    rid=request.args['reg-id']
    targetPerson=db.session.query(Person).filter(Person.reg_id==rid)
    if(targetPerson.count()==0):
        return Response(
        "Person not found",
        status=400,
        )
    result=targetPerson[0].getFeeStatus()
    return result

if __name__ == '__main__':
    app.run(debug=True)

