import 'package:cold_app/core/app_localizations.dart';
import 'package:cold_app/presentation/dashboard/components/chart_vertical.dart';
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
              child: ChartVertical(<ChartLineData>[
                ChartLineData(
                  dayOfWeek: AppLocalizations.of(context).translate('day_sunday'),
                  title: 0.toString(),
                  value: 0,
                ),
                ChartLineData(
                  dayOfWeek: AppLocalizations.of(context).translate('day_monday'),
                  title: 2.toString(),
                  value: 2,
                ),
                ChartLineData(
                  dayOfWeek: AppLocalizations.of(context).translate('day_tuesday'),
                  title: 3.toString(),
                  value: 3,
                  isCurrent: true,
                ),
                ChartLineData(
                  dayOfWeek: AppLocalizations.of(context).translate('day_wednesday'),
                  title: 4.toString(),
                  value: 4,
                ),
                ChartLineData(
                  dayOfWeek: AppLocalizations.of(context).translate('day_thursday'),
                  title: 5.toString(),
                  value: 5,
                ),
                ChartLineData(
                  dayOfWeek: AppLocalizations.of(context).translate('day_friday'),
                  title: 6.toString(),
                  value: 6,
                ),
                ChartLineData(
                  dayOfWeek: AppLocalizations.of(context).translate('day_saturday'),
                  title: 7.toString(),
                  value: 7,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}
