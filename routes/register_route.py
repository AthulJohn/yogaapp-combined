from flask import request,Response,Blueprint,jsonify
from models import Person,db,IndividualSlots
from custom_functions import getnextmonth

register_blueprint = Blueprint('register', __name__,)

#Adds a new user to the database.
@register_blueprint.route('/register', methods = ['POST'])
def register():
    db.create_all()
    name = request.json['name']
    age = request.json['age']
    slot=request.json['slot']
    phone=request.json['phone']
    new_user = Person(name=name,phone=phone, age=int(age))
    
    #User is added to the database, only if the slot is not full
    if(db.session.query(IndividualSlots).filter(IndividualSlots.slot==int(slot) , IndividualSlots.month==new_user.registerDate.month , IndividualSlots.year==new_user.registerDate.year).count()>50):
        return Response(
        "Slot Booking Limit Exceeded",
        status=400),
    db.session.add(new_user)

    #Two slots are added to the database, one for the current month and one for the next month
    #To add slot, register ID is required. So, the register ID is fetched from the database (the last record with the same name will be the target record)
    (nextmonth, nextyear) = getnextmonth()
    new_user.reg_id=db.session.query(Person).filter(Person.name==name)[-1].reg_id
    new_slot=IndividualSlots(slot=slot,reg_id=new_user.reg_id,month=new_user.registerDate.month,year=new_user.registerDate.year)
    next_slot=IndividualSlots(slot=slot,reg_id=new_user.reg_id,month=nextmonth,year=nextyear)
    db.session.add(new_slot)
    db.session.add(next_slot)
    db.session.commit()
    #The registration id is returned to the user
    #This is used for payment
    return {'id':db.session.query(Person).filter(Person.name==name)[-1].reg_id}
