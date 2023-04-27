import 'package:assignment_planner/assignment_planner/routes/route_generator.dart';
import 'package:flutter/material.dart';

import 'login_view.dart';

final List<String> entries = <String>['A', 'B', 'C'];
final List<int> colorCodes = <int>[600, 500, 100];

class Courses extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      SizedBox(height: 30),
      Row(
        children: [
          SizedBox(width: 20),
          Text(
            'Courses',
            style:
                TextStyle(fontSize: 35, decoration: TextDecoration.underline),
          ),
          SizedBox(width: 50),
          SizedBox(width: 50),
          SizedBox(width: 80),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            FloatingActionButton(
              onPressed: () {
                Navigator.pushNamed(context, RouteGenerator.courseForm);
              },
              backgroundColor: Colors.purple,
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
          shrinkWrap: true,
          //controller: _controller,
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(8),
          itemCount: user.userInfo.courseList!.length,
          itemBuilder: _getListItemTile,
          separatorBuilder: (BuildContext context, int index) => const Divider(
            color: Colors.black,
            height: 1.0,
            thickness: 1,
          ),
        ),
      ),
    ]);
  }

  Widget _getListItemTile(BuildContext context, int index) {
    return Dismissible(
      key: Key(user.userInfo.courseList![index].courseName),
      onDismissed: (direction) {
        if (direction == DismissDirection.endToStart) {
          user.deleteCourse(
              courseName: user.userInfo.courseList![index].courseName,
              courseNumber: user.userInfo.courseList![index].courseNumber);
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
            '${user.userInfo.courseList![index].courseNumber} - ${user.userInfo.courseList![index].courseName}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          onTap: () {
            //print(index);
            user.updateIndex(i: index);
            Navigator.pushNamed(context, RouteGenerator.assignments);
          },
        ),
      ),
    );
  }
}
