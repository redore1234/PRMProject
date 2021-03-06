import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';

class AddTaskSubject extends StatefulWidget {
  _AddTaskSubjectPageState createState() => _AddTaskSubjectPageState();
}

class _AddTaskSubjectPageState extends State<AddTaskSubject> {
  DateTime selectedDate = DateTime.now();
  String estimateTime, description;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    Size size = MediaQuery.of(context).size;

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
              "add task".toUpperCase(),
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Subject'),
                          SizedBox(
                            width: 125,
                          ),
                          DropDown(
                              arrayList: ['PRM391', 'SWD392'],
                              valueSelected: 'PRM391')
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Topic'),
                          SizedBox(
                            width: 143,
                          ),
                          DropDown(
                              arrayList: ['PRM391', 'SWD392'],
                              valueSelected: 'PRM391')
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Category'),
                          SizedBox(
                            width: 110,
                          ),
                          DropDown(
                              arrayList: ['PRM391', 'SWD392'],
                              valueSelected: 'PRM391')
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Priority'),
                          SizedBox(
                            width: 125,
                          ),
                          DropDown(
                              arrayList: ['PRM391', 'SWD392'],
                              valueSelected: 'PRM391')
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Due Date'),
                          SizedBox(
                            width: 110,
                          ),
                          SizedBox(
                            width: 100,
                            child: TextFormField(
                              style: TextStyle(fontSize: 20),
                              focusNode: AlwaysDisabledFocusNode(),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              controller: TextEditingController(
                                  text: '${selectedDate.toLocal()}'.split(' ')[0]),
                              onTap: () {
                                _selectDate(context);
                              },
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Estimated Time'),
                          SizedBox(
                            width: 50,
                          ),
                          SizedBox(
                            width: 50,
                            child: TextFormField(
                              // validator: (String value) {
                              //   if (value.isEmpty) {
                              //     return "Field is not empty";
                              //   }
                              //   return null;
                              // },
                              decoration: InputDecoration(),
                              onChanged: (text) {
                                estimateTime = text;
                              },
                            ),
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Text(
                            'times',
                            style: TextStyle(fontSize: 20),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 20,
                          ),
                          _labelTitle('Description'),
                          SizedBox(
                            width: 50,
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                          child: SizedBox(
                            width: 350,
                            child: TextFormField(
                              onChanged: (text) {
                                //description = text;
                              },
                              maxLines: 5,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5))),
                            ),
                          )),
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                          width: size.width * 0.8,
                          alignment: Alignment.center,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30.0)),
                            padding:
                            EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                            color: Colors.orangeAccent,
                            onPressed: () {},
                            child: Text(
                              'ADD TASK',
                              style: TextStyle(
                                  color: Colors.white, fontWeight: FontWeight.bold),
                            ),
                          ))
                    ],
                  ))),
        ));
  }

  Widget _labelTitle(String title) {
    return Text(title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
