import 'package:card_docker/blocs/add_credict_card_form/add_credict_card_form_bloc.dart';
import 'package:card_docker/pages/add_credict_card/widgets/bottom_sheet_ground.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TypeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCredictCardFormBloc, AddCredictCardFormState>(
      builder: (context, state) {
        return InputCard(
          onTap: () async {
            final type = await showModalBottomSheet<CredictCardType>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.black.withOpacity(0.6),
              builder: (_) => _typeSelectorBottomSheet(state.type),
            );

            BlocProvider.of<AddCredictCardFormBloc>(context).add(CredictCardTypeChanged(type));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Type:'),
              Text('Type'),
            ],
          ),
        );
      },
    );
  }

  Widget _typeSelectorBottomSheet(CredictCardType currentType) {
    return BottomSheetGround(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: CredictCardType.values.length,
        itemBuilder: (context, index) {
          final type = CredictCardType.values[index];
          return ListTile(
            selected: type == currentType,
            onTap: () => Navigator.of(context).pop(type),
          );
        },
      ),
    );
  }
}