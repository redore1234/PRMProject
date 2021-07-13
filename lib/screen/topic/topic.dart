import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project/global/dropdown.dart';
import 'package:project/models/plantopic_model.dart';
import 'package:project/models/subject_model.dart';
import 'package:project/screen/task/task_detail.dart';
import 'package:project/services/plan_topic_service.dart';
import 'package:project/services/subject_service.dart';
import 'package:project/services/task_service.dart';
import 'package:project/services/topic_service.dard.dart';
import 'package:project/widget/base_ontap_widget.dart';
import 'package:switcher/core/switcher_size.dart';
import 'package:switcher/switcher.dart';

class TopicPage extends StatefulWidget {
  final int topicId;
  final int planSubjectId;

  final String bearerToken;

  const TopicPage({Key key, @required this.topicId, this.planSubjectId, @required this.bearerToken}) : super(key: key);

  _TopicPageState createState() => _TopicPageState(this.topicId, this.planSubjectId, this.bearerToken);
}

class _TopicPageState extends State<TopicPage> {
  DateTime selectedDate = DateTime.now();
  final int topicId;
  final int planSubjectId;
  final String bearerToken;
   int planTopicIc;


  _TopicPageState(this.topicId, this.planSubjectId, this.bearerToken);

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
            "TOPIC".toUpperCase(),
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          actions: <Widget>[],
        ),
        body: Container(
          child: FutureBuilder(
            future: TopicService.read(id: '$topicId', bearerToken: bearerToken),
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData) {
                print("subject detail: " + bearerToken);


                print('hasdata111111');

                return Container(
                  child: Column(
                    children: [
                      Text(snapshot.data[0].topicName,
                          style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
                      Text(
                          snapshot.data[0].topicDescription,
                          style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                      Expanded(
                        child: Container(
                          color: Colors.grey,

                          child:  FutureBuilder(
                              future: PlanTopicService.read(planSubjectId: '$planSubjectId', topicId: '$topicId', bearerToken: bearerToken),
                              builder: (BuildContext context, snapshot){
                                if(snapshot.hasData){
                                  print("has data:");
                                  final data = snapshot.data as List<PlanTopicModel>;
                                   planTopicIc = data.elementAt(0).planTopicId;
                                   print("data: " + '$planTopicIc');


                                }
                                return Container(
                                  child: FutureBuilder(
                                    future: TaskService.read(planTopicId: '$planTopicIc', bearerToken: bearerToken),
                                    builder: (BuildContext context, snapshot) {
                                      if (snapshot.hasData) {
                                        print("has data task");
                                        return ListView.builder(
                                          itemCount: snapshot.data.length,
                                          itemBuilder: (context, index) {
                                            return Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10),
                                              child: subjectCourse(
                                                context,
                                                snapshot.data[index].taskDescription,
                                                snapshot.data[index].dueDate,
                                                snapshot.data[index].effortTime,
                                                snapshot.data[index].estimateTime,
                                                snapshot.data[index].taskId,
                                                bearerToken,
                                              ),
                                            );
                                          },
                                        );
                                      } else {
                                        print("hello");
                                        return Center(
                                          child: CircularProgressIndicator(
                                            semanticsLabel: 'Loading...',
                                          ),
                                        );
                                      }
                                    },
                                  ),
                                );
                              }
                          ),



                        ),
                        flex: 12,
                      ),
                      // Expanded(
                      //   child: Container(
                      //     color: Colors.green,
                      //     child: FutureBuilder(
                      //       future: TopicService.read(bearerToken: bearerToken),
                      //       builder: (BuildContext context, snapshot) {
                      //         if (snapshot.hasData) {
                      //           print('hasdata');
                      //
                      //           return ListView.builder(
                      //             itemCount: snapshot.data.length,
                      //             itemBuilder: (context, index) {
                      //               return Padding(
                      //                 padding: const EdgeInsets.symmetric(
                      //                     vertical: 10),
                      //                 child: subjectCourse(
                      //                   context,
                      //                   snapshot.data[index].topicName,
                      //                   snapshot.data[index].topicDescription,
                      //                 ),
                      //               );
                      //             },
                      //           );
                      //         } else {
                      //           return Center(
                      //             child: CircularProgressIndicator(
                      //               semanticsLabel: 'Loading...',
                      //             ),
                      //           );
                      //         }
                      //       },
                      //     ),
                      //
                      //
                      //
                      //   ),
                      //   flex: 12,
                      // )


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
Widget subjectCourse(BuildContext context, String description,
    String dueDate, int effortTime, int estimateTime, int taskId, String bearerToken) {
  return FlatButton(
      padding: EdgeInsets.all(20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      color: Color(0xFFF5F6F9),
      onPressed: () {

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TaskDetailPage(taskId: taskId, bearerToken: bearerToken,),
          ),
        );
        print("pressed");
      },
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(description,
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                Text(
                   dueDate,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("Effort spent: " + '$effortTime' + "/" + '$estimateTime' + " hours",
                    style:
                    TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),



              ],
            ),
          ),
          Icon(Icons.arrow_forward_ios),
        ],
      ));
}