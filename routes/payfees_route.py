from flask import request,Response
from models import Person,db
from flask import Blueprint

pay_fees_blueprint = Blueprint('payfees', __name__,)

#Temporary implementation of Payment Functionality
@pay_fees_blueprint.route('/payfees', methods = ['PUT'])
def payfees():
    rid=request.json['reg-id']
    #Target Person is foundout using the registration id
    targetPerson=db.session.query(Person).filter(Person.reg_id==rid)
    if(targetPerson.count()==0):
        return Response(
        "Person not Found",
        status=400,
        )
    #If found, his last fee paid month is set to this month
    targetPerson[0].payFee()
    db.session.commit()
    return {"message": "Fees Payed successfully."}
  