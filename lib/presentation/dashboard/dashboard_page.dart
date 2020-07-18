import 'package:cold_app/presentation/common/translations.i18n.dart';
import 'package:cold_app/presentation/common/constants.dart';
import 'package:cold_app/presentation/dashboard/components/chart_vertical.dart';
import 'package:cold_app/presentation/dashboard/components/label.dart';
import 'package:cold_app/presentation/dashboard/components/neumorphic_pie/neumorphic_pie.dart';
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
                      <ChartLineData>[
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
                      title: 'Week'.i18n,
                    ),
                    Container(
                      height: 200,
                      child: Stack(
                        // fit: StackFit.expand,
                        // overflow: ,
                        children: <Widget>[
                          Positioned(
                            top: 70,
                            left: 15,
                            child: NeumorphicPie(
                              size: 110,
                              color: Constants.accent2,
                              totalValue: 42,
                              currentValue: 24,
                            ),
                          ),
                          Positioned(
                            top: 70,
                            right: 35,
                            child: NeumorphicPie(
                              size: 90,
                              color: Constants.accent3,
                              totalValue: 6,
                              currentValue: 3,
                            ),
                          ),
                          Container(
                            alignment: Alignment.topCenter,
                            child: NeumorphicPie(
                              size: 140,
                              color: Constants.accent,
                              totalValue: 120,
                              currentValue: 67,
                            ),
                          ),
                        ],
                      ),
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
