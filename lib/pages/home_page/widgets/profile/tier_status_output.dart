import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/blocs.dart';

class TierStatusOutput extends StatelessWidget {
  final _containerHeight = 80.00;
  late final _barHeight;
  // late final _barWidth;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _barHeight = _containerHeight * 0.25;
    // _barWidth = MediaQuery.of(context).size.width - 40; // - 40 == padding from the lisView

    return BlocBuilder<TierStatusBloc, TierStatusState>(
      builder: (context, state) {
        if (state is TierStatusLoading) {
          return Container(
            height: _containerHeight,
            width: screenWidth,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is TierStatusLoadSuccess) {
          final totalDiff = state.nextTier.amount;
          final xAmount = ((state.transactionsAmount * 100) / totalDiff);
          final xPercent = xAmount / 100;

          return Container(
            height: _containerHeight,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TextRow(
                  beginText: state.currentTier.title,
                  endText: state.nextTier.title,
                ),
                _TierBar(
                  barHeight: _barHeight,
                  barWidth: screenWidth,
                  xPercent: xPercent,
                  transactionsAmount: state.transactionsAmount,
                ),
                _TextRow(
                  beginText: '1',
                  endText: state.nextTier.amount.toString(),
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

class _TierBar extends StatelessWidget {
  final double barHeight;
  final double barWidth;
  final double xPercent;
  final int transactionsAmount;

  const _TierBar({
    Key? key,
    required this.barHeight,
    required this.barWidth,
    required this.xPercent,
    required this.transactionsAmount,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: barHeight,
      width: barWidth,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: barHeight,
          width: barWidth,
          color: Colors.grey[400],
          child: FractionallySizedBox(
            alignment: Alignment.centerLeft,
            widthFactor: xPercent,
            heightFactor: 1,
            child: Container(
              color: Colors.green,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.only(right: 5),
              child: Text(
                transactionsAmount.toString(),
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _TextRow extends StatelessWidget {
  final String beginText;
  final String endText;

  const _TextRow({
    Key? key,
    required this.beginText,
    required this.endText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          beginText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          endText,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
