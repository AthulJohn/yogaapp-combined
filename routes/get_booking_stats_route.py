
from models import Person,db
from flask import Blueprint

stats_blueprint = Blueprint('slotstats', __name__,)

#Returns the number of bookings for each slot
@stats_blueprint.route('/getbookingstats', methods = ['GET'])
def getbookingstats():
    slot1=db.session.query(Person).filter(Person.changedSlot==1).count()
    slot2=db.session.query(Person).filter(Person.changedSlot==2).count()
    slot3=db.session.query(Person).filter(Person.changedSlot==3).count()
    slot4=db.session.query(Person).filter(Person.changedSlot==4).count()
    return{"slot1":slot1,"slot2":slot2,"slot3":slot3,"slot4":slot4}

