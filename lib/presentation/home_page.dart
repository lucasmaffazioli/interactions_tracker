import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/presentation/add_approach_page/add_approach_page.dart';
import 'package:cold_app/presentation/approaches_page/approaches_page.dart';
import 'package:cold_app/presentation/common/base_app_bar.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/settings_page/settings_page.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        AppLocalizations.of(context).translate('approaches'),
        actions: <Widget>[
          IconButton(
            icon: const FaIcon(
              FontAwesomeIcons.cog,
              color: Constants.mainTextColor,
            ),
            tooltip: 'Show settings',
            onPressed: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (context) => SettingsPage()));
            },
          ),
        ],
        appBar: AppBar(),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        // shape: CircleBorder(
        //   side: BorderSide(
        //     width: 4,
        //     color: Colors.white,
        //     style: BorderStyle.solid,
        //   ),
        // ),
        onPressed: (() async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddApproachPage()),
          ).then((value) {
            setState(() {});
          });
        }),
        child: FaIcon(FontAwesomeIcons.plus),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: IndexedStack(
        children: <Widget>[
          Text(
            'Index 1: Business',
            style: optionStyle,
          ),
          ApproachesPage(),
        ],
        index: _selectedIndex,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.black.withAlpha(28), blurRadius: 20)]),
        child: BottomNavigationBar(
          elevation: 50,
          selectedItemColor: Constants.accent,
          unselectedItemColor: Constants.accentDisabled,
          items: [
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.chartPie,
                // color: Constants.accent,
              ),
              title: Text(
                AppLocalizations.of(context).translate('dashboard'),
              ),
            ),
            BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.list,
              ),
              activeIcon: FaIcon(
                FontAwesomeIcons.list,
              ),
              title: Text(
                AppLocalizations.of(context).translate('approaches'),
              ),
            ),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
