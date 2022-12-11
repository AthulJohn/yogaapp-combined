from flask_sqlalchemy import SQLAlchemy
import datetime

db = SQLAlchemy()
 
class Person(db.Model):
    __tablename__ = 'person'
 
    reg_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20),  nullable=False)
    phone=db.Column(db.String(12),nullable=False)
    age = db.Column(db.Integer, nullable=False)
    slot = db.Column(db.Integer, nullable=False)
    changedSlot = db.Column(db.Integer,nullable=True)
    lastFeePaidMonth = db.Column(db.Date,nullable=True)
    registerDate = db.Column(db.Date,nullable=False)


 
    def __init__(self,name,phone,age,slot):
        self.name = name
        self.phone=phone
        self.age=age
        self.slot=slot
        self.changedSlot=slot
        self.registerDate=datetime.datetime.now()

    def changeSlot(self,slot):
        self.changedSlot=slot

    def payFee(self):
        if(self.lastFeePaidMonth==None):
            self.lastFeePaidMonth=self.registerDate
            self.lastFeePaidMonth.replace(day=1)
        else:
            self.lastFeePaidMonth=datetime.datetime.now()
            self.lastFeePaidMonth.replace(day=1)


    def to_json(self):
        return {"reg_id":self.reg_id,"name":self.name,"phone":self.phone,"age":self.age,"slot":self.slot,"changedSlot":self.changedSlot,"lastFeePaidMonth":str(self.lastFeePaidMonth),"registerDate":str(self.registerDate)}
    
    def __str__(self):
        return f"{self.reg_id}:{self.name}({self.age})"
 
    def __repr__(self):
        return f"{self.reg_id}:{self.name}({self.age})"