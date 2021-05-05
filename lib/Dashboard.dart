import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  String filterType = "Monthly";
  DateTime today = new DateTime.now();
  String taskPop= "close";
  var monthnames = [
    "JAN",
    "FEB",
    "MAR",
    "APR",
    "MAY",
    "JUN",
    "JUL",
    "AUG",
    "SEP",
    "OCT",
    "NOV",
    "DEC"
  ];
  CalendarController ctrlr = new CalendarController();

  var _TodoTitleController=TextEditingController();

  var _TodoDescriptionController= TextEditingController();

  var _TodoDateController=TextEditingController();

  DateTime _dateTime=DateTime.now();

  _selectedTodoDate(BuildContext context) async{
    var _pickedDate= await showDatePicker(context: context, initialDate: _dateTime, firstDate: DateTime(2000), lastDate: DateTime(2100));
    if(_pickedDate!=null){
      setState(() {
        _dateTime=_pickedDate;
        _TodoDateController.text=DateFormat('yyyy-MM-dd').format(_pickedDate);
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AppBar(
                backgroundColor: Color(0xff000000),
                elevation: 0,
                title: Text(
                  "Dashboard",
                  style: TextStyle(fontSize: 30),
                ),
                actions: [
                  IconButton(
                    icon: Icon(
                      Icons.short_text,
                      color: Colors.white,
                      size: 30,
                    ),
                  )
                ],
              ),
              Container(
                height: 70,
                color: Color(0xff000000),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              changeFilter("Today");
                            },
                            child: Text(
                              "Today",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 4,
                          width: 120,
                          color: (filterType == "Today")
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                            onTap: () {
                              changeFilter("Monthly");
                            },
                            child: Text(
                              "Monthly",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                              ),
                            )),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 4,
                          width: 120,
                          color: (filterType == "Monthly")
                              ? Colors.white
                              : Colors.transparent,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              (filterType == "Monthly")
                  ? TableCalendar(
                calendarController: ctrlr,
                startingDayOfWeek: StartingDayOfWeek.sunday,
                initialCalendarFormat: CalendarFormat.week,
              )
                  : Container(),
              Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Today ${monthnames[today.month - 1]}, ${today.day} ${today.year}",
                                style: TextStyle(fontSize: 18, color: Colors.grey),
                              )
                            ],
                          ),
                        ),
                        taskWidget(Colors.green, "Meeting with chuddy Buddies",
                            "9:00 P.M Sunday"),
                        taskWidget(Colors.red, "Meeting with Sir Mohsin ",
                            "3: 00 P.M Wednesday"),
                        taskWidget(
                            Colors.blue, "Meeting with Cat", "9:00 P.M Everyday"),
                      ],
                    ),
                  )),
              Container(
                height: 100,
                child: Stack(
                  children: [
                    Positioned(
                      bottom: 0,
                      child: Container(
                        height: 90,
                        width: MediaQuery.of(context).size.width,
                        color: Colors.black,
                        padding: EdgeInsets.all(20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.check_circle,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("My Task",
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 15)),
                                ],
                              ),
                            ),
                            Container(
                              width: 60,
                            ),
                            Container(
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.account_circle,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text("Profile",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15)), //Profile button
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: InkWell(
                        onTap:(){
                          showGeneralDialog(
                              context: context,
                              barrierDismissible: true,
                              barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
                              barrierColor: Colors.black,
                              transitionDuration: Duration(microseconds: 200),
                              pageBuilder: (BuildContext context, Animation first,
                                  Animation second){
                                return Scaffold(
                                    appBar: AppBar(
                                      title:Text("Create Todo"),
                                    ),
                                    body:Padding(
                                      padding: EdgeInsets.all(16.0),
                                      child: Column(
                                        children: <Widget>[
                                          TextField(
                                            controller:_TodoTitleController=TextEditingController(),
                                            decoration: InputDecoration(
                                                labelText:"Title",
                                                hintText: 'Write Todo Title'
                                            ),
                                          ),
                                          TextField(
                                            controller:_TodoDescriptionController=TextEditingController(),
                                            decoration: InputDecoration(
                                                labelText:"Description",
                                                hintText: 'Write Description of task'
                                            ),
                                          ),
                                          TextField(
                                            controller:_TodoDateController=TextEditingController(),
                                            decoration: InputDecoration(
                                                labelText:"Date",
                                                hintText: 'Pick a date',
                                                prefixIcon: InkWell(
                                                  onTap: (){
                                                    _selectedTodoDate(context);
                                                  },
                                                  child: Icon(Icons.calendar_today),
                                                )

                                            ),
                                          ),
                                          SizedBox(
                                            height: 40,
                                          ),
                                          ElevatedButton(
                                              onPressed: () {},
                                              child: Text('Save'),
                                            style: ElevatedButton.styleFrom(
                                              primary: Colors.blue
                                            ),
                                              )

                                        ],
                                      ),
                                    )
                                );
                              }
                          );

                        },
                        child: Container(
                          height: 80,
                          width: 80,
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topRight,
                              end: Alignment.bottomLeft,
                              colors: [Colors.blue, Colors.black],
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: Text(
                              "+",
                              style: TextStyle(
                                fontSize: 40,
                                color: Colors.white,
                              ),
                            ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),

              ),
            ],
          ),
        ],
      ),
    );
  }

  openNewTask() {}
  openNewMeeting() {}
  openNewQuiz() {}
  openNewProject() {}
  openTaskPop() {
    taskPop = "open";
    setState(() {});
  }

  closeTaskPop() {
    taskPop = "close";
    setState(() {});
  }

  changeFilter(String filter) {
    filterType = filter;
    setState(() {});
  }

  Slidable taskWidget(Color color, String title, String time) {
    return Slidable(
      child: Container(
        height: 80,
        margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(color: Colors.white, boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            offset: Offset(0, 9),
            blurRadius: 20,
            spreadRadius: 1,
          )
        ]),
        child: Row(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              height: 25,
              width: 25,
              decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(color: color, width: 4)),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.black, fontSize: 18),
                ),
                Text(
                  time,
                  style: TextStyle(color: Colors.grey, fontSize: 18),
                ),
              ],
            ),
            Expanded(
              child: Container(),
            ),
            Container(
              height: 50,
              width: 5,
              color: color,
            )
          ],
        ),
      ),
      secondaryActions: [
        IconSlideAction(
          caption: "Edit",
          color: Colors.white,
          icon: Icons.edit,
          onTap: () {},
        ),
        IconSlideAction(
          caption: "Delete",
          color: color,
          icon: Icons.delete,
          onTap: () {},
        )
      ],
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.3,
    );
  }
}