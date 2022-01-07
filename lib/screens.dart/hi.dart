import 'package:flutter/material.dart';

class Hi extends StatelessWidget {
  const Hi({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.thumb_up,
                  size: 100,
                  color: Colors.white,
                ),
                Text(
                  '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 150,
                  ),
                ),
              ],
            ),
            const CircleAvatar(
              radius: 150,
              backgroundColor: Colors.black,
              child: Text(
                'or',
                style: TextStyle(
                    fontSize: 200,
                    fontWeight: FontWeight.w900,
                    color: Colors.white),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.thumb_down,
                  size: 100,
                  color: Colors.white,
                ),
                Text(
                  '?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 150,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
