import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final String title;
  final AppBar appBar;
  final List<Widget> widgets;
  final bool hasBackButton;

  const BaseAppBar(this.title,
      {Key key, @required this.appBar, this.widgets, this.hasBackButton: false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      leading: hasBackButton
          ? Center(
              child: FaIcon(
                FontAwesomeIcons.chevronLeft,
                color: Constants.mainTextColor,
                size: 32,
              ),
            )
          : null,
      title: AppBarTitleText(title),
      backgroundColor: Constants.background,
      actions: widgets,
    );
  }

  @override
  Size get preferredSize => new Size.fromHeight(appBar.preferredSize.height);
}

class AppBarTitleText extends StatelessWidget {
  final String text;

  const AppBarTitleText(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Constants.textH1,
    );
  }
}
