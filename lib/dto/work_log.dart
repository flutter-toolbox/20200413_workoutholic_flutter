import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:workoutholic/const/work_type.dart';
import 'package:workoutholic/const/list_for_set_select.dart';
import 'package:workoutholic/dto/workout_set.dart';

class WorkLog implements ListForSetSelect {
  WorkLog(
      {this.documentID = '',
      this.userId = '',
      this.planCode = '',
      this.menuCode = '',
      this.menuNameJa = '',
      this.menuNameEn = '',
      this.date,
      this.workType = WorkType.LIFT,
      this.logs = const []});

  String documentID;
  String userId;
  String planCode;
  String menuCode;
  String menuNameJa;
  String menuNameEn;
  Timestamp date;
  WorkType workType;
  List<Map<String, num>> logs;

  static WorkLog of(DocumentSnapshot document) {
    if (!document.exists) {
      return new WorkLog();
    }
    return new WorkLog(
      documentID: document.documentID,
      userId: document['user_id'],
      planCode: document['plan_code'],
      menuCode: document['menu_code'],
      menuNameJa: document['menu_name_ja'],
      menuNameEn: document['menu_name_en'],
      date: document['date'] ?? '',
      workType: WorkType.of(document['work_type']),
      logs: _translateToMap(document['logs']),
    );
  }

  static List<Map<String, num>> _translateToMap(List<dynamic> list) {
    List<Map<String, num>> tranlatedList = new List();

    list.forEach((document) {
      Map<String, num> map = {
        "reps": document["reps"],
        "weight": document["weight"],
        "weightUnit": document["weightUnit"],
      };
      tranlatedList.add(map);
    });
    return tranlatedList;
  }

  bool isEmpty() {
    return this.documentID == '';
  }

  static Map<String, dynamic> toMap(WorkLog log) {
    Map<String, Object> data = new Map();
    data.putIfAbsent('user_id', () => log.userId);
    data.putIfAbsent('date', () => log.date);
    data.putIfAbsent('logs', () => log.logs);
    data.putIfAbsent('work_type', () => log.workType.value);
    data.putIfAbsent('plan_code', () => log.planCode);
    data.putIfAbsent('menu_code', () => log.menuCode);
    data.putIfAbsent('menu_name_ja', () => log.menuNameJa);
    data.putIfAbsent('menu_name_en', () => log.menuNameEn);
    return data;
  }

  // Delete me after using firebase
  static WorkLog createNewLog(
      String userId,
      String planCode,
      String menuCode,
      String menuNameJa,
      String menuNameEn,
      List<WorkoutSet> workoutSets,
      Timestamp date,
      WorkType workType) {
    List<Map<String, num>> logs = new List();
    workoutSets.forEach((data) {
      logs.add({
        "reps": data.reps.toDouble(),
        "weight": data.weight.toDouble(),
        "unit": data.weightUnit.toDouble()
      });
    });
    return new WorkLog(
      userId: userId,
      planCode: planCode,
      menuCode: menuCode,
      menuNameJa: menuNameJa,
      menuNameEn: menuNameEn,
      logs: logs,
      date: date,
      workType: workType,
    );
  }
}
