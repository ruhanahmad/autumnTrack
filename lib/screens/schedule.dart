import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';

import 'userController.dart';


class ScheduledScreen extends StatefulWidget {
  @override
  State<ScheduledScreen> createState() => _ScheduledScreenState();
}

class _ScheduledScreenState extends State<ScheduledScreen> {


   UserContoller userContoller = Get.put(UserContoller()); 



  TimeOfDay? _selectedTime;
  TextEditingController _timeController = TextEditingController();

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime ?? TimeOfDay.now(),
        builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _selectedTime!.format(context);
      });
      print(_selectedTime);
    }
  }


String convertTo12HourFormat(String time24Hour) {
  final List<String> parts = time24Hour.split(':');
   int hour = int.parse(parts[0]);
  final int minute = int.parse(parts[1]);

  String period = 'AM';

  if (hour >= 12) {
    period = 'PM';
  }

  if (hour > 12) {
    hour -= 12;
  }

  if (hour == 0) {
    hour = 12;
  }

  return '$hour:${minute.toString().padLeft(2, '0')} $period';
}


  TimeOfDay? _selectedTimeEnd;
  TextEditingController _timeControllerEnd = TextEditingController();

  Future<void> _selectTimeEnd(BuildContext context) async {
    final TimeOfDay? pickeds = await showTimePicker(
      context: context,
      initialTime: _selectedTimeEnd ?? TimeOfDay.now(),
       builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
          child: child!,
        );
      },
    );

    if (pickeds != null && pickeds != _selectedTimeEnd) {
      setState(() {
        _selectedTimeEnd = pickeds;
        _timeControllerEnd.text = _selectedTimeEnd!.format(context);
      });
      print(_selectedTimeEnd);
    }
  }








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
List<dynamic> facilities = [];
 String selectedFacility = '';
 
    Future<void> _fetchFacilities() async {
    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/facilities/?apikey=MYhsie8n4';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      List<dynamic> facilityData = jsonResponse['data'];

      setState(() {
        facilities = facilityData.map((facility) => facility['fac']).toList();
      });

      _showFacilitiesBottomSheet();
    } else {
      // Handle error if API request fails
      _showErrorSnackbar();
    }
  }

    void _showErrorSnackbar() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error fetching facilities. Please try again later.'),
      ),
    );
  }


  void _showFacilitiesBottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: facilities.map((fac) {
            return ListTile(
              title: Text(fac),
              onTap: () {
                 setState(() {
                  selectedFacility = fac;
                });
                print( selectedFacility);
                // Handle selection if needed
                Navigator.pop(context);
              },
            );
          }).toList(),
        );
      },
    );
  }

  Future<List<Map<String, dynamic>>> fetchScheduledShifts() async {
    final apiUrl =
        'https://sandbox1.autumntrack.com/api/v2/schedule/?apikey=MYhsie8n4&email=${userContoller.email}';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      return List<Map<String, dynamic>>.from(jsonResponse['data']);
    } else {
      throw Exception('Failed to fetch scheduled shifts');
    }
  }


   Future<void> postShift() async {
   

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/manager/post-shift/?apikey=MYhsie8n4&id=4964&fac=A Autumn Demo';
    
final Map<String, String> body = {
        // 'user': _emailController.text,
        // 'pass': _passwordController.text,
        // 'player_id': 'sadas',
        'unit': "Floor 1",
        'time_start': "{$_selectedTime}",
        'time_end': "{$_selectedTime}",
        "date":"{$_selectedDate}",
        "pos":"RN"
      };
    final response = await http.post(Uri.parse(apiUrl),  body: body,);
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      String message = jsonResponse['message'];

      if (message == 'Shift Posted') {
         _showSnackbars('Shift Posted Successful ');
 
        // Redirect to login screen or navigate back to previous screen
      } else {
        _showSnackbar('Request failed. Please try again.');
      }
    } else {
      _showSnackbar('Error occurred. Please try again later.');
    }
  }
  void _showSnackbars(String message) {
  Get.snackbar("Success", message);
  }

   void _showSnackbar(String message) {
  Get.snackbar("Error", message);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
   
         return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Post a Shift",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
          centerTitle: true,
          automaticallyImplyLeading: false,
        //           actions: [
        //   IconButton(
        //     icon: Icon(Icons.refresh),
        //     onPressed: () {
        //       // Call fetchData() and trigger a refresh
        //       setState(() {});
        //     },
        //   ),
        // ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: Column(
          
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    'Please fill out form below to post a shift',
                    style: TextStyle(fontSize: 15, ),
                  ),
                ),
                SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectTime(context),
                child: AbsorbPointer(
                  child: TextFormField(
                     textAlign: TextAlign.center,
                    controller: _timeController,
                    decoration: InputDecoration(
                      labelText: 'Start Time',
                      hintText: 'Start Time',
                    ),
                  ),
                ),
              ),
               SizedBox(height: 10),
              GestureDetector(
                onTap: () => _selectTimeEnd(context),
                child: AbsorbPointer(
                  child: TextFormField(
                  textAlign: TextAlign.center,
                    controller: _timeControllerEnd,
                    decoration: InputDecoration(
                      labelText: 'End Time',
                      hintText: 'End Time',
                    ),
                  ),
                ),
              ),
               SizedBox(height: 10),
               Text("Unit"),
                 SizedBox(height: 10),
           Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 300,
                              child: ElevatedButton(
                                onPressed:_fetchFacilities,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  'Select a unit',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: _fetchFacilities,
                            ),
                          ],
                        ),
          
                        SizedBox(height: 10),
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
          
                             SizedBox(height: 10),
           Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: 50,
                              width: 300,
                              child: ElevatedButton(
                                onPressed:_fetchFacilities,
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.orange,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                ),
                                child: Text(
                                  'Position',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            IconButton(
                              icon: Icon(Icons.arrow_drop_down),
                              onPressed: _fetchFacilities,
                            ),
                          ],
                        ),
                          SizedBox(height: 10),
                         ElevatedButton(
                          onPressed: ()async{
                    await  postShift();
                  },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(2.0),
                            ),
                            minimumSize: Size(30, 40),
                          ),
                          child: Text(
                            'Post Shift',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
           
              ],
            ),
          ),
        ),
      ),
    );
  }
}
