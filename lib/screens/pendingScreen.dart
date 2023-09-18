import 'package:autumntrackmanagers/screens/userController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:intl/intl.dart';



class MyShiftsScreen extends StatefulWidget {
  @override
  State<MyShiftsScreen> createState() => _MyShiftsScreenState();
}

class _MyShiftsScreenState extends State<MyShiftsScreen> {
   UserContoller userContoller = Get.put(UserContoller()); 

  Future<List<Map<String, dynamic>>> fetchPendingShifts() async {
    final apiUrl =
        'https://scheduler.autumntrack.com/api/v2/manager/pending/?apikey=MYhsie8n4&fac=A Autumn Demo';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse['appShifts']);
      return List<Map<String, dynamic>>.from(jsonResponse['appShifts']);
    } else {
      throw Exception('Failed to fetch pending shifts');
    }
  }

   Future<void> _declineShift(String id) async {
   
print(id);
    final apiUrl = 'https://scheduler.autumntrack.com/api/v2/manager/decline/?apikey=MYhsie8n4&id=$id';
    

    final response = await http.post(Uri.parse(apiUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
      //     _showSnackbars('decline Successful ');
      String message = jsonResponse['message'];

      if (message == 'Shift Declined') {
         _showSnackbars('Shift Declined ');

         setState(() {
           
         });
 
        // Redirect to login screen or navigate back to previous screen
      }
       else {
        _showSnackbar('Request failed. Please try again.');
      }
    } else {
      _showSnackbar('Error occurred. Please try again later.');
    }
  }


  Future<void> approveShift(String id) async {
   
print(id);
    final apiUrl = 'https://scheduler.autumntrack.com/api/v2/manager/approve/?apikey=MYhsie8n4&id=$id';
    

    final response = await http.post(Uri.parse(apiUrl));
    print(response.statusCode);
    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      print(jsonResponse);
            //  _showSnackbars('Approve Successfull ');
      String message = jsonResponse['message'];

      if (message == 'Shift Approved') {
         _showSnackbars('Approved Successful ');
         
         setState(() {
           
         });
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
          title: Text('Pending Shifts',style: TextStyle(fontWeight: FontWeight.bold),),
          centerTitle: true,
           automaticallyImplyLeading: false,
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              // Call fetchData() and trigger a refresh
              setState(() {});
            },
          ),
        ],

        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Text(
              //   'All Your Shifts Pickup',
              //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              // ),
              SizedBox(height: 20),
              Expanded(
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: fetchPendingShifts(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                      return Text('No shifts available');
                    } else {
                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          var shift = snapshot.data![index];
    
                              final inputFormat = DateFormat('HH:mm'); // 'HH:mm' represents 24-hour format
      final outputFormat = DateFormat('h:mm a'); // 'h:mm a' represents 12-hour format with AM/PM
     String? strt ;
      String? ebd ;
      try {
      final DateTime dateTime = inputFormat.parse(shift['time_start']);
      final DateTime dateTimeebd = inputFormat.parse(shift['time_end']);
      
     strt  =  outputFormat.format(dateTime);
      ebd =  outputFormat.format(dateTimeebd);
      }
       catch (e) {
      // Handle parsing errors here
       'Invalid Time';
      }
      String? formattedDate ;
    try {
    DateTime inputDate = DateTime.parse(shift['date']);
    formattedDate = DateFormat('EEEE, MM /dd').format(inputDate);
    print(formattedDate);
    }
    
    catch (e) {
      // Handle parsing errors here
       'Invalid Time';
      }
    
    
                          return 
    
    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 14.0),
                      child: 
                      Material(
                        borderRadius: BorderRadius.circular(15),
                        elevation: 20,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal:10.0,vertical: 10),
                          child: Container(
                            
                            // margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                            
                            child:
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                     
                              children: [
                                SizedBox(height: 20,),
 
                                Padding(
                                  padding: const EdgeInsets.all(0.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    // Text(
                                    //             shift['approved'] == '1' ? 'Approved' : 'Pending',
                                    //             style: TextStyle(
                                    //               color: shift['approved'] == '1' ? Colors.green : Colors.orange,
                                    //               fontWeight: FontWeight.bold,
                                    //               fontSize: 20,
                                    //             ),
                                    //           ),
                                  
                                    
                                              SizedBox(height: 3),
                                              Text(
                                                shift['fname'] +" " + shift["lname"],
                                                style: TextStyle(fontSize: 14),
                                              ),
                                     SizedBox(height: 3),
                                              Text(
                                                '$strt - $ebd',
                                                style: TextStyle(fontSize: 14),
                                              ),
                                           SizedBox(height: 10,),
                                        
                                                              ElevatedButton(
                        onPressed: ()async{
                  // await  postShift();
                  await _declineShift(shift["id"]);
                },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          minimumSize: Size(30, 40),
                        ),
                        child: Text(
                          'Decline',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                                      
                                    
                                    ],),
                                    
                                       Column(
                                       crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                    
                                     Column(
                                      crossAxisAlignment: CrossAxisAlignment.end,
                                          children: [
                                  //           GestureDetector(
                                       
                                  //         onTap: () {
                                  //                          showDialog(
                                  //                     context: context,
                                  //                     builder: (BuildContext context) {
                                  //                       return AlertDialog(
                                  //                         title: Text('Cancel Shift'),
                                  //                         content: Text('Are you sure?'),
                                  //                         actions: <Widget>[
                                  //                           TextButton(
                                  //                             child: Text('No'),
                                  //                             onPressed: () {
                                  // Navigator.of(context).pop(); // Close the dialog.
                                  //                             },
                                  //                           ),
                                  //                           TextButton(
                                  //                             child: Text('Yes'),
                                  //                             onPressed: () {
                                  //         try {
                                  //          _declineShift(shift["id"]);
                                             
                                  //         } catch (error) {
                                  //           print('Error accepting invitation: $error');
                                  //         }
                                  // Navigator.of(context).pop(); // Close the dialog.
                                  //                             },
                                  //                           ),
                                  //                         ],
                                  //                       );
                                  //                     },
                                  //                   );
                                  //                   },
                                  //       // async {
                                  //       //         try {
                                  //       //    _declineShift(shift["id"]);
                                             
                                  //       //   } catch (error) {
                                  //       //     print('Error accepting invitation: $error');
                                  //       //   }
                                  //       //       },
                                  //         child: Container(
                                  //           height: 22,
                                  //           width: 90,
                                  //           decoration: BoxDecoration(
                                  //             borderRadius: BorderRadius.circular(5),
                                  //             color: Colors.red
                                  //           ),
                                  //           child: Center(child: Text("Cancel",style: TextStyle(fontSize: 15,color: Colors.white),)),
                                  //         ),
                                  //       ),
                                           SizedBox(height: 2),
                                            Text(
                                                'Date of Shift',
                                                style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                            
                                    
                                            Text(
                                                formattedDate!, style: TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 14,
                                                ),
                                              ),
                                    
                                          ],
                                        ),
                                        SizedBox(height: 10,),
                                        
                                                              ElevatedButton(
                        onPressed: ()async{
                  // await  postShift();
                  await approveShift(shift["id"]);

                },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(2.0),
                          ),
                          minimumSize: Size(30, 40),
                        ),
                        child: Text(
                          'Approve',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
 
                                        
                                       
                                        
                                          
                                    ],),
                                  ],),
                                ),
                                shift["bonus"] == "0" ? Center(child: Text("")):Center(child: Text(" Bonus: \$${shift['bonus']} ",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold),)),
                              ],
                            )
                            
                            
                          ),
                        ),
                      ),
                    );
                          
    //                         Padding(
    //                           padding: const EdgeInsets.symmetric(horizontal:30.0,vertical: 10.0),
    //                           child: Material(
    //                              borderRadius: BorderRadius.circular(15),
    //                                               elevation: 20,
    //                             child: Padding(
    //                               padding: const EdgeInsets.all(12.0),
    //                               child: Container(
    //                                 width: 335,
    //                                 height: 83,
    //                                decoration: BoxDecoration(
                                
    //                                // Replace with your desired background color
    //                                 borderRadius: BorderRadius.circular(15), // Adjust the radius as needed
    //                               ),
                                  
    //                                 // margin: EdgeInsets.symmetric(horizontal: 16.0,),
                                 
    //                                 child: Padding(
    //                                   padding: const EdgeInsets.all(4.0),
    //                                   child: Row(
    //                                     children: [
    //                                       Column(
    //                                         // crossAxisAlignment: CrossAxisAlignment.s,
    //                                         // mainAxisAlignment: MainAxisAlignment.,
    //                                         children: [
    //                                           Text(
    //                                             shift['approved'] == '1' ? 'Approved' : 'Pending',
    //                                             style: TextStyle(
    //                                               color: shift['approved'] == '1' ? Colors.green : Colors.orange,
    //                                               fontWeight: FontWeight.bold,
    //                                               fontSize: 20,
    //                                             ),
    //                                           ),
    //                                           SizedBox(height: 3),
    //                                           Text(
    //                                             shift['pos'],
    //                                             style: TextStyle(fontSize: 14),
    //                                           ),
    //                                           SizedBox(height: 3),
    //                                           Text(
    //                                             '$strt - $ebd',
    //                                             style: TextStyle(fontSize: 14),
    //                                           ),
    //                                           SizedBox(height: 8),
    //                                           Text(
    //                                             shift['bonus'] == "0" ? '' : 'Bonus: ${shift['bonus']}',
    //                                           ),
    //                                         ],
    //                                       ),
    //                                       Column(
    //                                         crossAxisAlignment: CrossAxisAlignment.end,
    //                                         mainAxisAlignment: MainAxisAlignment.start,
    //                                         children: [
    //                                           Text(
    //                                             'Date of Shift',
    //                                             style: TextStyle(
    //                                               color: Colors.black,
    //                                               fontSize: 12,
    //                                             ),
    //                                           ),
    //                                           SizedBox(height: 8),
                                                    
    //                                           Text(
    //                                             formattedDate!, style: TextStyle(
    //                                               color: Colors.black,
    //                                               fontSize: 12,
    //                                             ),
    //                                           ),
    //                                           SizedBox(height: 5,),
    // ElevatedButton(
    //                                    style: ElevatedButton.styleFrom(
                                      
    //  padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
    //                 primary: Colors.red,
    //                 foregroundColor: Colors.white,
                  
                 
                  
    //                 ),
    
    //                                       onPressed: () async {
    //                                       try {
    //                                        _declineShift(shift["id"]);
                                           
    //                                       } catch (error) {
    //                                         print('Error accepting invitation: $error');
    //                                       }
    //                                       },
    //                                       child: Text('Cancel Shift',style: TextStyle(fontSize: 10),),
    //                                     ),
    
    //                                           SizedBox(height:MediaQuery.of(context).size.height/2 -420),
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 ),
    //                               ),
    //                             ),
    //                           ),
    //                         );
                        },
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
