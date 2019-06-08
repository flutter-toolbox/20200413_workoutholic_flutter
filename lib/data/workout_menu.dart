import 'package:cloud_firestore/cloud_firestore.dart';

class WorkoutMenu{
  static Stream<QuerySnapshot> getMenuFromWorkoutSet(List<String> workoutIds) {
    return Firestore.instance
        .collection("workoutMenu")
        .where('workoutId', arrayContains: workoutIds)
        .snapshots();
  }
}