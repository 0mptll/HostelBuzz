import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileCompletionScreen extends StatefulWidget {
  @override
  _ProfileCompletionScreenState createState() => _ProfileCompletionScreenState();
}

class _ProfileCompletionScreenState extends State<ProfileCompletionScreen> {
  final _formKey = GlobalKey<FormState>();
  final supabase = Supabase.instance.client;

  String? roomNo;
  String? wing;
  String? mobileNo;
  DateTime? dateOfJoining;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Update user metadata in Supabase
      final user = supabase.auth.currentUser;
      final response = await supabase.from('users').update({
        'room_no': roomNo,
        'wing': wing,
        'mobile_no': mobileNo,
        'date_of_joining': dateOfJoining?.toIso8601String(),
      }).eq('id', user!.id).execute();

      if (response.error == null) {
        // Navigate to Home Screen after successful profile completion
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        // Handle error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: ${response.error!.message}')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Complete Your Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Room Number'),
                validator: (value) => value!.isEmpty ? 'Please enter your room number' : null,
                onSaved: (value) => roomNo = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Wing'),
                validator: (value) => value!.isEmpty ? 'Please enter your wing' : null,
                onSaved: (value) => wing = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Mobile Number'),
                validator: (value) => value!.isEmpty ? 'Please enter your mobile number' : null,
                onSaved: (value) => mobileNo = value,
              ),
              GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: dateOfJoining ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (pickedDate != null && pickedDate != dateOfJoining) {
                    setState(() {
                      dateOfJoining = pickedDate;
                    });
                  }
                },
                child: AbsorbPointer(
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Date of Joining',
                      hintText: dateOfJoining != null ? dateOfJoining!.toLocal().toString().split(' ')[0] : 'Select Date',
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

extension on PostgrestFilterBuilder {
  execute() {}
}
