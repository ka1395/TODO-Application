import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:todo/controllers/task_controller.dart';
import 'package:todo/models/task.dart';
import 'package:todo/ui/theme.dart';
import 'package:todo/ui/widgets/button.dart';

import '../widgets/input_field.dart';

class AddTaskPage extends StatefulWidget {
  const AddTaskPage({Key? key}) : super(key: key);

  @override
  State<AddTaskPage> createState() => _AddTaskPageState();
}

class _AddTaskPageState extends State<AddTaskPage> {
  final TaskController taskController = Get.put(TaskController());
  final TextEditingController titleController = TextEditingController();
  final TextEditingController noteController = TextEditingController();
  DateTime selecteDate = DateTime.now();
  String startTime = DateFormat('hh:mm a').format(DateTime.now()).toString();
  String endtTime = DateFormat('hh:mm a')
      .format(DateTime.now().add(const Duration(minutes: 15)))
      .toString();
  int selectRemind = 5;
  List<int> remindList = [5, 10, 15, 20];
  String selecteRepeat = 'None';
  List<String> repeatdList = ['None', 'Daily', 'weekly', 'Monthly'];
  int selectColor = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.theme.backgroundColor,
      appBar: appbar(),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
            child: Column(
          children: [
            Text(
              'Add Task',
              style: headingStyle,
            ),
            InputField(
              title: 'Title',
              hint: 'Enter title here',
              controller: titleController,
            ),
            InputField(
              title: 'Note',
              hint: 'Enter note here',
              controller: noteController,
            ),
            InputField(
              title: 'Date',
              hint: DateFormat.yMd().format(selecteDate).toString(),
              widget: IconButton(
                onPressed: () => getDateFromUser(),
                icon: Icon(
                  Icons.calendar_today_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: InputField(
                    title: 'Start Time',
                    hint: startTime,
                    widget: IconButton(
                      onPressed: () => getTimeFromUser(isStart: true),
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: InputField(
                    title: 'End Time',
                    hint: endtTime,
                    widget: IconButton(
                      onPressed: () => getTimeFromUser(isStart: false),
                      icon: Icon(
                        Icons.access_time_rounded,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            InputField(
              title: 'Remind',
              hint: '$selectRemind minutes early',
              widget: Row(
                children: [
                  DropdownButton<int>(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: remindList
                          .map<DropdownMenuItem<int>>(
                            (Value) => DropdownMenuItem(
                              value: Value,
                              child: Text(
                                '$Value',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(height: 0),
                      style: subtitleStyle,
                      onChanged: (int? NewValue) {
                        setState(() {
                          selectRemind = NewValue!;
                        });
                      }),
                  SizedBox(width: 6),
                ],
              ),
            ),
            InputField(
              title: 'Repeat',
              hint: selecteRepeat,
              widget: Row(
                children: [
                  DropdownButton<String>(
                      dropdownColor: Colors.blueGrey,
                      borderRadius: BorderRadius.circular(10),
                      items: repeatdList
                          .map<DropdownMenuItem<String>>(
                            (Value) => DropdownMenuItem(
                              value: Value.toString(),
                              child: Text(
                                '$Value',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                          .toList(),
                      icon: Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                      iconSize: 32,
                      elevation: 4,
                      underline: Container(height: 0),
                      style: subtitleStyle,
                      onChanged: (String? NewValue) {
                        setState(() {
                          selecteRepeat = NewValue!;
                        });
                      }),
                  SizedBox(width: 6),
                ],
              ),
            ),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                colorPalette(),
                MyButton(
                  lable: 'Creat Taske',
                  ontab: () {
                    validatData();
                  },
                )
              ],
            )
          ],
        )),
      ),
    );
  }

  validatData() {
    if (titleController.text.isNotEmpty && noteController.text.isNotEmpty) {
      addTaskToDb();
      Get.back();
    } else if (titleController.text.isEmpty || noteController.text.isEmpty) {
      Get.snackbar('required', 'all fields are required',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.white,
          colorText: primaryClr,
          icon: const Icon(
            Icons.warning_amber_outlined,
            color: Colors.red,
          ));
    } else
      print('something bad happend');
  }

  addTaskToDb() async {
    int value = await taskController.addTask(
        task: Task(
      title: titleController.text,
      note: noteController.text,
      isCompleted: 0,
      color: selectColor,
      remind: selectRemind,
      repeat: selecteRepeat,
      date: DateFormat.yMd().format(selecteDate),
      startTime: startTime,
      endTime: endtTime,
    ));
    print(value);
  }

  AppBar appbar() => AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: context.theme.backgroundColor,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: Icon(
            Icons.arrow_back,
            size: 24,
            color: primaryClr,
          ),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage('images/person.jpeg'),
          ),
          SizedBox(
            width: 20,
          )
        ],
      );

  Column colorPalette() {
    return Column(
      children: [
        Text(
          'Color',
          style: titleStyle,
        ),
        SizedBox(height: 8),
        Wrap(
          direction: Axis.horizontal,
          children: List.generate(
            3,
            (index) => GestureDetector(
                onTap: () {
                  setState(() {
                    selectColor = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: CircleAvatar(
                    child: selectColor == index
                        ? Icon(
                            Icons.done,
                            size: 16,
                            color: Colors.white,
                          )
                        : null,
                    radius: 14,
                    backgroundColor: index == 0
                        ? primaryClr
                        : index == 1
                            ? pinkClr
                            : orangeClr,
                  ),
                )),
          ),
        )
      ],
    );
  }

  getTimeFromUser({required bool isStart}) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: isStart
          ? TimeOfDay.fromDateTime(DateTime.now())
          : TimeOfDay.fromDateTime(
              DateTime.now().add(const Duration(minutes: 15))),
    );
    String formattedTime = pickedTime!.format(context);
    if (isStart)
      setState(() => startTime = formattedTime);
    else if (!isStart)
      setState(() => endtTime = formattedTime);
    else
      print('time canceld or something is wrong');
  }

  getDateFromUser() async {
    DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: selecteDate,
        firstDate: DateTime(2015),
        lastDate: DateTime(2030));
    if (pickedDate != null) {
      setState(() {
        selecteDate = pickedDate;
      });
    }
  }
}
