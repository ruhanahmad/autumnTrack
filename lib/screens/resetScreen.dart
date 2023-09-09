import 'dart:convert';

import 'package:autumntrackmanagers/screens/loginScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;

class ResetScreen extends StatefulWidget {
  @override
  _ResetScreenState createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
 final TextEditingController _emailController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  String selectedFacility = '';
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

   Future<void> _requestCredentials() async {
    String email = _emailController.text.trim();
    String firstName = _firstNameController.text.trim();
    String lastName = _lastNameController.text.trim();

    if (email.isEmpty || firstName.isEmpty || lastName.isEmpty || firstName != lastName) {
      _showSnackbar('Please fill in all fields or match your password');
      return;
    }

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/reset/?apikey=MYhsie8n4';
    final Map<String, dynamic> requestData = {
      "id": "1739",
      "email": email,
      "newpass": firstName,
      "confirmpass": lastName,
      
    };

    final response = await http.post(Uri.parse(apiUrl), body: requestData);

    print(response.statusCode);

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      String message = jsonResponse['message'];

      if (message == 'Success') {
      Get.to(()=>LoginScreen());
        // Redirect to login screen or navigate back to previous screen
      } else {
        _showSnackbar('Request failed. Please try again.');
      }
    } else {
      _showSnackbar('Error occurred. Please try again later.');
    }
  }

  void _showSnackbar(String message) {
  Get.snackbar("Error", message);
  }



  void _openFacilityList() {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return ListView(
          children: [
            ListTile(
              title: Text('Facility 1'),
              onTap: () {
                setState(() {
                  selectedFacility = 'Facility 1';
                  Navigator.pop(context);
                });
              },
            ),
            ListTile(
              title: Text('Facility 2'),
              onTap: () {
                setState(() {
                  selectedFacility = 'Facility 2';
                  Navigator.pop(context);
                });
              },
            ),
            // Add more facilities as needed
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Request Credentials',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text(
                        'Reset Password',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text('Please enter your email to reset your password.if'),
                       Text('you have an account you will receive email with'),
                      Text('instruction to reset your password'),
                      SizedBox(height: 20),
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(labelText: 'Email'),
                      ),
                      TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(labelText: 'new password'),
                      ),
                      TextFormField(
                        controller: _lastNameController,
                        decoration: InputDecoration(labelText: 'Confirm password'),
                      ),
                      
                      SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: ()async{
                  await  _requestCredentials();
                },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(25.0),
                          ),
                          minimumSize: Size(50, 50),
                        ),
                        child: Text(
                          'Reset Password',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                         SizedBox(height: 20),
                       ElevatedButton(
                onPressed: ()async{
                  Get.to(()=>LoginScreen());
                },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    minimumSize: Size(50, 50),
                  ),
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                    ],
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
