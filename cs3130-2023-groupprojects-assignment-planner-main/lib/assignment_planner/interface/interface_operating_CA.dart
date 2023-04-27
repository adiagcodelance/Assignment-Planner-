///An interface for the operation of courses and assignments
abstract class iOperatingCA {
  //update data to course or assignment
  bool updateTo({required String userInfo, required String userObjStr});

  //add new course or assignment to database
  bool insertTo({required String userInfo, required String userObjStr});

  //delete the course or assignment that doesn't require.
  Future<String> selectTo({required String userInfo});
}
