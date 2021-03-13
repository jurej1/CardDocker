import 'package:card_docker/blocs/blocs.dart';
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
                          onPressed: () => BlocProvider.of<TransactionDataBarChartBloc>(context).add(TransactionBarChartChangeView(e)),
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
                            x: 1,
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
                          getTitles: (value) {
                            if (value < 5) {
                              return 'helo';
                            } else {
                              return 'dope';
                            }
                          },
                          showTitles: true,
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
}
