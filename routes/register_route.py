from flask import request,Response
from models import Person,db
from flask import Blueprint

register_blueprint = Blueprint('register', __name__,)

#Adds a new user to the database.
@register_blueprint.route('/register', methods = ['POST'])
def register():
    db.create_all()
    name = request.json['name']
    age = request.json['age']
    slot=request.json['slot']
    phone=request.json['phone']
    new_user = Person(name=name,phone=phone, age=int(age),slot=int(slot))
    
    #User is added to the database, only if the slot is not full
    if(db.session.query(Person).filter(Person.slot==slot).count()>50):
        return Response(
        "Slot Booking Limit Exceeded",
        status=400),
    db.session.add(new_user)
    db.session.commit()
    #The registration id is returned to the user
    #This is used for payment
    return {'id':db.session.query(Person).filter(Person.name==name).first().reg_id}
