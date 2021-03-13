import 'package:card_docker/blocs/blocs.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPeriodChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsPeriodChartBloc, TransactionsPeriodChartState>(
      builder: (context, state) {
        if (state is TransactionChartLoadSuccess) {
          return Container(
            height: 150,
            child: BarChart(
              BarChartData(
                borderData: FlBorderData(show: false),
                barGroups: state.transactions.map((e) {
                  return BarChartGroupData(
                    x: e.count,
                    barRods: [
                      BarChartRodData(
                        y: e.count.toDouble(),
                      ),
                    ],
                  );
                }).toList(),
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
