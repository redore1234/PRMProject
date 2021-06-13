import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';

class SearchSubjectPage extends StatefulWidget {
  _SearchSubjectPageState createState() => _SearchSubjectPageState();
}

class _SearchSubjectPageState extends State<SearchSubjectPage> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final searchSubjectController = TextEditingController();

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
          'Choose Subject',
          style: TextStyle(fontSize: 20),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Form(
              key: _formKey,
              child: Card(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Search Subject',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 20,
                        ),
                        SizedBox(
                            height: 50,
                            width: 280,
                            child: TextFormField(
                              controller: searchSubjectController,
                              decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  border: new OutlineInputBorder(
                                    borderRadius:
                                        new BorderRadius.circular(25.0),
                                    borderSide: new BorderSide(),
                                  )),
                            )),
                        SizedBox(
                          width: 20,
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.search_outlined,
                              size: 35,
                            ))
                      ],
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                        ),
                        DropDown(
                            arrayList: ['PRM391', 'SWD392'],
                            valueSelected: 'PRM391'),
                        SizedBox(width: 100),
                        DropDown(
                            arrayList: ['PRM391', 'SWD392'],
                            valueSelected: 'PRM391'),
                      ],
                    ),
                  ],
                ),
              ))
        ],
      ),
    ));
  }
}
