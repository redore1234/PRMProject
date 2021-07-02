import 'package:flutter/material.dart';
import 'package:project/screen/home/home.dart';
import 'package:project/screen/search_subject/search_subject.dart';
import 'package:project/screen/subject/subject.dart';

class MyCustomForm extends StatefulWidget {
  final String searchValue;
  const MyCustomForm({Key key, @required this.searchValue}) : super(key: key);
  @override
  MyCustomFormState createState() {
    return MyCustomFormState(this.searchValue);
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final String searchValue;
  MyCustomFormState(this.searchValue);
  final _formKey = GlobalKey<FormState>();
  final myController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            // The validator receives the text that the user has entered.
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              return null;
            },
            controller: myController,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: ElevatedButton(
              onPressed: () {
                // Validate returns true if the form is valid, or false otherwise.
                if (_formKey.currentState.validate()) {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return SearchSubjectPage(searchValue: myController.text,);
                  }));
                  // Navigator.pop(context);
                }
              },
              child: Text('Submit'),
            ),
          ),
        ],
      ),
    );
  }
}
