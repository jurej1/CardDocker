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
                _ViewSelector(
                  selectedView: state.view,
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  height: 180,
                  alignment: Alignment.centerLeft,
                  child: BarChart(
                    BarChartData(
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
                          );
                        },
                      ).toList(),
                      titlesData: FlTitlesData(
                        show: true,
                        leftTitles: SideTitles(
                          interval: 5,
                          showTitles: true,
                        ),
                        bottomTitles: SideTitles(
                          getTitles: (value) => _getTile(view: state.view, value: value),
                          showTitles: true,
                          rotateAngle: 35,
                        ),
                      ),
                      gridData: FlGridData(
                        horizontalInterval: _horizonalInterval(state.view),
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
          );
        },
      ).toList(),
    );
  }
}
