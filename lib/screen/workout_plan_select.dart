import 'package:flutter/material.dart';
import 'package:workoutholic/screen/workout_menu_select.dart';
import 'package:workoutholic/dto/work_plan.dart';
import 'package:workoutholic/dto/work_menu.dart';
import 'package:workoutholic/dao/work_plan_dao.dart';
import 'package:workoutholic/screen/work_plan_create.dart';
import 'package:workoutholic/const/list_for_set_select.dart';
import 'package:workoutholic/dto/user.dart';
import 'package:workoutholic/widget/circular_load.dart';

class WorkoutPlanSelectPage extends StatelessWidget {
  final User user;
  final DateTime date;
  @override
  WorkoutPlanSelectPage({@required this.user, @required this.date});

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("トレーニングを選択"),
          actions: <Widget>[
            FlatButton(
                child: Text('編集',
                    style: TextStyle(fontSize: 17.0, color: Colors.white)),
                onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkPlanCreatePage(
                            user: this.user, date: this.date),
                      ),
                    ))
          ],
        ),
        body: StreamBuilder(
          stream: WorkPlanDao.getPlansStream(user.uid),
          builder: (context, snapshot) {
            return _buildList(context, snapshot);
          },
        ));
  }

  Widget _buildList(BuildContext context, AsyncSnapshot snapshot) {
    if (!snapshot.hasData) {
      return CircularLoad();
    }
    List<WorkPlan> workPlans = new List();
    snapshot.data.documents.forEach((plan) {
      workPlans.add(WorkPlan.of(plan));
    });
    return ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: workPlans.length + 1,
        itemBuilder: (context, int index) {
          if (index == workPlans.length) {
            return ListTile(
                title: Text("トレーニングプランを新規作成", textAlign: TextAlign.center),
                onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkPlanCreatePage(
                            user: this.user, date: this.date),
                      ),
                    ));
          }
          WorkPlan plan = workPlans[index];
          return ListTile(
            title: Text(
              plan.nameJa,
              style: Theme.of(context).textTheme.headline,
            ),
            subtitle: Text(_generateSubTitle(plan.menus)),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => WorkoutMenuSelect(
                      user: this.user, workPlan: plan, date: this.date)),
            ),
          );
        });
  }

  String _generateSubTitle(List<WorkMenu> menus) {
    return "hoge, piyo, fuwa";
  }
  // List<ListForSetSelect> displayList = new List();
  // workPlans.forEach((plan) {
  //   displayList?.add(plan);
  //   plan.menus.forEach((menu) {
  //     // menu.workPlan
  //     displayList.add(menu);
  //   });
  //   displayList.add(new Separator());
  // });
  // displayList.add(new AddNewSet());
  // return ListView.builder(
  //     padding: const EdgeInsets.all(16.0),
  //     itemCount: displayList.length,
  //     itemBuilder: (context, int index) {
  //       final item = displayList[index];
  //       if (item is WorkPlan) {
  // return ListTile(
  //   title: Text(
  //     item.nameJa,
  //     style: Theme.of(context).textTheme.headline,
  //   ),
  //   subtitle:
  //   onTap: () => Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //         builder: (context) => WorkoutMenuSelect(
  //             user: this.user, workPlan: item, date: this.date)),
  //   ),
  // );
  //       } else if (item is WorkMenu) {
  //         return ListTile(
  //             title: Text(item.nameJa),
  //             onTap: () => Navigator.push(
  //                   context,
  //                   MaterialPageRoute(
  //                       builder: (context) => WorkoutMenuSelect(
  //                           user: this.user,
  //                           workPlan: item.workPlan,
  //                           date: this.date)),
  //                 ));
  //       } else if (item is Separator) {
  //         return Divider(color: Colors.black38);
  //       } else {
  // return ListTile(
  //     title: Text("トレーニングプランを新規作成", textAlign: TextAlign.center),
  //     onTap: () => Navigator.push(
  //           context,
  //           MaterialPageRoute(
  //             builder: (context) => WorkPlanCreatePage(
  //                 user: this.user, date: this.date),
  //           ),
  //         ));
  //       }
  //     });

}
