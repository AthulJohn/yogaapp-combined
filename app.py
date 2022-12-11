from flask import Flask
from flask_migrate import Migrate
from models import Person,db
from routes.register_route import register_blueprint
from routes.authorize_route import auth_blueprint
from routes.payfees_route import pay_fees_blueprint
from routes.get_booking_stats_route import stats_blueprint
from routes.change_slot_route import chg_slot_blueprint
from apscheduler.schedulers.background import BackgroundScheduler

 
app = Flask(__name__)

#Below URL contains sensitive data. Should be hide in production level
app.config['SQLALCHEMY_DATABASE_URI'] = "postgresql://yogaapp_user:7aEjMGhA9mZwtPq6LNZjCY0vNvhMLmYv@dpg-ceaneqmn6mphc8u1dgjg-a/yogaapp"
#URL for Local Host:  
# app.config['SQLALCHEMY_DATABASE_URI']="postgresql://postgres:noobie@localhost:5432/yogaapp"
app.config['SQLALCHEMY_TRACK_MODIFICATIONS'] = False

#SQLAlchemy is used to manage the database
db.init_app(app)
migrate = Migrate(app, db)

#resetSlot function is scheduled to be called at the beginning of every month. It will update the slot of each person as thier changedSlot
#Not yet tested
def resetSlot():
    db.session.query(Person).update({Person.slot: Person.changedSlot})
    db.session.commit()

#apscheduler used to schedule the resetSlot function.
#A cron trigger is used, to trigger at 1:1 on the first day of every month
scheduler = BackgroundScheduler()
scheduler.add_job(func=resetSlot, trigger="cron" , hour= '1', minute= '1',day='1',month='*')
scheduler.start()

#general Flask Code
@app.route('/')
def index():
    return "Yoga Class API. Available endpoints: /register (POST), /changeslot (PUT), /authorize (GET), /payfees (PUT), getbookingstats (GET)"


app.register_blueprint(auth_blueprint)
app.register_blueprint(chg_slot_blueprint)
app.register_blueprint(stats_blueprint)
app.register_blueprint(pay_fees_blueprint)
app.register_blueprint(register_blueprint)

#routes Folder contains various route functions

if __name__ == '__main__':
    app.run()

