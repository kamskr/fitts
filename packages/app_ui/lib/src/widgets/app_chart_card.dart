import 'dart:math';

import 'package:app_ui/app_ui.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

/// {@template app_chart_card}
/// Widget responsible for displaying charts used by the app.
///
/// The widget uses FlChart for displaying charts.
/// {@endtemplate}
class AppChartCard extends StatelessWidget {
  /// {@macro app_chart_card}
  const AppChartCard({
    Key? key,
    required this.values,
    this.emptyText,
    this.labels,
    this.header,
    this.footer,
  })  : assert(
          values.length == 6,
          'The number of values must be 6.',
        ),
        assert(
          labels == null || labels.length == 6,
          'Labels must be null or have length of 6',
        ),
        super(key: key);

  /// Widget displayed above the chart. (Optional)
  final Widget? header;

  /// Text displayed when there are no values to display. (Optional)s
  final String? emptyText;

  /// Widget displayed below the chart. (Optional)
  final Widget? footer;

  /// Values to be displayed in the chart.
  /// Position in list corresponds to position in chart.
  final List<double> values;

  /// Labels to be displayed in the chart.
  /// Position in list corresponds to position in chart.
  ///
  /// Don't pass any labels if you don't want to display them.
  final List<String>? labels;

  @override
  Widget build(BuildContext context) {
    final maxValue = values.reduce(max) / 1000;
    final midValue = maxValue / 2;

    /// Compose tiles seen on the left of the chart.
    Widget leftTitles(double value, TitleMeta meta) {
      String text;
      if (value == 0) {
        text = '0';
      } else if (value == midValue) {
        final midValue = maxValue / 2;
        text = '${midValue.floor()}k';
      } else if (value == maxValue) {
        text = '${maxValue.floor()}k';
      } else {
        return Container();
      }

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 0,
        child: Text(
          text,
          style: Theme.of(context).textTheme.overline!.copyWith(
                color: AppColors.white.withOpacity(.8),
              ),
        ),
      );
    }

    /// Compose bottom tiles.
    Widget bottomTitles(double value, TitleMeta meta) {
      if (labels == null) {
        return const SizedBox.shrink();
      }

      final Widget text = Text(
        labels![value.toInt()],
        style: Theme.of(context).textTheme.overline!.copyWith(
              color: AppColors.white.withOpacity(.8),
            ),
      );

      return SideTitleWidget(
        axisSide: meta.axisSide,
        space: 16, //margin top
        child: text,
      );
    }

    /// Compose group data.m
    BarChartGroupData makeGroupData(int x, double y) {
      return BarChartGroupData(
        barsSpace: 5,
        x: x,
        barRods: [
          BarChartRodData(
            toY: y / 1000,
            color: x.isEven ? AppColors.primary[100] : AppColors.primary[400],
            width: 25,
            borderRadius: BorderRadius.zero,
          ),
        ],
      );
    }

    final barGroup1 = makeGroupData(0, values[0]);
    final barGroup2 = makeGroupData(1, values[1]);
    final barGroup3 = makeGroupData(2, values[2]);
    final barGroup4 = makeGroupData(3, values[3]);
    final barGroup5 = makeGroupData(4, values[4]);
    final barGroup6 = makeGroupData(5, values[5]);

    final showingBarGroups = [
      barGroup1,
      barGroup2,
      barGroup3,
      barGroup4,
      barGroup5,
      barGroup6,
    ];

    return Card(
      margin: EdgeInsets.zero,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned(
            top: 0,
            right: 0,
            bottom: 0,
            left: 0,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff23253A),
                    Color.fromARGB(255, 64, 71, 147),
                  ],
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                if (header != null) header!,
                const SizedBox(
                  height: 38,
                ),
                if (emptyText != null)
                  Expanded(
                    child: SizedBox(
                      height: double.infinity,
                      child: Center(
                        child: Text(
                          emptyText!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    color: AppColors.white.withOpacity(.8),
                                  ),
                        ),
                      ),
                    ),
                  )
                else
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: maxValue,
                        titlesData: FlTitlesData(
                          show: true,
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          bottomTitles: labels != null
                              ? AxisTitles(
                                  sideTitles: SideTitles(
                                    showTitles: true,
                                    getTitlesWidget: bottomTitles,
                                    reservedSize: 42,
                                  ),
                                )
                              : AxisTitles(
                                  sideTitles: SideTitles(showTitles: false),
                                ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 28,
                              interval: 1,
                              getTitlesWidget: leftTitles,
                            ),
                          ),
                        ),
                        borderData: FlBorderData(
                          show: false,
                        ),
                        barGroups: showingBarGroups,
                        gridData: FlGridData(show: false),
                      ),
                    ),
                  ),
                if (footer != null) footer!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}
