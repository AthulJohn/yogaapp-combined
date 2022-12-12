from flask import request,Response
from models import Person,db,Transactions
from flask import Blueprint
import datetime

pay_fees_blueprint = Blueprint('payfees', __name__,)

#Temporary implementation of Payment Functionality
@pay_fees_blueprint.route('/payfees', methods = ['PUT'])
def payfees():
    rid=request.json['reg-id']
    method=request.json['method']
    amount=request.json['amount']

    #Target Person is foundout using the registration id
    targetPerson=db.session.query(Person).filter(Person.reg_id==rid)
    if(targetPerson.count()==0):
        return Response(
        "Person not Found",
        status=400,
        )
    new_transaction=Transactions(reg_id=rid,method=method,fee_till_month=datetime.datetime.now().month,fee_till_year=datetime.datetime.now().year,
    amount_paid=float(amount))
    db.session.add(new_transaction)
    #If found, his last fee paid month is set to this month
    db.session.commit()
    return {"message": "Fees Payed successfully."}
  