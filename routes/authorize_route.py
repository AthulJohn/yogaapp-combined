from flask import request,Response,jsonify
from models import Person,db,IndividualSlots,Transactions
from flask import Blueprint
import datetime

auth_blueprint = Blueprint('authorize', __name__,)

#This is only a temporary authorization. For permanent authorization, we will use a different method, like password or otp.
#This authorization is not secure as the users registration id and phone number is used to the purpose, 
#   and also because GET request is used.
@auth_blueprint.route('/authorize', methods = ['GET'])
def authorize():
    rid=request.args['reg-id']
    phone=request.args['phone']
    targetPerson=db.session.query(Person).filter(Person.reg_id==rid)
    if(targetPerson.count()==0):
        return Response(
        "Authentication failed - Person not Found",
        status=400,
        )
    if(targetPerson[0].phone!=phone):
        return Response(
        "Authentication failed - Phone Number Mismatch",
        status=400,
        )

    resultDict=targetPerson[0].to_json()

    targetPersonSlot=db.session.query(IndividualSlots).filter(IndividualSlots.reg_id==rid , IndividualSlots.month==datetime.datetime.now().month , IndividualSlots.year==datetime.datetime.now().year).first()
    if(datetime.datetime.now().month==12):
        targetPersonNextMonthSlot=db.session.query(IndividualSlots).filter(IndividualSlots.reg_id==rid , IndividualSlots.month==1 , IndividualSlots.year==datetime.datetime.now().year+1).first()
    else:
        targetPersonNextMonthSlot=db.session.query(IndividualSlots).filter(IndividualSlots.reg_id==rid , IndividualSlots.month==datetime.datetime.now().month+1 , IndividualSlots.year==datetime.datetime.now().year).first()
    resultDict.update({"slot":targetPersonSlot.slot,"changedslot":targetPersonNextMonthSlot.slot})
    
    feePaidMonth=datetime.datetime.now()
    targetPersonPayments=db.session.query(Transactions).filter(Transactions.reg_id==rid)
    if(targetPersonPayments.count()==0):
        resultDict.update({"feePaidMonth":None})
    else:
        targetPersonPayment=targetPersonPayments[-1]
        feePaidMonth.replace(year=targetPersonPayment.fee_till_year,month=targetPersonPayment.fee_till_month,day=1)
        resultDict.update({"feePaidMonth":str(feePaidMonth)})

    return jsonify(resultDict)
  