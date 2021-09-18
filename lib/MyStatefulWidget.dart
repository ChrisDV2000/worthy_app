import 'dart:async';

import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:percent_indicator/percent_indicator.dart';

/// This is the stateful widget that the main application instantiates.
class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {

  Duration duration = Duration();
  Timer? timer;

  @override
  void initState(){
    super.initState();

    startTimer();
  }

  void addTime() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  double percentage(currentTime, maxTime) {
    if (duration.inMicroseconds < maxTime) {
      return duration.inMicroseconds / maxTime;
    }
    else{
      return 1.0;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: buildTime()),
    );
  }

  Widget buildTime() {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final days = twoDigits(duration.inDays.remainder(24));
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    double percentage = (duration.inMicroseconds/ 30000000)*100;
    final Percentage = double.parse((percentage).toStringAsFixed(1));
    final maxTime = 1;

    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      appBar: AppBar(
        backgroundColor: Color(0xFF616F3A),
        centerTitle: true,
        title: Text("")
      ),
      body: SafeArea(
        child: Container(
          child: Center(
            child: ListView(
              children: <Widget> [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: EdgeInsets.only(top: 50.0),
                      child: CircularPercentIndicator(
                        percent: percentage,
                        radius: 0.5*MediaQuery.of(context).size.width,
                        lineWidth: 20.0,
                        circularStrokeCap: CircularStrokeCap.butt,
                        center: new Text(
                          '$Percentage%',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                          ),
                        ),
                        progressColor: Color(0xFF97BC62),
                        backgroundColor: Color(0xFF2C5F2D),
                    ),
                  ),
                ),
                Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        buildTimeCard(time: days, header: 'DAYS'),
                        const SizedBox(width: 8),
                        buildTimeCard(time: hours, header: 'HOURS'),
                        const SizedBox(width: 8),
                        buildTimeCard(time: minutes, header: 'MINUTES'),
                        const SizedBox(width: 8),
                        buildTimeCard(time: seconds, header: 'SECONDS'),
                      ],
                    ),
                  // Text(
                  //   '$hours:$minutes:$seconds',
                  //   style: TextStyle(fontSize: 80),
                  // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const  DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF616F3A),
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Check In'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
            ListTile(
              title: const Text('Tracker'),
              onTap: () {
                // Update the state of the app
                // ...
                // Then close the drawer
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
  Widget buildTimeCard({required String time, required String header}) => 
  Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Color(0xFF616F3A),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          time,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 72,
          ),
        ),
      ),
      const SizedBox(height: 24),
      Text(header),
    ],
  );

}