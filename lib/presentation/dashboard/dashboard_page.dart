import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/dashboard/components/chart_vertical.dart';
import 'package:cold_app/presentation/dashboard/components/label.dart';
import 'package:cold_app/presentation/dashboard/components/modern_pies.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Card(
              elevation: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: <Widget>[
                    ChartVertical(
                      title: 'Week'.i18n,
                      listData: <ChartLineData>[
                        ChartLineData(
                          dayOfWeek: 'Sunday'.i18n,
                          title: 0.toString(),
                          value: 0,
                        ),
                        ChartLineData(
                          dayOfWeek: 'Monday'.i18n,
                          title: 2.toString(),
                          value: 2,
                        ),
                        ChartLineData(
                          dayOfWeek: 'Tuesday'.i18n,
                          title: 3.toString(),
                          value: 3,
                          isCurrent: true,
                        ),
                        ChartLineData(
                          dayOfWeek: 'Wednesday'.i18n,
                          title: 4.toString(),
                          value: 4,
                        ),
                        ChartLineData(
                          dayOfWeek: 'Thursday'.i18n,
                          title: 5.toString(),
                          value: 5,
                        ),
                        ChartLineData(
                          dayOfWeek: 'Friday'.i18n,
                          title: 6.toString(),
                          value: 6,
                        ),
                        ChartLineData(
                          dayOfWeek: 'Saturday'.i18n,
                          title: 7.toString(),
                          value: 7,
                        ),
                      ],
                    ),
                    ModernPies(
                      centerPieValue: PieValue(totalValue: 120, currentValue: 65),
                      leftPieValue: PieValue(totalValue: 40, currentValue: 12),
                      rightPieValue: PieValue(totalValue: 5, currentValue: 4),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Label(
                          color: Constants.accent2,
                          text: 'Week'.i18n,
                        ),
                        Label(
                          color: Constants.accent,
                          text: 'Month'.i18n,
                        ),
                        Label(
                          color: Constants.accent3,
                          text: 'Day'.i18n,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  'Analysis'.i18n,
                  style: Constants.textH1,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
