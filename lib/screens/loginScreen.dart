import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:autumntrackmanagers/screens/bottomNavigation.dart';

import 'package:autumntrackmanagers/screens/resetScreen.dart';
import 'package:autumntrackmanagers/screens/sharedpref.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'userController.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _showPassword = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  UserContoller userContoller = Get.put(UserContoller());
  String fname = '';
  String lname = '';
  String email = '';
  String facility = '';
  String role = '';
  String position = '';
  String employeeKey = '';
  String playerID = '';
  String passForBiometric = '';

//  Future getPlayerId() async {
//     try {
//  var deviceState = await OneSignal.shared.getDeviceState();

//     if (deviceState == null || deviceState.userId == null)
//         return;

//     notificationController.playerId = deviceState.userId!;
//      print("playeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeer" + notificationController.playerId);
//    await  updateToken();
//     }
//     catch(e){
//      Get.snackbar("title", "not getting PlayerID  ${e}");
//     }

//   }

  Future<void> _logins(password, email) async {
    if (_rememberPassword) {
      await SharedPreferencesService.savePassword(password, email);
    }

    // Perform your login logic here
    // ...
  }

  Future<void> _login(bool isFromBiometric) async {
    String email = _emailController.text.trim();
    String password =
        isFromBiometric ? passForBiometric : _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showSnackbar('Please fill in both fields');
    } else {
      final String apiUrl =
          'https://sandbox1.autumntrack.com/api/v2/login/?apikey=MYhsie8n4';

         

      final Map<String, String> body = {
        // 'user': _emailController.text,
        // 'pass': _passwordController.text,
        // 'player_id': 'sadas',
        'user': email,
        'pass': password,
        'player_id': 'sadas',
      };

      final response = await http.post(
        Uri.parse(apiUrl),
        body: body,
      );

      if (response.statusCode == 200) {
        // Successful login, handle the response
        print('Login successful: ${response.body}');

        final jsonResponse = json.decode(response.body);

        // Extract data from the JSON
        Map<String, dynamic> data = jsonResponse['data'];
        fname = data['fname'];
        lname = data['lname'];
        email = data['email'];
        facility = data['facility'];
        role = data['role'];
        position = data['position'];
        employeeKey = data['employeekey'];
        playerID = data['player_id'];
        userContoller.email = email;
        userContoller.fname = fname;
        userContoller.lname = lname;
        userContoller.update();
        Get.to(
          () => NavigationBarScreen(
            fname: fname,
            lname: lname,
            email: email,
            facility: facility,
            role: role,
            position: position,
            employeeKey: employeeKey,
            playerID: playerID,
          ),
        );
        _logins(password, email);
      } else {
        _showSnackbar('Please Provide Correct Credientials');
        // Error handling for unsuccessful login
        print('Login failed: ${response.statusCode}');
      }
    }
  }

  void _showSnackbar(String message) {
    Get.snackbar('Error', '$message');
  }

  bool _obscureText = true;
  Future<void> _authenticate() async {
    final localAuth = LocalAuthentication();

    try {
      bool canCheckBiometrics = await localAuth.canCheckBiometrics;
      if (canCheckBiometrics) {
        List<BiometricType> availableBiometrics =
            await localAuth.getAvailableBiometrics();

            print(availableBiometrics);

        if (availableBiometrics.contains(BiometricType.face) || availableBiometrics.contains(BiometricType.fingerprint)  || availableBiometrics.contains(BiometricType.weak) || availableBiometrics.contains(BiometricType.strong)) {
          bool isAuthenticated = await localAuth.authenticate(
              localizedReason:
                  'Authenticate to access the app', // Displayed to the user

              options: AuthenticationOptions(
                useErrorDialogs:
                    true, // Show system dialogs (e.g., for Face ID)
                biometricOnly: true,

                stickyAuth:
                    true, // Keep the biometric prompt open until success or failure
              ));

          if (isAuthenticated) {
            _login(true);
            // Authentication successful
            print('Authentication successful');
          } else {
            // Authentication failed
            print('Authentication failed');
          }
        } else {
          // Face ID is not available on this device
          print('Face ID is not available on this device');
        }
      } else {
        // Biometrics are not available on this device
        print('Biometrics are not available on this device');
      }
    } catch (e) {
      // Handle errors here
      print('Error: $e');
    }
  }

  bool _rememberPassword = false;

  @override
  void initState() {
    super.initState();
    //check get x arguments

    _loadPassword();
  }

  Future<void> _loadPassword() async {
    final savedPassword = await SharedPreferencesService.getPassword();
    final savedEmail = await SharedPreferencesService.getemail();
    final bool getBiometricStatus =
        await SharedPreferencesService.getBiometricStatus();
    if ((savedPassword ?? '') != '' && (savedEmail ?? '') != '') {
      setState(() {
        passForBiometric = savedPassword ?? "";
        // _passwordController.text = savedPassword ?? "";
        _emailController.text = savedEmail ?? "";
        _rememberPassword = true;
      });
      if (Get.arguments == 'logout') {
        return;
      }
      if (getBiometricStatus) {
        _authenticate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return await _confirmExit(
            context); // Show confirmation dialog and handle exit.
        // return false;
      },
      child: Scaffold(
        body: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 22.0),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 50.0),
                  Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage("assets/images/atnav.png"),
                            fit: BoxFit.contain)),
                    // Replace with your logo
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Welcome',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 10.0),
                  Text(
                    'Please Sign in to continue',
                    style: TextStyle(fontSize: 14.0),
                  ),
                  SizedBox(height: 20.0),
                  TextFormField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide:
                            BorderSide(width: 10.0, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                    ),
                  ),
                  SizedBox(height: 15.0),
                  TextFormField(
                    controller: _passwordController,
                    //  obscureText: !_showPassword,
                    obscureText: _obscureText,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(27.0),
                        borderSide: BorderSide(width: 2.0, color: Colors.black),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 20.0),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureText
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  // Row(
                  //   children: [
                  //     Checkbox(
                  //       value: _showPassword,
                  //       onChanged: (value) {
                  //         setState(() {
                  //           _showPassword = value!;
                  //         });
                  //       },
                  //     ),
                  //     Text('Show Password'),
                  //   ],
                  // ),
                  SizedBox(height: 20.0),

                  CheckboxListTile(
                    title: Text('Remember Password'),
                    value: _rememberPassword,
                    onChanged: (value) {
                      setState(() {
                        _rememberPassword = value!;
                      });
                    },
                  ),

                  Container(
                    width: 420.0,
                    height: 49.0,
                    decoration: BoxDecoration(
                      border: Border.all(width: 2.0, color: Colors.black),
                      borderRadius: BorderRadius.circular(27.0),
                    ),
                    child: TextButton(
                      onPressed: () => _login(false),
                      child: Text(
                        'Login',
                        style: TextStyle(fontSize: 16.0, color: Colors.black),
                      ),
                    ),
                  ),
                  // SizedBox(height: 20.0),
                  // GestureDetector(
                  //   onTap: () {
                  //     Get.to(() => RequestCredentialsScreen());
                  //   },
                  //   child: Container(
                  //     width: 420.0,
                  //     height: 49.0,
                  //     decoration: BoxDecoration(
                  //       border: Border.all(width: 2.0, color: Colors.black),
                  //       borderRadius: BorderRadius.circular(27.0),
                  //     ),
                  //     child: Center(
                  //       child: Text(
                  //         'Request Credentials',
                  //         style: TextStyle(fontSize: 16.0),
                  //       ),
                  //     ),
                  //   ),
                  // ),
                  SizedBox(height: 20.0),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => ResetScreen());
                    },
                    child: Container(
                      width: 180.0,
                      height: 35.0,
                      // color: Color(0xFFD9D9D9),
                      child: Center(
                        child: Text(
                          'Forgot Password',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    'Any questions and issues please email',
                    style: TextStyle(
                        fontStyle: FontStyle.italic, color: Colors.black54),
                  ),
                  GestureDetector(
                    onTap: () {
                      _authenticate();
                    },
                    child: Text(
                      'support@autumntrack.com',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> _confirmExit(BuildContext context) async {
    Completer<bool> completer = Completer<bool>();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Confirm Exit'),
          content: Text('Are you sure you want to quit the app?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(false); // Cancel exit.
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true); // Confirm exit.
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    ).then((value) {
      completer.complete(value ?? false);
    });

    return completer.future;
  }
}
