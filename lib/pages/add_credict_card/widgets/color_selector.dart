import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/constants/card_colors.dart';
import 'package:card_docker/pages/add_credict_card/widgets/bottom_sheet_ground.dart';
import 'package:card_docker/pages/add_credict_card/widgets/input_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ColorSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCredictCardFormBloc, AddCredictCardFormState>(
      builder: (contex, state) {
        return InputCard(
          color: state.color,
          onTap: () async {
            final color = await showModalBottomSheet<Color>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.black.withOpacity(0.6),
              builder: (_) => _colorSelectorBottomSheet(),
            );

            BlocProvider.of<AddCredictCardFormBloc>(contex).add(CredictCardColorChanged(color));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Credict card Color'),
              Text(
                CardColors.colorName(state.color),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _colorSelectorBottomSheet() {
    final colors = CardColors.colors;
    return BottomSheetGround(
      child: ListView.builder(
        itemCount: colors.length,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
              CardColors.colorName(colors[index]),
            ),
            onTap: () => Navigator.of(context).pop(colors[index]),
            trailing: Container(
              height: 30,
              width: 35,
              decoration: BoxDecoration(
                color: colors[index],
                border: Border.all(color: Colors.black45, width: 1),
                borderRadius: BorderRadius.circular(8)
              ),
            ),
          );
        },
      ),
    );
  }
}
