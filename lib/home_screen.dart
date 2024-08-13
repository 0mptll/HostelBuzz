import 'package:flutter/material.dart';
import 'custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/img.png', // Path to your logo
              height: 40, // Adjust as needed
            ),
            SizedBox(width: 10), // Space between logo and title
            Text('HostelBuzz Home'),
          ],
        ),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/foodVote');
              },
              child: Text('Vote on Food'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reviews');
              },
              child: Text('Rate and Review Food'),
            ),
          ],
        ),
      ),
    );
  }
}
