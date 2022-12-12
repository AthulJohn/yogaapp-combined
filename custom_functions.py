import datetime

def getnextmonth():
    nextmonth=datetime.datetime.now().month+1
    nextyear=datetime.datetime.now().year
    if(nextmonth==13):
        nextmonth=1
        nextyear=nextyear+1
    return nextmonth,nextyear