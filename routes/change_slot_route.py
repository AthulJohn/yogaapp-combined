from flask import request,Response
from models import Person,db,IndividualSlots
from flask import Blueprint
from custom_functions import getnextmonth

chg_slot_blueprint = Blueprint('changeslot', __name__,)

@chg_slot_blueprint.route('/changeslot', methods = ['PUT'])
def changeslot():
    rid=request.json['reg-id']
    slot=request.json['slot']

    #The next month is calculated
    nextmonth, nextyear = getnextmonth()
    
    #If the total number of changedslot bookings for the specified month is 50 or above, a Slot Booking Limit Exceeded is returned
    #Known Issue: This function is called in the frontend, without waiting for the response. Thus, the Slot Exceeded error will not be proceeded
    #It can be solved easily, but is not implemented
    if(db.session.query(IndividualSlots).filter(IndividualSlots.slot==slot, IndividualSlots.month==nextmonth, IndividualSlots.year==nextyear).count()>=50):
        return Response(
        "Slot Booking Limit Exceeded",
        status=400),
    try:
        print(rid,nextyear,nextmonth,slot)
        db.session.query(IndividualSlots).filter(IndividualSlots.month==nextmonth, IndividualSlots.year==nextyear, IndividualSlots.reg_id==rid).update({IndividualSlots.slot: slot})
        db.session.commit()
    except:
        return Response(
        "Slot Change failed",
        status=400,
        )
    return {"message": "Slot Changed successfully."}
