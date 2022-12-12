# yogaapp-combined

Yoga App Frontend and backend combined

A Mobile App is made using flutter. It is also deployed as a web app, but the UI is best suited for a mobile.

Working Web App Link: https://yoga-app-f6f3a.web.app/#/

<h3>Features:</h3>
This app includes the asked features, that is Registration, Slot Changing, and Fee Payment.<br>
Apart from that, a small <i>know more<i> screen is included for users to know about the yoga class.<br>
Also, users can see thier current slot, next month's slot, thier due fees, registration ID etc.

Proper Authentication is not done, but inorder to identify users, Thier Registration Id, as well as phone number is used.

Anothr feature of the app is its slot availability indication. A colored dot will be displayed while slot selection, whose color indicates slots availability, green being available, and red begin not available, with intermediate colors, to show such stages.

<h3>Assumptions Made:</h3>
This app is assumed to be made for an institute named Nirvana Yoga Training.
Also, All the slots is given a limit of 50, and if a slot in a month has 50 registrations, then the slot will be unavailable.

<h3>Database Design:</h3>
3 tables are used for data storage:<br>
Person table to store the details of people<br>
Slot Table, to store slot details.<br>
Transactions Table, to store all transaction details.

ER Diagram:
![ER Diagram](ER-Diagram.png)

<h3>Tech Stacks used:</h3>
Frontend Built using Flutter<br>
Backend built using Flask,SQLAlchemy<br>
Database used: PostgreSQL<br>
API and database hosted on Render.com<br>
Web App hosted on Firebase




