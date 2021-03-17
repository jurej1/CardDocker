import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TierStatusOutput extends StatelessWidget {
  final _containerHeight = 80.00;
  late final _barHeight;
  late final _barWidth;

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    _barHeight = _containerHeight * 0.25;
    _barWidth = MediaQuery.of(context).size.width - 40; // - 40 == padding from the lisView

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
          final nextDiffAmount = state.nextTier.amount;
          final xAmount = ((state.transactionsAmount * 100) / nextDiffAmount);
          final xPercent = xAmount / 100;

          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            height: _containerHeight,
            width: screenWidth,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _TextRow(
                  beginText: state.currentTier.title,
                  endText: state.nextTier.title,
                ),
                SizedBox(
                  height: _barHeight,
                  width: screenWidth,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      height: _barHeight,
                      width: _barWidth,
                      color: Colors.grey[500],
                      child: FractionallySizedBox(
                        alignment: Alignment.centerLeft,
                        widthFactor: xPercent,
                        heightFactor: 1,
                        child: ColoredBox(
                          color: Colors.green,
                        ),
                      ),
                    ),
                  ),
                ),
                _TextRow(
                  beginText: state.currentTier.amount.toString(),
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
