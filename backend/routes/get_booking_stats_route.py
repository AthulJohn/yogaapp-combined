
from models import IndividualSlots,db
from flask import Blueprint
from custom_functions import getnextmonth

stats_blueprint = Blueprint('slotstats', __name__,)

#Returns the number of bookings for each slot
@stats_blueprint.route('/getbookingstats', methods = ['GET'])
def getbookingstats():
    #The next month is calculated
    
    (nextmonth, nextyear) = getnextmonth()
    slot1=db.session.query(IndividualSlots).filter(IndividualSlots.slot==1 , IndividualSlots.month==nextmonth , IndividualSlots.year==nextyear ).count()
    slot2=db.session.query(IndividualSlots).filter(IndividualSlots.slot==2 , IndividualSlots.month==nextmonth , IndividualSlots.year==nextyear ).count()
    slot3=db.session.query(IndividualSlots).filter(IndividualSlots.slot==3 , IndividualSlots.month==nextmonth , IndividualSlots.year==nextyear ).count()
    slot4=db.session.query(IndividualSlots).filter(IndividualSlots.slot==4 , IndividualSlots.month==nextmonth , IndividualSlots.year==nextyear ).count()
    return{"slot1":slot1,"slot2":slot2,"slot3":slot3,"slot4":slot4}

