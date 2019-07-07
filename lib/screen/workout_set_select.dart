import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:workoutholic/dto/workout_set.dart';
import 'package:workoutholic/screen/workout_menu_select.dart';
import 'package:workoutholic/dto/work_set.dart';
import 'package:workoutholic/dao/work_set_dao.dart';
import 'package:workoutholic/screen/add_set.dart';
import 'package:workoutholic/const/list_for_set_select.dart';

class WorkoutSetSelectPage extends StatelessWidget {
  @override
  // final DateTime selectedDate;
  // WorkoutSetSelect({Key key, @required this.selectedDate}) : super(key: key);

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("セットを選択"),
        actions: <Widget>[
          FlatButton(
              child: Text('Add',
                  style: TextStyle(fontSize: 17.0, color: Colors.white)),
              onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddSetPage(),
                    ),
                  ))
        ],
      ),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return _buildList2(context);
  }

  Widget _buildList2(BuildContext context) {
    List<ListItem> items = List<ListItem>.generate(
        1000, (i) => i % 6 == 0 ? SetItem("Set $i") : MenuItem("Menu $i"));

    return ListView.builder(
      // Let the ListView know how many items it needs to build.
      itemCount: items.length,
      // Provide a builder function. This is where the magic happens.
      // Convert each item into a widget based on the type of item it is.
      itemBuilder: (context, index) {
        final item = items[index];

        if (item is SetItem) {
          return ListTile(
            title: Text(
              item.setName,
              style: Theme.of(context).textTheme.headline,
            ),
          );
        } else if (item is MenuItem) {
          return ListTile(
            title: Text(item.menuName),
          );
        }
      },
    );
  }

  Widget _buildList(BuildContext context) {
    List<WorkSet> workSets = generateMockData();
    return ListView.separated(
        separatorBuilder: (context, index) => Divider(
              color: Colors.black38,
            ),
        padding: const EdgeInsets.all(16.0),
        itemCount: workSets.length,
        itemBuilder: (context, int index) {
          return ListTile(
            title: Text(
              workSets[index].nameJa,
              style: const TextStyle(fontSize: 18.0),
            ),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      WorkoutMenuSelect(workSet: workSets[index])),
            ),
          );
        });
  }

  // Firebaseに置き換える予定なので隔離してる
  List<WorkSet> generateMockData() {
    return WorkSetDao.genarateMockData();
  }

// firebase使うなら以下のソース
  // Widget _buildBody(BuildContext context) {
  //   return StreamBuilder<QuerySnapshot>(
  //     stream: Firestore.instance.collection('workoutSet').snapshots(),
  //     builder: (context, snapshot) {
  //       if (!snapshot.hasData) return LinearProgressIndicator();
  //       return _buildList(context, snapshot.data.documents);
  //     },
  //   );
  // }

  // Widget _buildList(BuildContext context, List<DocumentSnapshot> snapshot) {
  //   return ListView(
  //     padding: const EdgeInsets.only(top: 20.0),
  //     children: snapshot.map((data) => _buildListItem(context, data)).toList(),
  //   );
  // }
  // Widget _buildListItem(BuildContext context, DocumentSnapshot data) {
  //   final workoutSet = WorkoutSet.fromSnapshot(data);
  //   return Padding(
  //     key: ValueKey(workoutSet.setName),
  //     padding: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 1),
  //     child: Container(
  //       decoration: BoxDecoration(
  //         border: Border.all(color: Colors.grey),
  //         borderRadius: BorderRadius.circular(5.0),
  //       ),
  //       child: ListTile(
  //         title: Text(workoutSet.setName),
  //         // trailing: Text(record.votes.toString()),
  //         onTap: () => Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                   builder: (context) =>
  //                       WorkoutMenuSelect(workoutSet: workoutSet)),
  //             ),
  //       ),
  //     ),
  //   );
  // }
}
