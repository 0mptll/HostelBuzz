import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'HostelBuzz',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/');
            },
          ),
          ListTile(
            title: Text('Food Voting'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/foodVote');
            },
          ),
          ListTile(
            title: Text('Rate and Review'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/reviews');
            },
          ),
          ListTile(
            title: Text('Maintenance Requests'),
            onTap: () {
              Navigator.popAndPushNamed(context, '/maintenance');
            },
          ),
        ],
      ),
    );
  }
}
