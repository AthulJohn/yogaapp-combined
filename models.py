from flask_sqlalchemy import SQLAlchemy
import datetime

db = SQLAlchemy()

class Person(db.Model):
    __tablename__ = 'person'
 
    reg_id = db.Column(db.Integer, primary_key=True)
    name = db.Column(db.String(20),  nullable=False)
    phone=db.Column(db.String(12),nullable=False)
    age = db.Column(db.Integer, nullable=False)
    registerDate = db.Column(db.Date,nullable=False)


 
    def __init__(self,name,phone,age):
        self.name = name
        self.phone=phone
        self.age=age
        self.registerDate=datetime.datetime.now()

    #While fee payment, last fee paid month is updated as present month. As of the current version, user is having having only one option, to complete all his dues.
    def payFee(self):
            self.lastFeePaidMonth=datetime.datetime.now()
            self.lastFeePaidMonth.replace(day=1)


    def to_json(self):
        return {"reg_id":self.reg_id,"name":self.name,"phone":self.phone,"age":self.age,"registerDate":self.registerDate}

class IndividualSlots(db.Model):
    __tablename__ = 'individualslots'
 
    slot_id = db.Column(db.Integer, primary_key=True)
    reg_id = db.Column(db.Integer, db.ForeignKey("person.reg_id"),nullable=False)
    #slot: Stores the slot number of the user for the specified month
    #slot equals to: 1(6-7 AM) / 2(7-8 AM) / 3(8-9 AM) / 4(5-6 PM)
    slot = db.Column(db.Integer,nullable=True)
    month = db.Column(db.Integer,nullable=True)
    year = db.Column(db.Integer,nullable=False)

    personrel=db.relationship("Person",back_populates = "slot")


 
    def __init__(self,reg_id,slot,month,year):
        self.reg_id=reg_id
        self.slot=slot
        self.month=month
        self.year=year

    def changeSlot(self,slot):
        self.changedSlot=slot

    def to_json(self):
        return {"slot_id":self.slot_id,"reg_id":self.reg_id,"slot":self.slot,"month":self.month,"year":self.year}
        

class Transactions(db.Model):
    __tablename__ = 'transactions'
 
    trans_id = db.Column(db.Integer, primary_key=True)
    reg_id = db.Column(db.Integer)#, db.ForeignKey(Person.reg_id),nullable=False)
    fee_till_month = db.Column(db.Integer,nullable=False)
    fee_till_year = db.Column(db.Integer,nullable=False)
    amount_paid = db.Column(db.Float,nullable=False)
    payment_date = db.Column(db.DateTime,nullable=False)
    method = db.Column(db.String(20),nullable=False)
    # user=db.relationship(Person,foreign_keys='person.reg_id')

    def __init__(self,reg_id,method,fee_till_month,fee_till_year,amount_paid):
        self.reg_id=reg_id
        self.fee_till_month=fee_till_month
        self.fee_till_year=fee_till_year
        self.amount_paid=amount_paid
        self.payment_date=datetime.datetime.now()
        self.method=method
        

Person.slot = db.relationship("IndividualSlots", order_by = "IndividualSlots.reg_id", back_populates = "personrel")

