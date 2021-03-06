import 'package:birthday/Client/Birthday.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'BirthdayList.dart';

class AddBirthday extends StatefulWidget {
  @override
  _AddBirthdayState createState() => _AddBirthdayState();
}

List<Birthdaylist> currentlist = [];
var titleclr;
var eventclr;
var dateclr;
var datef;
var timeclr;

class _AddBirthdayState extends State<AddBirthday> {
  var titleclr;
  TimeOfDay _currentTime = TimeOfDay.now();
  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? pickTime = await showTimePicker(
      context: context,
      initialTime: _currentTime,
    );
    if (pickTime != null) {
      setState(() {
        _currentTime = pickTime;
        dateclr = _currentdate.year;
      });
    }
  }

  DateTime _currentdate = DateTime.now();
  Future<void> _selectdate(BuildContext context) async {
    final DateTime? pickdate = await showDatePicker(
        context: context,
        initialDate: _currentdate,
        firstDate: DateTime(1900),
        lastDate: DateTime(2099));

    if (pickdate != null && pickdate != _currentdate) {
      setState(() {
        _currentdate = pickdate;
        datef =
            '${_currentdate.day}-${_currentdate.month}-${_currentdate.year}';
        print(_currentdate.toString());
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.all(5),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Column(
                  children: [
                    customAppbar(),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                      width: MediaQuery.of(context).size.width * 0.08,
                    ),
                    Text('Add Reminder',
                        style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 20,
                              color: Colors.black),
                        )),
                  ],
                ),
                Container(
                    child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      onChanged: (val) {
                        setState(() {
                          titleclr = val;
                          print(titleclr);
                        });
                      },
                      decoration: InputDecoration(
                        hintText: 'Name of Birthday Boy/Girl',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      onTap: () {},
                      decoration: InputDecoration(
                        hintText: 'Write about the event',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      onTap: () {
                        dateclr = _selectdate(context);
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.calendar_today_rounded),
                        hintText:
                            '${_currentdate.day}-${_currentdate.month}-${_currentdate.year}',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 30, right: 30),
                    child: TextField(
                      onTap: () {
                        timeclr = _selectTime(context);
                      },
                      readOnly: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.access_time_filled_outlined),
                        hintText: '${_currentTime.format(context)} ',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ])),
                SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 110,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          print('Cleared');
                        },
                        child: Text(
                          'Clear',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                          )),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      width: 110,
                      height: 35,
                      decoration: BoxDecoration(
                          color: Colors.teal[500],
                          borderRadius: BorderRadius.circular(20)),
                      child: TextButton(
                        onPressed: () {
                          currentlist.add(Birthdaylist(
                              title: titleclr,
                              date: dateclr,
                              time: timeclr,
                              datef: datef,
                              event: eventclr));
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return Birthday(
                              nclist: currentlist,
                            );
                          }));
                          showDialog(
                              context: context,
                              builder: (BuildContext context) =>
                                  _buildPopupDialog(context));
                        },
                        child: Text(
                          'Save',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                            color: Colors.white,
                          )),
                        ),
                        style: ButtonStyle(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  customAppbar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: Colors.black,
          )),
      elevation: 0,
      centerTitle: true,
      title: Text(
        'Remind Me',
        style: GoogleFonts.poppins(
            textStyle: TextStyle(
          color: Colors.black,
          fontSize: 17,
          fontWeight: FontWeight.bold,
        )),
      ),
    );
  }
}

Widget _buildPopupDialog(BuildContext context) {
  return new AlertDialog(
    elevation: 300,
    content: new Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text("Birthday Saved ! We will Notifiy You Once Birthday Day Reach"),
      ],
    ),
    actions: <Widget>[
      // ignore: deprecated_member_use
      new FlatButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        textColor: Theme.of(context).primaryColor,
        child: const Text('Done'),
      ),
    ],
  );
}
