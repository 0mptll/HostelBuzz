import 'package:flutter/material.dart';
import 'food_item.dart';

class FoodVoteScreen extends StatefulWidget {
  const FoodVoteScreen({super.key});

  @override
  _FoodVoteScreenState createState() => _FoodVoteScreenState();
}

class _FoodVoteScreenState extends State<FoodVoteScreen> {
  final List<FoodItem> foodItems = [
    FoodItem(name: 'Pasta', votes: 0),
    FoodItem(name: 'Pizza', votes: 0),
    FoodItem(name: 'Samosa', votes: 0),
    FoodItem(name: 'Vada Pav', votes: 0),
    FoodItem(name: 'Aloo Paratha', votes: 0),
    FoodItem(name: 'Pav Bhaji', votes: 0),
    FoodItem(name: 'Chole Bhature', votes: 0),
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
      appBar: AppBar(
        title: const Text('Food Voting'),
        backgroundColor: Colors.teal, // Consistent theme color
      ),
      body: ListView.builder(
        itemCount: foodItems.length,
        itemBuilder: (context, index) {
          final foodItem = foodItems[index];
          return Card(
            elevation: 5,
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16),
              title: Text(
                foodItem.name,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              subtitle: Text(
                'Votes: ${foodItem.votes}',
                style: const TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                icon: Icon(
                  foodItem.votes > 0 ? Icons.thumb_down : Icons.thumb_up,
                  color: foodItem.votes > 0 ? Colors.teal : Colors.green,
                ),
                onPressed: () => _vote(index),
              ),
            ),
          );
        },
      ),
    );
  }
}
