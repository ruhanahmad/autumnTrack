import 'dart:convert';

import 'package:autumntrackmanagers/screens/loginScreen.dart';
import 'package:autumntrackmanagers/screens/sharedpref.dart';
import 'package:autumntrackmanagers/screens/userController.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
 import 'package:app_settings/app_settings.dart';

import 'package:http/http.dart' as http;

class ProfileScreen extends StatefulWidget {

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
UserContoller userContoller = Get.put(UserContoller());

 TextEditingController subjectController = TextEditingController();

  TextEditingController messageController = TextEditingController();

  Future<void> _sendSupportRequest() async {
     if (subjectController.text.isEmpty || messageController.text.isEmpty ) {
      _showSnackbar('Please fill in all fields');
      return;
    }
    final String apiUrl =
        'https://sandbox1.autumntrack.com/api/v2/support/?apikey=MYhsie8n4';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'fac': 'A Autumn Demo',
        'email': '${userContoller.email}',
        'subject': subjectController.text,
        'message': messageController.text,
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      final status = jsonResponse['status'];
      final message = jsonResponse['message'];

      if (status == '200') {
        // Show a success snackbar
          _showSnackbars("Thank you, we will get back to you shortly");
      
      } else {
        // Show an error snackbar
          _showSnackbar('${message}');
       
      }
    } else {
      // Show an error snackbar if the API request fails
      _showSnackbar('api Request Failed');
    }
  }

  Future<void> _requestCredentials() async {
   

    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/close_account/?apikey=MYhsie8n4&email=${userContoller.email}';
    

    final response = await http.post(Uri.parse(apiUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      String message = jsonResponse['message'];

      if (message == 'Success') {
         _showSnackbars('Sent Successful ');
 
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
bool bioMetricEnabled = false;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      SharedPreferencesService.getBiometricStatus().then((value) {
        setState(() {
          bioMetricEnabled = value;
        });
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
   
         return false;
      },
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            title: Text('Profile Screen',style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
            
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(29.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange,
                        radius: 30.0,
                        child: Text("${userContoller.fname.substring(0,1)}${userContoller.lname.substring(0,1)}",style: TextStyle(color: Colors.black),),
                      ),
                      SizedBox(width: 16.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Demo Account', style: TextStyle(fontSize: 18.0)),
                          Text('demo@autumnhc.net'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                            // Handle settings button press
                                  AppSettings.openLocationSettings();
                          },
                    child: Row(
                      children: [
                       
                       
                           Icon(Icons.settings),
                     
                        SizedBox(width: 8.0),
                        Text('View Settings'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                           showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('Close Account'),
                          content: Text('Are you sure you want to close your account?'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('No'),
                              onPressed: () {
                                Navigator.of(context).pop(); // Close the dialog.
                              },
                            ),
                            TextButton(
                              child: Text('Yes'),
                              onPressed: () {
                                // Close the account (call your API).
                                _requestCredentials();
                                Navigator.of(context).pop(); // Close the dialog.
                              },
                            ),
                          ],
                        );
                      },
                    );
                    },
                    child: 
                    Row(
                      children: [
                        
                        
                          Icon(Icons.delete, color: Colors.red),
                       
                       
                          //  print("object");
                        
                        
                        SizedBox(width: 8.0),
                        Text('Close Account>>'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),

                   ListTile(
                    leading: Icon(Icons.lock),
                    title: Text('Biometric Authentication'),
                    trailing: CupertinoSwitch(
                      value: bioMetricEnabled,
                      onChanged: (bool value) {
                        setState(() {
                          bioMetricEnabled = value;
                        });
                        SharedPreferencesService.saveBiometricStatus(value);
                      },
                    ),
                  ),
                    SizedBox(height: 20.0),
                  Row(
                    children: [
                     
                     
                         Icon(Icons.delete, color: Colors.red),
                     
                     
                      SizedBox(width: 8.0),
                      Text('Remove Face ID>>'),
                    ],
                  ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                                context: context,
                                builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Support Request'),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextFormField(
                            controller: subjectController,
                            decoration: InputDecoration(
                              labelText: 'Subject',
                            ),
                          ),
                          SizedBox(height: 16),
                          TextFormField(
                            controller: messageController,
                            decoration: InputDecoration(
                              labelText: 'Message',
                            ),
                            maxLines: 3,
                          ),
                        ],
                      ),
                      actions: <Widget>[
                        TextButton(
                          child: Text('Cancel'),
                          onPressed: () {
                            Navigator.of(context).pop(); // Close the dialog.
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            _sendSupportRequest();
                            Navigator.of(context).pop(); // Close the dialog.
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    );
                                },
                              );
                    },
                    child: Row(
                      children: [
                        
                      
                           
                          Icon(Icons.info, color: Colors.black),
                       
                        
                        SizedBox(width: 8.0),
                        Text('Support>>'),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed: () {
                    Get.offAllNamed('/login');
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.orange),
                    child: Text('Logout'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
