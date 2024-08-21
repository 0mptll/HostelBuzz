import 'package:flutter/material.dart';
import 'food_item.dart'; // Adjust path as necessary

class FoodVoteScreen extends StatefulWidget {
  @override
  _FoodVoteScreenState createState() => _FoodVoteScreenState();
}

class _FoodVoteScreenState extends State<FoodVoteScreen> {
  final List<FoodItem> foodItems = [
    FoodItem(name: 'Pasta', votes: 0),
    FoodItem(name: 'Pizza', votes: 0),
    FoodItem(name: 'Samosa', votes: 0),
  ];

  void _vote(int index) {
    setState(() {
      if (foodItems[index].votes == 0) {
        foodItems[index].votes += 1;
      } else {
        foodItems[index].votes = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Food Voting')),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(foodItems[index].name),
            subtitle: Text('Votes: ${foodItems[index].votes}'),
            trailing: IconButton(
              icon: Icon(Icons.thumb_up),
              onPressed: () => _vote(index),
            ),
          );
        },
      ),
    );
  }
}
