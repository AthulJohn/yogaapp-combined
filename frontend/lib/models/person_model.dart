import 'package:flutter/cupertino.dart';

import '../constants/values.dart';

///[Person] Model stores the data of each user.
///The data is stored either when a user registers or when a user authorizes.
///[name],[phone],[age],[slot] are the datafields visible to the user.
///[changedslot] is the slot to which the user has changed.
///[feePaidMonth] is the last month for which the user has paid the fee.
///[registerDate] is the date on which the user registered.
///[id] is the registration id of the user.
class Person extends ChangeNotifier {
  String name, phone;
  int slot, age;
  int? changedslot;
  DateTime? feePaidMonth, registerDate;
  int id;
  Person(
      {required this.name,
      required this.phone,
      required this.slot,
      required this.age,
      this.id = -1,
      this.changedslot,
      this.feePaidMonth,
      this.registerDate});

  Person.empty()
      : this(
          name: "",
          phone: "",
          slot: -1,
          age: -1,
        );

  Person.fromJson(Map<String, dynamic> json)
      : this(
          name: json["name"],
          phone: json["phone"],
          slot: json["slot"],
          age: json["age"],
          id: json["reg_id"],
          changedslot: json["changedSlot"],
          feePaidMonth: DateTime.tryParse(json["lastFeePaidMonth"] ?? ""),
          registerDate: DateTime.tryParse(json["registerDate"] ?? ""),
        );

  Map<String, dynamic> toJson() {
    return {
      "name": name,
      "phone": phone,
      "slot": "$slot",
      "age": "$age",
    };
  }

  ///Get data from another person object
  ///Used to add data to the provider person object from another temporary object
  void setPerson(Person p) {
    name = p.name;
    phone = p.phone;
    slot = p.slot;
    age = p.age;
    id = p.id;
    changedslot = p.changedslot;
    feePaidMonth = p.feePaidMonth;
    registerDate = p.registerDate;
    notifyListeners();
  }

  void changeSlot(int val) {
    changedslot = val;
    notifyListeners();
  }

  void payFees() {
    feePaidMonth = DateTime.now();
    notifyListeners();
  }

  ///Returns the fees status of the user.
  ///Will be "RNP"|"P"|"D"|"M"
  ///
  ///RNP: Registration Fees not Paid
  ///
  ///P: No Fees Due (Paid)
  ///
  ///D: Fees Due for 1 month
  ///
  ///M: Fees due for Multiple months
  String get getFeesStatus {
    if (feePaidMonth == null) {
      return "RNP"; //"Registration Fees not Paid";
    }
    if (feePaidMonth!.month == DateTime.now().month) {
      return "P"; //"No Fees Due (Paid)";
    } else if ((feePaidMonth!.month) % 12 + 1 == DateTime.now().month)
    //Equation to check whether the feePaidMonth is the current previous month
    //%12 is added, inorder to get January when the month is December
    //So when month=12, (month)%12+1=1
    //For all other cases, (month)%12+1=month+1, as month<12
    {
      return "D"; //"Fees Due for 1 month";
    } else {
      return "M"; // Fees due for Multiple months
    }
  }

  ///Returns the number of months for which the fees are due.
  int get getDueMonths {
    int no = 0;
    if (feePaidMonth == null) {
      if (registerDate == null) return 1;
      //If the user has not paid the registration fees, then the fees are due from the month of registration
      //So the number of months due is calculated from the month of registration
      //First, Number of years is calculated by subtracting the year of registration from the current year
      //It is multiplied by 12 to get the number of months in those years
      no = (DateTime.now().year - registerDate!.year) * 12;
      //Then the number of months is calculated by subtracting the month of registration from the current month
      //If the month of registration is greater than the current month, then the number of months is negative
      //It happens only if the years are different.
      //In that case, since we added more months than required, we add the negative value to the number of months, to get the correct value
      //Eg: Registration in December 2020, current month is January 2021
      //So, Year Difference=1, Month Difference=-11
      //So, Number of months due=(1*12)+(-11)=1
      //Then 1 is added to it, as the month of registration is also counted
      no += (DateTime.now().month - registerDate!.month + 1);
      return no;
    }
    if (feePaidMonth!.month == DateTime.now().month) {
      //If the user has paid the fees for the current month, then no fees are due
      return 0;
    } else {
      //Same principle as above is used here
      //But the number of months due is calculated from the month of last fee payment
      no = (DateTime.now().year - feePaidMonth!.year) * 12;
      //Also, 1 is not added, as the last fee paid month should not be calculated
      no += (DateTime.now().month - feePaidMonth!.month);
      return no;
    }
  }

  ///Returns the fees status of the user in a message form.
  String get getBeutifiedFeesStatus {
    if (feePaidMonth == null) {
      return "Registration Fees not Paid";
    }
    if (feePaidMonth!.month == DateTime.now().month) {
      return "No Fees Due (Paid)";
    } else {
      return "Fees Due from ${months[feePaidMonth!.month - 1]}";
    }
  }
}
