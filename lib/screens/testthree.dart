// // import 'package:flutter/material.dart';

// // class HomeScreen extends StatelessWidget {
// //   final String fname;
// //   final String lname;
// //   final String email;
// //   final String facility;
// //   final String role;
// //   final String position;
// //   final String employeeKey;
// //   final String playerID;

// //   HomeScreen({
// //     required this.fname,
// //     required this.lname,
// //     required this.email,
// //     required this.facility,
// //     required this.role,
// //     required this.position,
// //     required this.employeeKey,
// //     required this.playerID,
// //   });

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text('Next Screen'),
// //       ),
// //       body: Center(
// //         child: Column(
// //           mainAxisAlignment: MainAxisAlignment.center,
// //           crossAxisAlignment: CrossAxisAlignment.center,
// //           children: [
// //             Text('First Name: $fname'),
// //             Text('Last Name: $lname'),
// //             Text('Email: $email'),
// //             // ... Other data fields
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// import 'dart:convert';

// import 'package:autmn/screens/news.dart';
// import 'package:autmn/screens/pendingScreen.dart';
// import 'package:autmn/screens/schedule.dart';
// import 'package:autmn/screens/successScreen.dart';
// import 'package:autmn/screens/userController.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:http/http.dart' as http;


// class NextScreen extends StatefulWidget {

//   @override
//   _NextScreenState createState() => _NextScreenState();
// }

// class _NextScreenState extends State<NextScreen> {
//   DateTime selectedDate = DateTime.now();
//    String formatDateVar = DateFormat('yyyy-MM-dd').format(DateTime.now()); // Default value
//  List<dynamic> openShiftDates = [];


//  @override
//   void initState() {
//     super.initState();
//     // fetchOpenShiftss();
//   }

//     Future<void> fetchOpenShifts() async {
//     final apiKey = 'YOUR_API_KEY';
//     final email = 'demo@autumnhc.net';
//     final date = DateFormat('yyyy-MM-dd').format(selectedDate);

//     final apiUrl = Uri.parse('https://scheduler.autumntrack.com/api/v2/week-open-shifts/?apikey=$apiKey&email=$email&date=$date');

//     try {
//       final response = await http.get(apiUrl);
//      print("aasd ${response.statusCode}" );
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body);

//         if (data['data'] != null) {
//           final openShifts = List<String>.from(data['data'].map((shift) => shift['date']));
//           setState(() {
//             openShiftDates = openShifts;
//           });
//         }
//       }
//     } catch (error) {
//       print('Error fetching open shifts: $error');
//     }
//   }
//  Future<void>  fetchOpenShiftss() async {
//   //  await Future.delayed(Duration(seconds: 5));
//   final apiKey = 'MYhsie8n4';
//   final email = 'demo@autumnhc.net';
//   final date = DateFormat('yyyy-MM-dd').format(selectedDate);

//   final apiUrl = Uri.parse('https://scheduler.autumntrack.com/api/v2/week-open-shifts/?apikey=MYhsie8n4&email=demo@autumnhc.net&date=$date');
// try {
//     final response = await http.post(apiUrl);
   
//     if (response.statusCode == 200) {
//        final  responseData =
//             json.decode(response.body) ;

//   // Print the response data for inspection
//   print(responseData);
//         // final List<dynamic> responseData =
//         //     json.decode(response.body) as List<dynamic>;
//       // final openShifts = responseData
//       //     .where((shift) => shift['error'] == null)
//       //     .map<String>((shift) => shift['date'])
//       //     .toList();
//         setState(() {
//           // Extract dates from the response data
//          openShiftDates = responseData
//           .where((shift) => shift['data'] != "No Open Shifts")
//           .map<dynamic>((shift) => shift['date'])
//           .toList();

//           print("sadasDsssss $openShiftDates");
//         });

//   // setState(() {
//   //         // Extract dates from the response data
//   //         openShiftDates = responseData
//   //             .map((data) => data['date'] as String)
//   //             .toList();
//   //       });

//         print(openShiftDates);
//     }
//   } catch (error) {
//     print('Error fetching open shifts: $error');
//   }
// }


//   void _selectDate(DateTime date) {
//     setState(() {
//       selectedDate = date;
//       formatDateVar = DateFormat('yyyy-MM-dd').format(selectedDate);
//     });
//   }
// List<Map<String, dynamic>>? apiData; // List of Map to store API response data

//   // API URL
  

//   // Function to fetch data from the API
// //  Future<List<Map<String, dynamic>>> fetchShifts() async {
// //    final String apiUrl =
// //       'https://scheduler.autumntrack.com/api/v2/user-open-shifts/?apikey=MYhsie8n4&email=demo@autumnhc.net&date=$formatDateVar';
// //     try {
// //       final response = await http.get(Uri.parse(apiUrl));

// //       if (response.statusCode == 200) {
// //         // Parse the JSON response
// //         final List<dynamic> responseData = json.decode(response.body);

// //         // Cast the data to the expected type
// //         // final List<Map<String, dynamic>> data =
// //         //     responseData.cast<Map<String, dynamic>>();
// //       return List<Map<String, dynamic>>.from(responseData);
// //       } else {
// //         // Handle API error here
// //         throw Exception('Failed to load data');
// //       }
// //     } catch (error) {
// //       // Handle network or other errors here
// //       throw Exception('Failed to load data');
// //     }
// //   }
//  UserContoller userContoller = Get.put(UserContoller()); 
//  Future<List<Map<String, dynamic>>> fetchShifts() async {
//   print(userContoller.email);
//     final apiUrl = 'https://scheduler.autumntrack.com/api/v2/user-open-shifts/?apikey=MYhsie8n4&email=${userContoller.email}&date=$formatDateVar';
//  try {
//     final response = await http.post(Uri.parse(apiUrl));
//  print(response.statusCode);
//     if (response.statusCode == 200) {

//       final List<dynamic> jsonResponse = json.decode(response.body);
//      jsonResponse.isEmpty ?
//         Get.snackbar("title", "message"):

   
     
 
    
//       print(response.body);
//       print(jsonResponse);
//       return List<Map<String, dynamic>>.from(jsonResponse);
    
    
//     } else {
//       // Get.snackbar("sd", "message");
//       throw Exception('Failed to fetch shifts');
//     }
//  }
//    catch (error) {
//     return
//       // Handle network or other errors here
//      [
    
//     ];
//     }
    
    
//   }

// Future<Map<String, dynamic>> acceptInvitation(String id, String userInstantAccept) async {

//     final apiUrl = 'https://scheduler.autumntrack.com/api/v2/accept/?apikey=MYhsie8n4&id=$id&user_instant_accept=$userInstantAccept&empkey=13110';

//     final response = await http.post(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final  Map<String,dynamic>jsonResponse = json.decode(response.body);
    
//       return jsonResponse;
//     } else {
//       throw Exception('Failed to accept invitation');
//     }
//   }

//   acceptInvitations() async {

//     final apiUrl = 'https://scheduler.autumntrack.com/api/v2/accept/?apikey=MYhsie8n4&id=1734&user_instant_accept=0&empkey=13110';
    

//     final response = await http.post(Uri.parse(apiUrl));

//     if (response.statusCode == 200) {
//       final Map<String,dynamic> jsonResponse = json.decode(response.body);
//       print( jsonResponse);
    
//     } else {
//       throw Exception('Failed to accept invitation');
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: GestureDetector(
//           onTap: (){
//             // acceptInvitations();
// fetchOpenShiftss();
//             //  Get.to(()=>NewsScreen ());
//           },
//           child: Text('Open Shifts',style: TextStyle(fontWeight: FontWeight.bold),)),
//         centerTitle: true,
//         automaticallyImplyLeading: false,
//       ),
//       body:
//       // GetBuilder<UserContoller> (builder:(context,) ,)
      
      
//        Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.all(16.0),
//             child: Center(
//               child: Text(
//                 'The Week of ${DateFormat('MMMM d, y').format(selectedDate)}',
//                 style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
//               ),
//             ),
//           ),
//           WeeklyCalendar(selectedDate: selectedDate, onSelectDate: _selectDate,openShiftDates: openShiftDates,futureFunction:fetchOpenShiftss ,),
//           Container(
//             height: MediaQuery.of(context).size.height /2-400,
//             width: MediaQuery.of(context).size.width,
//             // flex: 1,
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                                       Text(
//                       ' ${DateFormat('EEEE, MMMM d, y').format(selectedDate)}',
//                       style: TextStyle(color: Colors.white),
//                     ),
//                   // Container(
//                   //   padding: EdgeInsets.all(10.0),
//                   //   decoration: BoxDecoration(
//                   //     color: Colors.orange,
//                   //     borderRadius: BorderRadius.circular(8.0),
//                   //   ),
//                   //   child:
//                   //    Text(
//                   //     ' ${DateFormat('EEEE, MMMM d, y').format(selectedDate)}',
//                   //     style: TextStyle(color: Colors.white),
//                   //   ),
//                   // ),
//                 ],
//               ),
//             ),
//           ),

//                Expanded(
//                 // flex: 1,
//         child: FutureBuilder<List<Map<String, dynamic>>>(
//           future: fetchShifts(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(child: CircularProgressIndicator());
//             } else if (snapshot.hasError) {
//               return Center(child: Text('Error: ${snapshot.error}'));
//             } 
//            else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//               return Center(child: Text('No shifts available'));
//             } 
//              else {
//               return ListView.builder(
//               itemCount: snapshot.data!.length,
//                 itemBuilder: (context, index) {
//                  var shift = snapshot.data![index];

//                 final inputFormat = DateFormat('HH:mm'); // 'HH:mm' represents 24-hour format
//   final outputFormat = DateFormat('h:mm a'); // 'h:mm a' represents 12-hour format with AM/PM
//  String? strt ;
//   String? ebd ;
//   try {
//     final DateTime dateTime = inputFormat.parse(shift['shift_start']);
//     final DateTime dateTimeebd = inputFormat.parse(shift['shift_end']);
    
//  strt  =  outputFormat.format(dateTime);
//   ebd =  outputFormat.format(dateTimeebd);
//   } catch (e) {
//     // Handle parsing errors here
//    'Invalid Time';
//   }
//   String? formattedDate ;
// try {
// DateTime inputDate = DateTime.parse(shift['date_of_shift']);
// formattedDate = DateFormat('EEEE, MM /dd').format(inputDate);
// print(formattedDate);
// }

// catch (e) {
//     // Handle parsing errors here
//    'Invalid Time';
//   }

//                   return 
//                   Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 26.0, vertical: 8.0),
//                     child: 
//                     Material(
//                       borderRadius: BorderRadius.circular(15),
//                       elevation: 20,
//                       child: Padding(
//                         padding: const EdgeInsets.all(5.0),
//                         child: Container(
                          
//                           margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          
//                           child:
//                           Column(
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                 children: [
//                                 Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
// Text('${shift['position']}',style: TextStyle(color: Colors.green,fontSize: 20,fontWeight: FontWeight.bold),),
// Text(" ${strt} -  ${ebd!}",style: TextStyle(fontSize: 14),),
  

//                                 ],),

//                                    Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     children: [
//  shift["approved"] == "1" || shift["user_instant_accept"] == "1" ?
//  Column(
//                                       children: [
//                                         GestureDetector(
//                                           onTap: ()
//                                         async {
//                                                 try {
//                                                   Map<String, dynamic> acceptResponse = await acceptInvitation(shift['id'], shift['user_instant_accept']);
//                                                   // You can store the accept response data in variables here if needed
//                                                   print('Accept Response: $acceptResponse');
//                                                   acceptResponse["message"]== "Success" ?  
                                                 
//                                                   Get.to(()=>SuccessScreen(shiftDate:formattedDate!,shiftTime:strt!,shiftTimeEnd:ebd!,approved:shift["approved"],userInstant:shift["user_instant_accept"] ))
//                                                   :
//                                                   null
//                                                   ;
                                                   
//                                                 } catch (error) {
//                                                   print('Error accepting invitation: $error');
//                                                 }
//                                               },
//                                           child: Container(
//                                             height: 36,
//                                             width: 111,
//                                             decoration: BoxDecoration(
//                                               borderRadius: BorderRadius.circular(5),
//                                               color: Color(0xFFFF9800)
//                                             ),
//                                             child: Center(child: Text("Accept",style: TextStyle(fontSize: 15,color: Colors.white),)),
//                                           ),
//                                         ),
// SizedBox(height: 4,),
//                                           Row(
//                                         children: [
//                                            Icon(Icons.electric_bolt_sharp,color: Colors.green,size: 14,),
//                                           Text("Instant Accept",style: TextStyle(fontSize: 14,color: Colors.green),)
//                                         ],

//                                       ) 
//                                       ],
//                                     )
                                    
//                                     :
//                                      GestureDetector(
//                                       onTap: ()
//                                     async {
//                                             try {
//                                               Map<String, dynamic> acceptResponse = await acceptInvitation(shift['id'], shift['user_instant_accept']);
//                                               // You can store the accept response data in variables here if needed
//                                               print('Accept Response: $acceptResponse');
//                                               acceptResponse["message"]== "Success" ?  
                                             
//                                               Get.to(()=>SuccessScreen(shiftDate:formattedDate!,shiftTime:strt!,shiftTimeEnd:ebd!,approved:shift["approved"],userInstant:shift["user_instant_accept"] ))
//                                               :
//                                               null
//                                               ;
                                               
//                                             } catch (error) {
//                                               print('Error accepting invitation: $error');
//                                             }
//                                           },
//                                       child: Container(
//                                         height: 36,
//                                         width: 111,
//                                         decoration: BoxDecoration(
//                                           borderRadius: BorderRadius.circular(5),
//                                           color: Color(0xFFFF9800)
//                                         ),
//                                         child: Center(child: Text("Accept",style: TextStyle(fontSize: 15,color: Colors.white),)),
//                                       ),
//                                     ),
                                    
                                   
                                    
//   //  ElevatedButton(
//   //                                  style: ElevatedButton.styleFrom(
//   //               primary: Colors.orange,
//   //               foregroundColor: Colors.white,
//   //           // Adjust padding as neede
               
                
//   //               ),
   
//   //                                     onPressed: () 
//   //                                     async {
//   //                                       try {
//   //                                         Map<String, dynamic> acceptResponse = await acceptInvitation(shift['id'], shift['user_instant_accept']);
//   //                                         // You can store the accept response data in variables here if needed
//   //                                         print('Accept Response: $acceptResponse');
//   //                                         acceptResponse["message"]== "Success" ?  
                                             
//   //                                         Get.to(()=>SuccessScreen(shiftDate:formattedDate!,shiftTime:strt!,shiftTimeEnd:ebd!,approved:shift["approved"],userInstant:shift["user_instant_accept"] ))
//   //                                         :
//   //                                         null
//   //                                         ;
                                               
//   //                                       } catch (error) {
//   //                                         print('Error accepting invitation: $error');
//   //                                       }
//   //                                     },
//   //                                     child: Text('Accept Shift'),
//   //                                   ),
//                                       //    shift["approved"] == "1" || shift["user_instant_accept"] == "1" ?
//                                       // Row(
//                                       //   children: [
//                                       //     IconButton(onPressed: (){}, icon: Icon(Icons.electric_bolt_sharp,color: Colors.green,)),
//                                       //     Text("Instant Accept",style: TextStyle(fontSize: 12,color: Colors.green),)
//                                       //   ],

//                                       // ) 
//                                       // :
//                                       // Container()
                                      
//                                 ],),
//                               ],),
//                               shift["bonus"] == "0" ? Center(child: Text("")):Center(child: Text(" Bonus: \$${shift['bonus']} ",style: TextStyle(color: Colors.red,fontSize: 14,fontWeight: FontWeight.bold),)),
//                             ],
//                           )
                          
                          
//                           //  ListTile(
//                           //              title: 
//                           //   // subtitle: Text('S ${shift['shift_start']} - ${shift['shift_end']}'),
//                           //   subtitle: 
//                           //    trailing: 
//                           //    Column(
//                           //      children: [
                              

                              

                                  
                                  
                                    
//                           //      ],
//                           //    ),
//                           // ),
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               );
//             }
//           },
//         ),
//       ),
    
//         ],
//       ),
//     );
//   }
// }

// class WeeklyCalendar extends StatefulWidget {
//   final DateTime selectedDate;
//   final Function(DateTime) onSelectDate;
//   final List<dynamic> openShiftDates;
//    final Future<void> Function() futureFunction;
//   //  final Future<void>  fetchData;

//   WeeklyCalendar({required this.selectedDate, required this.onSelectDate,required this.openShiftDates,required this.futureFunction});

//   @override
//   State<WeeklyCalendar> createState() => _WeeklyCalendarState();
// }

// class _WeeklyCalendarState extends State<WeeklyCalendar> {
//  List<dynamic> openShiftDates = [];
//    Future<void>  fetchOpenShiftss() async {
//   //  await Future.delayed(Duration(seconds: 5));
//   final apiKey = 'MYhsie8n4';
//   final email = 'demo@autumnhc.net';
//   final date = DateFormat('yyyy-MM-dd').format(widget.selectedDate);

//   final apiUrl = Uri.parse('https://scheduler.autumntrack.com/api/v2/week-open-shifts/?apikey=MYhsie8n4&email=demo@autumnhc.net&date=$date');
// try {
//     final response = await http.post(apiUrl);
   
//     if (response.statusCode == 200) {
//        final  responseData =
//             json.decode(response.body) ;

//   // Print the response data for inspection
//   print(responseData);
//         // final List<dynamic> responseData =
//         //     json.decode(response.body) as List<dynamic>;
//       // final openShifts = responseData
//       //     .where((shift) => shift['error'] == null)
//       //     .map<String>((shift) => shift['date'])
//       //     .toList();
//         setState(() {
//           // Extract dates from the response data
//          openShiftDates = responseData
//           .where((shift) => shift['data'] != "No Open Shifts")
//           .map<dynamic>((shift) => shift['date'])
//           .toList();

//           print("sadasDsssss $openShiftDates");
//         });

//   // setState(() {
//   //         // Extract dates from the response data
//   //         openShiftDates = responseData
//   //             .map((data) => data['date'] as String)
//   //             .toList();
//   //       });

//         print(openShiftDates);
//     }
//   } catch (error) {
//     print('Error fetching open shifts: $error');
//   }
// }

//   @override

//   Widget build(BuildContext context) {
//     DateTime startOfWeek = widget.selectedDate.subtract(Duration(days: widget.selectedDate.weekday ));
//     List<DateTime> days = List.generate(7, (index) => startOfWeek.add(Duration(days: index)));

//     return Column(
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           children: [
//             IconButton(
//               icon: Icon(Icons.arrow_back_ios),
//               onPressed: (){
//                 DateTime prevWeek = widget.selectedDate.subtract(Duration(days: 7));
//                 widget.onSelectDate(prevWeek);
//           //  widget.fetchData;
//               },
//             ),
//             Row(
//               children: [
//                 for (int i = 0; i < 7; i++)
//                   GestureDetector(
//                     // onTap: () => onSelectDate(days[i]),
//                     child: Container(
//                       padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//                       decoration: BoxDecoration(
//                         // color: days[i].day == selectedDate.day ? Colors.orange : null,
//                         borderRadius: BorderRadius.circular(8.0),
//                       ),
//                       child: Text(
//                         DateFormat('E').format(days[i]),
//                         style: TextStyle(
//                           fontWeight: days[i].day == widget.selectedDate.day ? FontWeight.bold : FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//               ],
//             ),
//             IconButton(
//               icon: Icon(Icons.arrow_forward_ios),
//               onPressed: ()async {
//                 DateTime nextWeek = widget.selectedDate.add(Duration(days: 7));
//                 widget.onSelectDate(nextWeek);
//               // await  fetchOpenShiftss();
//              widget.futureFunction;
//               },
//             ),
//           ],
//         ),
//         SizedBox(height: 10.0),
//         // SingleChildScrollView(
//         //   scrollDirection: Axis.horizontal,
//         //   child: Row(
//         //     children: [
//         //       for (int i = 0; i < 7; i++)
//         //         GestureDetector(
//         //           onTap: () => onSelectDate(days[i]),
//         //           child: Container(
//         //             margin: EdgeInsets.symmetric(horizontal: 10.0),
//         //             padding: EdgeInsets.all(8.0),
//         //             decoration: BoxDecoration(
//         //               color: days[i].day == selectedDate.day ? Colors.orange : null,
//         //               borderRadius: BorderRadius.circular(8.0),
//         //             ),
//         //             child: Text(
//         //               DateFormat('d').format(days[i]),
//         //               style: TextStyle(
//         //                 fontWeight: days[i].day == selectedDate.day ? FontWeight.bold : FontWeight.normal,
//         //               ),
//         //             ),
                 

                    
//         //           ),
                  
//         //         ),
                
//         //     ],
//         //   ),
//         // ),

//         SingleChildScrollView(
//           scrollDirection: Axis.horizontal,
//           child: Row(
//             children: [
//               for (int i = 0; i < 7; i++)
//                 GestureDetector(
//                   onTap: () async{
//                   // await  widget.fetchData;
//                     widget.onSelectDate(days[i]);
                  
//                   } ,
//                   child: Stack(
//                     children: [
//                       Container(
//                         margin: EdgeInsets.symmetric(horizontal: 5.0),
//                         padding: EdgeInsets.all(8.0),
//                         decoration: BoxDecoration(
//                           color: days[i].day == widget.selectedDate.day ? Colors.orange : null,
//                           borderRadius: BorderRadius.circular(8.0),
//                         ),
//                         child: Text(
//                           DateFormat('d').format(days[i]),
//                           style: TextStyle(
//                             fontWeight: days[i].day == widget.selectedDate.day ? FontWeight.bold : FontWeight.normal,
//                           ),
//                         ),
//                       ),
//                       if (widget.openShiftDates.contains(DateFormat('yyyy-MM-dd').format(days[i])))
//                         Positioned(
//                           top: 0,
//                           right: 0,
//                           child: Container(
//                             width: 8.0,
//                             height: 8.0,
//                             decoration: BoxDecoration(
//                               color: Colors.red,
//                               shape: BoxShape.circle,
//                             ),
//                           ),
//                         ),
//                     ],
//                   ),
//                 ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// // 