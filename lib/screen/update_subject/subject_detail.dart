import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';
import 'package:project/models/subject_model.dart';
import 'package:project/screen/topic/topic.dart';
import 'package:project/services/subject_service.dart';
import 'package:project/services/topic_service.dard.dart';
import 'package:project/widget/base_ontap_widget.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class SubjectDetailPage extends StatefulWidget {
  final String id;
  final int planSubjectId;
  final String bearerToken;

  const SubjectDetailPage({Key key, @required this.id, this.planSubjectId, @required this.bearerToken}) : super(key: key);

  _SubjectDetailPageState createState() => _SubjectDetailPageState(this.id, this.planSubjectId, this.bearerToken);
}

class _SubjectDetailPageState extends State<SubjectDetailPage> {
  DateTime selectedDate = DateTime.now();
  final String id;
  final int planSubjectId;
  final String bearerToken;


  _SubjectDetailPageState(this.id, this.planSubjectId, this.bearerToken);

  // Future<void> load() async {
  //   SubjectService.read(id: id).then((value) {
  //     subject = value[0];
  //     subjectIdController.value =
  //         subjectIdController.value.copyWith(text: subject.id);
  //     subjectNameController.value =
  //         subjectIdController.value.copyWith(text: subject.name);
  //     subjectSourceController.value =
  //         subjectIdController.value.copyWith(text: subject.source);
  //     subjectGroupIdController.value =
  //         subjectIdController.value.copyWith(text: "${subject.subjectGroupId}");
  //   });
  // }

  @override
  void initState() {
    // load();
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext content) {
    Size size = MediaQuery.of(context).size;
    // subjectIdController.text = id;
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            "subject detail".toUpperCase(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: Container(
          child: FutureBuilder(
            future: SubjectService.read(id: id, bearerToken: bearerToken),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                return Container(
                  child: Column(
                    children: [
                      Text(snapshot.data[0].id,
                          style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      Text(
                        snapshot.data[0].name,
                        style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Container(
                          color: Colors.green,
                          child: FutureBuilder(
                            future: TopicService.read(subjectId: id,bearerToken: bearerToken),
                            builder: (BuildContext context, snapshot) {
                              if (snapshot.hasData) {
                                return ListView.builder(
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: subjectCourse(
                                        context,
                                        snapshot.data[index].topicName,
                                        snapshot.data[index].topicDescription,
                                        snapshot.data[index].topicId,
                                        planSubjectId,
                                        bearerToken,
                                      ),
                                    );
                                  },
                                );
                              } else {
                                return Center(
                                  child: CircularProgressIndicator(
                                    semanticsLabel: 'Loading...',
                                  ),
                                );
                              }
                            },
                          ),



                        ),
                        flex: 12,
                      )


                    ],
                  ),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    semanticsLabel: 'Loading...',
                  ),
                );
              }
            },
          ),
        ),

      ),
    );
  }

  Widget _formFieldContainer(String title, {Widget child}) {
    return Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                title,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
            ),
            child
          ],
        ));
  }

  Widget _labelTitle(String title) {
    return Text(title,
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20));
  }
}
Widget subjectCourse(BuildContext context, String subjectCode,
    String subjectName, int topicId, int planSubjectId, String bearerToken) {
  return FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xFFF5F6F9),
      onPressed: () {
        // Navigate to Update

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TopicPage(topicId: topicId, planSubjectId: planSubjectId, bearerToken: bearerToken),
          ),
        );
        print("pressed");
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(subjectCode,
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                  subjectName,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),


              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ));
}