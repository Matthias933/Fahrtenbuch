// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fahrtenbuch/db/database.dart';
import 'package:fahrtenbuch/entities/person.dart';
import 'package:fahrtenbuch/entities/properties.dart';
import 'package:fahrtenbuch/entities/ride.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final myBox = Hive.box('myBox');
  Database db = Database();
  List<Person>? personList = [];
  late bool isConnected;

  @override
  void initState() {
    super.initState();

    //Checks for connectivity once application is being started
    checkConnectivity();

    //Check if database has old rides saved in it
    initialDataCheck();

    //Start a listener which calls a updateds the connecitivityStatus everytime it has been changed
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      setState(() {
        if (result == ConnectivityResult.wifi) {
          checkForUpdates();
        } else {
          isConnected = false;
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 10,
          title: Text('Fahrtenbuch',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () => initialDataCheck(), icon: Icon(Icons.settings))
          ],
        ),
        body: Stack(
          children: [
            Center(
              child: Container(
                color: Colors.grey,
              ),
            ),
            Positioned(
              bottom: 10,
              left: 10,
              child: Row(
                children: [
                  Container(
                    width: 20,
                    height: 20,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: isConnected ? Colors.green : Colors.red),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Text(
                      isConnected ? 'Connected' : 'Disconnected',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            )
          ],
        ));
  }

  void initialDataCheck() {
    if (myBox.get('RIDELIST') != null) {
      db.loadData();
      print('Rides not empty');

      for (var item in db.rideList) {
        print(item.commanderId.toString());
      }
    } else {
      print('Rides are empty');
    }
    if (isConnected) {
    } else {
      print('not connected');
    }
  }

  void sendFormular(Ride ride) {

    if (isConnected) {
      postRide(ride);
    } else {
      db.rideList.add(ride);
      db.updateData();
    }
  }

  void checkForUpdates() {
    isConnected = true;
  }

  void checkConnectivity() {
    var result = Connectivity().checkConnectivity();
    if (result == ConnectivityResult.wifi) {
      isConnected = true;
    } else {
      isConnected = false;
    }
  }

  void signIn() async {
    final uri = Uri.http('localhost:3000', '/signIn', {
      'name': Properties.USERNAME,
      'password': Properties.PASSWORD,
    });

    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Properties.TOKEN = response.body;
      print('signIn complete');
    } else {
      print('Invalid password or server error.');
    }
  }

  void postRide(Ride ride) {
    final response = http.post(Uri.parse(Properties.BASE_URL + '/ride'),
        headers: {
          'Authorization': 'Bearer ${Properties.TOKEN}',
          'Content-Type': 'application/json',
        },
        body: jsonEncode(ride.toJson()));
  }

  void fetchPeople() async {
    print(Properties.TOKEN);
    List<Person> persons;
    final response = await http.get(
      Uri.parse(Properties.BASE_URL + '/people'),
      headers: {
        'Authorization': 'Bearer ${Properties.TOKEN}',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = jsonDecode(response.body);
      persons = jsonData
          .map((e) => Person.fromJson(e as Map<String, dynamic>))
          .toList();
      setState(() {
        personList = persons;
      });
    } else if (response.statusCode == 401) {
      print('Error Unauthorized');
    } else {
      print('ERROR: Could not fetch data.');
    }
  }
}
