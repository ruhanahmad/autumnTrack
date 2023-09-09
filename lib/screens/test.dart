import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyTimePickerField(),
    );
  }
}

class MyTimePickerField extends StatefulWidget {
  @override
  _MyTimePickerFieldState createState() => _MyTimePickerFieldState();
}

class _MyTimePickerFieldState extends State<MyTimePickerField> {
  TimeOfDay? _selectedTime;
  TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _selectedTime!.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Time Picker Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _selectTime(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _timeController,
                  decoration: InputDecoration(
                    labelText: 'Select Time',
                    hintText: 'Select Time',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}







class MyDatePickerField extends StatefulWidget {
  @override
  _MyDatePickerFieldState createState() => _MyDatePickerFieldState();
}

class _MyDatePickerFieldState extends State<MyDatePickerField> {
  DateTime? _selectedDate;
  TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GestureDetector(
              onTap: () => _selectDate(context),
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Select Date',
                    hintText: 'Select Date',
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
