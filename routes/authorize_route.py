from flask import request,Response
from models import Person,db
from flask import Blueprint

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
        "Authentication failed",
        status=400,
        )
    if(targetPerson[0].phone!=phone):
        return Response(
        "Authentication failed",
        status=400,
        )
    return targetPerson[0].to_json()
  