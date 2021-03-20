import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SelectedCardIndicator extends StatefulWidget {
  @override
  _SelectedCardIndicatorState createState() => _SelectedCardIndicatorState();
}

class _SelectedCardIndicatorState extends State<SelectedCardIndicator> {
  late final ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarouselBloc, CarouselState>(
      builder: (context, state) {
        if (state is CarouselLoadSuccess && state.cards!.length > 0) {
          final Size size = MediaQuery.of(context).size;
          final width = size.width;

          return Container(
            height: 15,
            width: width,
            alignment: Alignment.center,
            child: ListView.separated(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              controller: _scrollController,
              separatorBuilder: (context, index) => const SizedBox(width: 10),
              scrollDirection: Axis.horizontal,
              itemCount: state.cards?.length ?? 0,
              itemBuilder: (context, index) {
                final bool isSelected = state.index == index;
                double radius = isSelected ? 13 : 7;
                Color color = (isSelected ? Theme.of(context).primaryColor : Colors.grey[300])!;

                return AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  height: radius,
                  width: radius,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                );
              },
            ),
          );
        }

        return Container();
      },
    );
  }
}
