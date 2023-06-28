import 'dart:math';

import 'package:app_chat/screen/time/dataBaseHelper.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

import 'card_item.dart';

class TimeTableScreen extends StatefulWidget {
  const TimeTableScreen({Key? key}) : super(key: key);

  @override
  State<TimeTableScreen> createState() => _TimeTableScreenState();
}

class _TimeTableScreenState extends State<TimeTableScreen> {
  DateTime today = DateTime.now();
  List<CardItem> fakeCardItems = [];
  late DatabaseHelper databaseHelper;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _contentController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  @override
  void initState() {
    super.initState();
    databaseHelper = DatabaseHelper();
    _loadCardItems();
  }

  void _loadCardItems() async {
    List<Map<String, dynamic>> data = await databaseHelper.getData();
    setState(() {
      fakeCardItems = data
          .map((row) => CardItem(
                time: row['time'],
                date: row['date'],
                title: row['title'],
                content: row['content'],
                status: row['status'],
                id: row['id'],
                onDelete: (int) {},
              ))
          .toList();
    });
  }

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
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.40,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              color: Color.fromRGBO(255, 255, 255, 1),
            ),
            child: TableCalendar(
              locale: "en_US",
              rowHeight: 45,
              headerStyle: const HeaderStyle(
                formatButtonVisible: false,
                titleCentered: true,
              ),
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
          ),
          Container(
            color: const Color.fromRGBO(255, 255, 255, 1),
            alignment: Alignment.center,
            child: IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Add Task'),
                    content: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                            ),
                            onPressed: () async {
                              final TimeOfDay? selectedTime =
                                  await showTimePicker(
                                context: context,
                                initialTime: TimeOfDay.now(),
                              );
                              if (selectedTime != null) {
                                setState(() {
                                  today = DateTime(
                                    today.year,
                                    today.month,
                                    today.day,
                                    selectedTime.hour,
                                    selectedTime.minute,
                                  );
                                });
                                _timeController.text =
                                    DateFormat.Hm().format(today);
                              }
                            },
                            child: Text(
                              _timeController.text.isEmpty
                                  ? '00 : 00'
                                  : _timeController.text,
                              style: const TextStyle(
                                  fontSize: 30,
                                  color: Color.fromARGB(255, 0, 0, 0)),
                            ),
                          ),
                          TextFormField(
                            controller: _titleController,
                            decoration: const InputDecoration(
                              labelText: 'Title',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the title';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            controller: _contentController,
                            decoration: const InputDecoration(
                              labelText: 'Content',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter the content';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _addCardItem();
                            _clearInputFields();
                            Navigator.of(context).pop();
                          }
                        },
                        child: const Text('Add'),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                    ],
                  ),
                );
              },
              icon: const Icon(
                Icons.add,
                size: 40,
                color: Color.fromRGBO(245, 1, 123, 1),
              ),
            ),
          ),
          Expanded(
            child: Container(
              color: const Color.fromRGBO(255, 255, 255, 1),
              child: ListView.builder(
                itemCount: fakeCardItems.length,
                itemBuilder: (context, index) {
                  final cardItem = fakeCardItems[index];
                  return CardItem(
                    time: cardItem.time,
                    date: cardItem.date,
                    title: cardItem.title,
                    content: cardItem.content,
                    status: cardItem.status,
                    id: cardItem.id,
                    onDelete: _deleteCardItem,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _deleteCardItem(int id) async {
    int deletedRows = await databaseHelper.deleteData(id);
    if (deletedRows > 0) {
      setState(() {
        fakeCardItems.removeWhere((item) => item.id == id);
      });
    }
  }

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      today = day;
    });
  }

  void _clearInputFields() {
    _titleController.clear();
    _contentController.clear();
  }

  void _addCardItem() async {
    String time = DateFormat.Hm().format(today);
    String date = DateFormat.yMd().format(today);
    String title = _titleController.text;
    String content = _contentController.text;

    Map<String, dynamic> row = {
      'time': time,
      'date': date,
      'title': title,
      'content': content,
      'status': 'Pending',
    };
    int id = Random().nextInt(10000);
    int insertedId = await databaseHelper.insertData(row, id);
    if (id != 0) {
      setState(() {
        fakeCardItems.add(CardItem(
          time: time,
          date: date,
          title: title,
          content: content,
          status: 'Pending',
          id: insertedId,
          onDelete: (int) {},
        ));
      });
    }
  }
}
