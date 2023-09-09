import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class NewsScreen extends StatefulWidget {
  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen> {
  Future<List<Map<String, dynamic>>> fetchNews() async {
    final apiUrl = 'https://sandbox1.autumntrack.com/api/v2/news/?apikey=MYhsie8n4&fac=Autumn%20Demo&position=RN';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(response.body);
      return List<Map<String, dynamic>>.from(jsonResponse['data']);
    } else {
      throw Exception('Failed to fetch news');
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
   
         return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('News',style: TextStyle(fontWeight: FontWeight.bold),),
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
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: fetchNews(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (snapshot.data == null || snapshot.data!.isEmpty) {
              return Center(child: Text('No news available'));
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var news = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                       borderRadius: BorderRadius.circular(15),
                                                  elevation: 20,
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Container(
                            decoration: BoxDecoration(
                                      
                                       // Replace with your desired background color
                                        borderRadius: BorderRadius.circular(20), // Adjust the radius as needed
                                      ),
                                        
                                        margin: EdgeInsets.symmetric(horizontal: 16.0,),
                                    
                                   
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  news['subject'],
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Text(news['message']),
                                SizedBox(height: 10),
                                Text(
                                  news['date'],
                                  style: TextStyle(color: Colors.grey),
                                ),
                                SizedBox(height: 10),
                                news['ImageData'].isEmpty
                                    ? Container()
                                    : Image.network(
                                        news['ImageData'],
                                        width: 100,
                                        height: 50,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
