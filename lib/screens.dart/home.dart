import 'dart:async';
import 'dart:convert';

import 'package:countdown_timer/models/countdown.dart';
import 'package:countdown_timer/screens.dart/add_countdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late SharedPreferences prefs;
  List<Countdown> countdowns = [];
  late String? countdownsJson;
  @override
  void initState() {
    getCountdownsFromSharedPreferences();
    super.initState();
  }

  void getCountdownsFromSharedPreferences() async {
    prefs = await SharedPreferences.getInstance();
    List<dynamic>? results =
        jsonDecode(prefs.getString('countdowns').toString());
    if (results != null) {
      for (dynamic result in results) {
        Countdown currentCountdown = Countdown(
          id: result['id'],
          doneAt: DateTime.parse(result['doneAt']),
          description: result['description'],
        );
        setState(() {
          countdowns.add(currentCountdown);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    Countdown? _newCountdown;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Countdown Timer'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: countdowns.isNotEmpty
          ? ListView.builder(
              itemCount: countdowns.length,
              itemBuilder: (context, index) {
                String count = countdowns[index].getTimeLeft();
                Timer.periodic(const Duration(seconds: 1), (Timer t) {
                  setState(() {
                    count = countdowns[index].getTimeLeft();
                  });
                });
                return Dismissible(
                  background: Container(
                    color: Colors.red,
                    width: double.infinity,
                    child: const Center(
                        child: Text('Remove',
                            style: TextStyle(color: Colors.white))),
                  ),
                  key: Key(countdowns[index].id.toString()),
                  onDismissed: (direction) {
                    setState(() {
                      countdowns.removeAt(index);
                      // updateJsonData();
                    });
                  },
                  child: ListTile(
                    title: Text(countdowns[index].description),
                    trailing: Text(count),
                  ),
                );
              })
          : const Center(
              child: Text(
                'No countdowns yet.',
              ),
            ),
      floatingActionButton: FloatingActionButton.extended(
        label: Row(
          children: const [
            Icon(Icons.add),
            SizedBox(width: 10),
            Text('New timer'),
          ],
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        splashColor: Colors.white,
        highlightElevation: 0,
        onPressed: () async {
          _newCountdown = await showCupertinoModalPopup(
            context: context,
            builder: (context) {
              return AddCountdown(lastID: countdowns.length);
            },
          );
          if (_newCountdown != null) {
            countdowns.add(_newCountdown!);
          }
          setState(() {
            updateJsonData();
          });
        },
        //child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Future<void> updateJsonData() async {
    countdownsJson = jsonEncode(countdowns);
    await prefs.setString('countdowns', countdownsJson!);
  }
}
