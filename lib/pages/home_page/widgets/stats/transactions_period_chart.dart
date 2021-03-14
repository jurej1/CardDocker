import 'dart:math';

import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPeriodChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionDataBarChartBloc, TransactionDataBarChartState>(
      builder: (context, state) {
        if (state is TransactionDataBarChartLoadSuccess) {
          return Container(
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  color: Colors.redAccent.withOpacity(0.4),
                  child: Row(
                    children: View.values.map((e) {
                      return Expanded(
                        child: TextButton(
                          onPressed: () => BlocProvider.of<TransactionDataBarChartBloc>(context).add(
                            TransactionBarChartChangeView(e),
                          ),
                          child: Text(
                            describeEnum(e),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  color: Colors.green.withOpacity(0.4),
                  height: 150,
                  alignment: Alignment.centerLeft,
                  child: BarChart(
                    BarChartData(
                      borderData: FlBorderData(show: false),
                      barGroups: state.transactions.reversed.map(
                        (e) {
                          return BarChartGroupData(
                            x: _XValue(state.view, e),
                            barRods: [
                              BarChartRodData(
                                y: e.count.toDouble(),
                              ),
                            ],
                          );
                        },
                      ).toList(),
                      axisTitleData: FlAxisTitleData(
                        bottomTitle: AxisTitle(
                          showTitle: true,
                          titleText: 'Week',
                        ),
                      ),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: SideTitles(
                          interval: 5,
                          showTitles: true,
                        ),
                        bottomTitles: SideTitles(
                          getTitles: (value) => _getTile(view: state.view, value: value),
                          showTitles: true,
                          rotateAngle: pi / 4,
                        ),
                      ),
                      gridData: FlGridData(
                        checkToShowHorizontalLine: (value) => value % 2.5 == 0,
                        horizontalInterval: 2.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }

  int _XValue(View selectedView, PeriodTransactionData e) {
    if (selectedView == View.day) {
      return e.weekDayNumber();
    } else if (selectedView == View.month) {
      return e.monthNumber();
    } else {
      return e.weekNumber();
    }
  }

  String _getTile({required View view, required double value}) {
    final val = value.toInt();

    if (view == View.day) {
      switch (val) {
        case 1:
          return 'Mon';
        case 2:
          return 'Tue';

        case 3:
          return 'Wed';
        case 4:
          return 'Thu';
        case 5:
          return 'Fri';
        case 6:
          return 'Sat';
        case 7:
          return 'Sun';
        default:
          return '';
      }
    } else if (view == View.month) {
      switch (val) {
        case 1:
          return 'Jan';
        case 2:
          return 'Feb';
        case 3:
          return 'Mar';
        case 4:
          return 'Apr';
        case 5:
          return 'May';
        case 6:
          return 'Jun';
        case 7:
          return 'Jul';
        case 8:
          return 'Aug';
        case 9:
          return 'Sep';
        case 10:
          return 'Oct';
        case 11:
          return 'Nov';
        case 12:
          return 'Dec';
        default:
          return '';
      }
    } else if (view == View.week) {
      return 'WK $val';
    } else {
      return '';
    }
  }
}
