import 'package:card_docker/blocs/blocs.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPeriodChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionDataBarChartBloc, TransactionDataBarChartState>(
      builder: (context, state) {
        if (state is TransactionDataBarChartLoadSuccess) {
          return Container(
            height: 150,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                barGroups: state.transactions.reversed.map((e) {
                  return BarChartGroupData(
                    x: e.weekNumber(),
                    barRods: [
                      BarChartRodData(
                        y: e.count.toDouble(),
                      ),
                    ],
                  );
                }).toList(),
                axisTitleData: FlAxisTitleData(
                  bottomTitle: AxisTitle(
                    titleText: 'Week',
                    showTitle: true,
                  ),
                  leftTitle: AxisTitle(
                    titleText: 'Quantity',
                    showTitle: true,
                  ),
                ),
              ),
            ),
          );
        } else {
          return Container();
        }
      },
    );
  }
}
