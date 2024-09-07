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
              'assets/DDU_2.png', // Path to your logo
              height: 40, // Adjust as needed
            ),
            SizedBox(width: 10), // Space between logo and title
            Text('Welcome to DDU Hostel'),
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
            SizedBox(height: 16), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/reviews');
              },
              child: Text('Rate and Review Food'),
            ),
            SizedBox(height: 16), // Space between buttons
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/maintenance');
              },
              child: Text('Maintenance Requests'),
            ),
          ],
        ),
      ),
    );
  }
}
