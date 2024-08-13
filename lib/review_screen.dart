import 'package:flutter/material.dart';
import 'review.dart';

class ReviewScreen extends StatefulWidget {
  @override
  _ReviewScreenState createState() => _ReviewScreenState();
}

class _ReviewScreenState extends State<ReviewScreen> {
  final List<Review> reviews = [];

  final TextEditingController _controller = TextEditingController();

  void _addReview(String reviewText) {
    setState(() {
      reviews.add(Review(text: reviewText, date: DateTime.now()));
    });
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Rate and Review Food')),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: reviews.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(reviews[index].text),
                  subtitle: Text(reviews[index].date.toString()),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(labelText: 'Write a review'),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    if (_controller.text.isNotEmpty) {
                      _addReview(_controller.text);
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
