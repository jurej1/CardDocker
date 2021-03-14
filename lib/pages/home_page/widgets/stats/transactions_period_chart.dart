import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/repositories/transactions_repository/src/models/models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class TransactionPeriodChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionDataBarChartBloc, TransactionDataBarChartState>(
      builder: (context, state) {
        if (state is TransactionDataBarChartLoadSuccess) {
          return Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: Colors.blue.withOpacity(0.3),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _ViewSelector(
                  selectedView: state.view,
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  child: BarChart(
                    BarChartData(
                      alignment: BarChartAlignment.spaceAround,
                      barTouchData: BarTouchData(
                        enabled: true,
                        touchTooltipData: BarTouchTooltipData(
                          tooltipBgColor: Colors.transparent,
                          tooltipPadding: const EdgeInsets.all(0),
                          tooltipBottomMargin: 3,
                          getTooltipItem: (
                            BarChartGroupData group,
                            int groupIndex,
                            BarChartRodData rod,
                            int rodIndex,
                          ) {
                            final isNotNull = rod.y.round() != 0;

                            return BarTooltipItem(
                              isNotNull ? rod.y.round().toString() : '',
                              TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      maxY: state.getMaxY,
                      barGroups: state.transactions.map(
                        (e) {
                          return BarChartGroupData(
                            x: _xValue(state.view, e),
                            barRods: [
                              BarChartRodData(
                                y: e.count.toDouble(),
                              ),
                            ],
                            showingTooltipIndicators: [0],
                          );
                        },
                      ).toList(),
                      titlesData: FlTitlesData(
                        leftTitles: SideTitles(),
                        bottomTitles: SideTitles(
                          getTitles: (value) => _getTile(view: state.view, value: value),
                          showTitles: true,
                          rotateAngle: 35,
                        ),
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

  double _horizonalInterval(View view) {
    if (view == View.day) {
      return 2;
    } else if (view == View.month) {
      return 10;
    } else {
      return 5;
    }
  }

  int _xValue(View selectedView, PeriodTransactionData e) {
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
    final currentDate = DateTime.now();
    if (view == View.day) {
      return DateFormat('EEE').format(DateTime(currentDate.year, currentDate.month, val));
    } else if (view == View.month) {
      return DateFormat('MMM').format(DateTime(currentDate.year, val));
    } else if (view == View.week) {
      return '$val';
    } else {
      return '';
    }
  }
}

class _ViewSelector extends StatelessWidget {
  final View selectedView;

  const _ViewSelector({Key? key, required this.selectedView}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: View.values.map(
        (e) {
          final bool isSelected = selectedView == e;

          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Transform.translate(
                offset: isSelected ? Offset(0, -4) : Offset.zero,
                child: Transform.scale(
                  scale: 0.85,
                  child: TextButton(
                    style: ButtonStyle(
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      animationDuration: const Duration(milliseconds: 350),
                      elevation: MaterialStateProperty.all<double>(isSelected ? 5 : 2.5),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(
                        isSelected ? Colors.blue : Colors.white,
                      ),
                    ),
                    onPressed: () => BlocProvider.of<TransactionDataBarChartBloc>(context).add(TransactionBarChartChangeView(e)),
                    child: Text(
                      describeEnum(e),
                      style: TextStyle(
                        color: isSelected ? Colors.white : Colors.blue,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ).toList(),
    );
  }
}
