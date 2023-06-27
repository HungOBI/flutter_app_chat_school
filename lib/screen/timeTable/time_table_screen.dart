// ignore_for_file: unused_local_variable, use_build_context_synchronously, avoid_print, non_constant_identifier_names, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  DateTime today = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(40, 85, 174, 1),
        title: const Text(
          'Time Table',
          style: TextStyle(
            fontSize: 18,
            color: Color.fromRGBO(255, 255, 255, 1),
          ),
        ),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 30,
            ),
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                color: Color.fromRGBO(255, 255, 255, 1),
              ),
              child: Container(
                width: double.maxFinite,
                padding: const EdgeInsets.only(
                    top: 30, left: 5, right: 5, bottom: 0),
                child: Column(
                  children: [
                    Container(
                      child: TableCalendar(
                        locale: "en_US",
                        rowHeight: 55,
                        headerStyle: const HeaderStyle(
                            formatButtonVisible: false, titleCentered: true),
                        availableGestures: AvailableGestures.all,
                        selectedDayPredicate: (day) => isSameDay(day, today),
                        calendarStyle: const CalendarStyle(
                          selectedTextStyle: TextStyle(color: Colors.white),
                          todayDecoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                          ),
                          weekendTextStyle: TextStyle(color: Colors.red),
                        ),
                        focusedDay: today,
                        firstDay: DateTime.utc(2023, 1, 1),
                        lastDay: DateTime.utc(2033, 1, 1),
                        onDaySelected: _onDaySelected,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }
}
