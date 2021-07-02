import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/screen/subject/subject.dart';
import 'package:project/services/subject_service.dart';
import 'package:project/widget/base_ontap_widget.dart';

class SearchSubjectPage extends StatefulWidget {
  final String searchValue;

  const SearchSubjectPage({Key key, @required this.searchValue})
      : super(key: key);

  _SearchSubjectPageState createState() =>
      _SearchSubjectPageState(this.searchValue);
}

class _SearchSubjectPageState extends State<SearchSubjectPage> {
  final String searchValue;

  _SearchSubjectPageState(this.searchValue);

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
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "search subject".toUpperCase(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: Container(
          height: size.height,
          width: double.infinity,
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  TextFormField(
                    // initialValue: "",
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
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: BaseOnTapWidget(
                      onTap: () {
                        // Validate returns true if the form is valid, or false otherwise.
                        print("click search with value: " + myController.text);
                        if (_formKey.currentState.validate()) {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (BuildContext context) {
                              final text = myController.text == null
                                  ? ""
                                  : myController.text;
                              print("search text = " + text);
                              return SearchSubjectPage(searchValue: text);
                            }),
                          );
                        }
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                        child: Text(
                          'Submit',
                          style: TextStyle(color: Colors.white),
                        ),
                        decoration: BoxDecoration(color: Colors.black),
                      ),
                    ),
                  ),
                  Container(
                    height: size.height,
                    width: double.infinity,
                    child: searchValue != ""
                        ? FutureBuilder(
                            future: SubjectService.read(
                                searchValue: searchValue),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                // print("hasdata");
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: subjectCourse(
                                        context,
                                        snapshot.data[index].id,
                                        snapshot.data[index].name,
                                        snapshot.data[index].source,
                                        '${snapshot.data[index].subjectGroupId}',
                                      ),
                                    );
                                  },
                                );
                              } else {
                                // print("nodata");
                                return Center(
                                  child: CircularProgressIndicator(
                                    semanticsLabel: 'Loading...',
                                  ),
                                );
                              }
                            },
                          )
                        : Container(

                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
