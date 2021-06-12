import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final List<String> arrayList;
  String valueSelected;

  DropDown({Key key, @required this.arrayList, @required this.valueSelected})
      : super(key: key);
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.valueSelected,
      onChanged: (value) {
        setState(() {
          widget.valueSelected = value;
        });
      },
      items: widget.arrayList.map<DropdownMenuItem<String>>((value) {
        return DropdownMenuItem(
          child: Text(
            value,
            style: TextStyle(fontSize: 20),
          ),
          value: value,
        );
      }).toList(),
    );
  }
}
