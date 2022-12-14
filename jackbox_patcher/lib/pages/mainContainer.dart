import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:jackbox_patcher/components/menu.dart';
import 'package:jackbox_patcher/components/pack.dart';
import 'package:jackbox_patcher/model/jackboxpack.dart';
import 'package:jackbox_patcher/services/api/api_service.dart';
import 'package:jackbox_patcher/services/user/userdata.dart';

class MainContainer extends StatefulWidget {
  MainContainer({Key? key}) : super(key: key);

  @override
  State<MainContainer> createState() => _MainContainerState();
}

class _MainContainerState extends State<MainContainer> {
  int _selectedView = 0;
  bool _loaded = false;

  @override
  void initState() {
    _load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return NavigationView(
      appBar: NavigationAppBar(
          automaticallyImplyLeading: false, title: Text("Jackbox Patcher")),
      pane: NavigationPane(
        onChanged: (int nSelected) {
          setState(() {
            _selectedView = nSelected;
          });
        },
        selected: _selectedView,
        items: _buildPaneItems(),
      ),
    );
  }

  _buildPaneItems() {
    List<NavigationPaneItem> items = [
      PaneItem(
          icon: Icon(FluentIcons.home),
          title: Text("Menu"),
          body: Center(
            child: _loaded ? MenuWidget() : Text("Chargement..."),
          )),
    ];
    if (UserData().packs.isNotEmpty) {
      items.add(PaneItemHeader(
        header: Text("Packs"),
      ));
    }
    for (var userPack in UserData().packs) {
      items.add(PaneItem(
          icon: Image.network(APIService().assetLink(userPack.pack.icon)),
          title: Text(userPack.pack.name),
          body: PackWidget(userPack: userPack)));
    }
    return items;
  }

  void _load() async {
    await _loadWelcome();
    await _loadPacks();
    setState(() {
      _loaded = true;
    });
  }

  Future<void> _loadWelcome() async {
    await UserData().syncWelcomeMessage();
  }

  Future<void> _loadPacks() async {
    await UserData().syncPacks();
  }
}
