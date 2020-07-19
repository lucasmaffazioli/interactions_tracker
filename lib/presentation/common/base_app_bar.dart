import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'constants.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Color backgroundColor = Colors.red;
  final String title;
  final AppBar appBar;
  final List<Widget> actions;
  final bool hasBackButton;
  final Function backButtonCustomTap;

  const BaseAppBar(
    this.title, {
    Key key,
    @required this.appBar,
    this.actions,
    this.hasBackButton: false,
    this.backButtonCustomTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      centerTitle: true,
      leading: hasBackButton
          ? InkWell(
              // borderRadius: BorderRadius.circular(50),
              onTap: backButtonCustomTap == null
                  ? () => Navigator.maybePop(context)
                  : backButtonCustomTap,
              child: Center(
                child: FaIcon(
                  FontAwesomeIcons.chevronLeft,
                  color: Constants.mainTextColor,
                  // color: Colors.white,
                  size: 24,
                ),
              ),
            )
          : null,

      title: AppBarTitleText(title),
      // backgroundColor: Constants.accent2,
      backgroundColor: Constants.background,
      actions: actions,
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
      // style: Constants.textWhite,
    );
  }
}
