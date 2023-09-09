import 'dart:convert';

import 'package:autumntrackmanagers/main.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
class UserContoller extends GetxController  {

String email="";
String fname ="";
String lname = "";

 DateTime selectedDate = DateTime.now();
 List<dynamic> openShiftDates = [];
   Future<void>  fetchOpenShiftss() async {
  //  await Future.delayed(Duration(seconds: 5));
  final apiKey = 'MYhsie8n4';
  final email = 'demo@autumnhc.net';
  final date = DateFormat('yyyy-MM-dd').format(selectedDate);

  final apiUrl = Uri.parse('https://sandbox1.autumntrack.com/api/v2/week-open-shifts/?apikey=MYhsie8n4&email=demo@autumnhc.net&date=$date');
try {
    final response = await http.post(apiUrl);
   
    if (response.statusCode == 200) {
       final  responseData =
            json.decode(response.body) ;

  // Print the response data for inspection
  print(responseData);
        // final List<dynamic> responseData =
        //     json.decode(response.body) as List<dynamic>;
      // final openShifts = responseData
      //     .where((shift) => shift['error'] == null)
      //     .map<String>((shift) => shift['date'])
      //     .toList();
        
          // Extract dates from the response data
         openShiftDates = responseData
          .where((shift) => shift['data'] != "No Open Shifts")
          .map<dynamic>((shift) => shift['date'])
          .toList();

          print("sadasDsssss $openShiftDates");
       
update();
  // setState(() {
  //         // Extract dates from the response data
  //         openShiftDates = responseData
  //             .map((data) => data['date'] as String)
  //             .toList();
  //       });

        print(openShiftDates);
    }
  } catch (error) {
    print('Error fetching open shifts: $error');
  }
}

}