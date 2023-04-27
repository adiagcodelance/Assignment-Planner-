import 'package:assignment_planner/assignment_planner/model/assignment_model.dart';
import 'package:assignment_planner/assignment_planner/routes/route_generator.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

int index = 0;

class Assignments extends StatelessWidget {
  List<String> generateItems(int numberOfItems) {
    return List.generate(numberOfItems, (int index) {
      return 'Item $index';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        centerTitle: true,
        backgroundColor: Colors.purple,
        title: Text(
          "UAP",
          style: TextStyle(
              color: Colors.white, decoration: TextDecoration.underline),
        ),
      ),
      body: Column(children: <Widget>[
        SizedBox(height: 30),
        Row(
          children: [
            SizedBox(width: 20),
            Text(
              'Assignment',
              style: TextStyle(fontSize: 35),
            ),
            SizedBox(width: 50),
            SizedBox(width: 50),
            SizedBox(width: 20),
            Row(mainAxisAlignment: MainAxisAlignment.end, children: [
              FloatingActionButton(
                backgroundColor: Colors.purple,
                onPressed: () {
                  Navigator.pushNamed(context, RouteGenerator.assignmentForm);
                },
                child: Icon(
                  Icons.add,
                  size: 35,
                  color: Colors.white,
                ),
              ),
            ]),
          ],
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount:
                user.userInfo.courseList![user.index].assignmentList!.length,
            itemBuilder: _getListItemTile,
            separatorBuilder: (BuildContext context, int index) =>
                const Divider(
              height: 1.0,
              color: Colors.black,
              thickness: 1,
            ),
          ),
        ),
      ]),
    );
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return Dismissible(
      key: Key(user.userInfo.courseList![user.index].courseName),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          user.deleteAssignment(
              courseName: user.userInfo.courseList![user.index].courseName,
              assignmentName: user.userInfo.courseList![user.index]
                  .assignmentList![index].assignmentName);
        } else {
          Navigator.pushNamed(context, RouteGenerator.editCourseForm);
        }
      },
      //direction: DismissDirection.endToStart,
      secondaryBackground: Container(
        //alignment: AlignmentDirectional.centerEnd,
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
        color: Colors.red,
      ),
      background: Container(
        //alignment: AlignmentDirectional.centerStart,
        child: Icon(
          Icons.edit,
          color: Colors.black,
        ),
        color: Colors.grey,
      ),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: ListTile(
          title: Text(
            '${user.userInfo.courseList![user.index].courseName} - ${user.userInfo.courseList![user.index].assignmentList![index].assignmentName}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            //print(index);
            //user.updateIndex(i: index);
            //Navigator.pushNamed(context, RouteGenerator.assignments);
          },
        ),
      ),
    );
  }

  String emptyAssignmentList(List<AssignmentModel>? list) {
    if (list!.isEmpty) {
      return '${user.userInfo.courseList![user.index].courseName} - ${user.userInfo.courseList![user.index].assignmentList![index].assignmentName}';
    } else {
      return 'No Assignments, click add to add assignments.';
    }
  }
}
