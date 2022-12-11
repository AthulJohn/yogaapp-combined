from flask import request,Response
from models import Person,db
from flask import Blueprint

chg_slot_blueprint = Blueprint('changeslot', __name__,)

@chg_slot_blueprint.route('/changeslot', methods = ['PUT'])
def changeslot():
    rid=request.json['reg-id']
    slot=request.json['slot']
    #If the total number of changedslot bookings for the specified month is 50 or above, a Slot Booking Limit Exceeded is returned
    #Known Issue: This function is called in the frontend, without waiting for the response. Thus, the Slot Exceeded error will not be proceeded
    #It can be solved easily, but is not implemented
    if(db.session.query(Person).filter(Person.changedSlot==slot).count()>=50):
        return Response(
        "Slot Booking Limit Exceeded",
        status=400),
    try:
        db.session.query(Person).filter(Person.reg_id==rid).update({Person.changedSlot: slot})
        db.session.commit()
    except:
        return Response(
        "Slot Change failed",
        status=400,
        )
    return {"message": "Slot Changed successfully."}
