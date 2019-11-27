import 'package:flutter/material.dart';
import 'package:workoutholic/dto/user.dart';
import 'package:workoutholic/dto/work_menu.dart';
import 'package:workoutholic/dao/work_menu_dao.dart';
import 'package:workoutholic/dto/work_menu.dart';

class WorkPlanAddMenusPage extends StatefulWidget {
  final User user;
  final DateTime date;
  final List<WorkMenu> menus;

  @override
  WorkPlanAddMenusPage({@required this.user, @required this.date, this.menus});
  _WorkPlanAddMenusState createState() => _WorkPlanAddMenusState();
}

class _WorkPlanAddMenusState extends State<WorkPlanAddMenusPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(context),
        body: _buildBody(context));
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Text("追加するメニューを選択"),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return FutureBuilder(
        future: WorkMenuDao.getAllMenus(),
        builder: (context, snapshot) {
          return ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index) {
                final datas = snapshot.data.documents;
                WorkMenu menu = WorkMenu.of(datas[index]);
                return ListTile(title: Text(menu.nameJa));
              });
        });
    // ListTile(
    //     title: Text("完了", textAlign: TextAlign.center),
    //     onTap: () => Navigator.of(context).pop());
  }
}
