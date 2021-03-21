import 'package:card_docker/blocs/add_credict_card_form/add_credict_card_form_bloc.dart';
import 'package:card_docker/functions/credict_card_type_name.dart';
import 'package:card_docker/pages/add_credict_card/widgets/bottom_sheet_ground.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

            BlocProvider.of<AddCredictCardFormBloc>(context).add(CredictCardTypeChanged(type!));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Type'),
              Text(
                credictCardTypeName(state.type),
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
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

  Widget _typeSelectorBottomSheet(CredictCardType currentType) {
    return BottomSheetGround(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        physics: const BouncingScrollPhysics(),
        itemCount: CredictCardType.values.length,
        itemBuilder: (context, index) {
          final type = CredictCardType.values[index];
          return ListTile(
            title: Text(credictCardTypeName(type)),
            selected: type == currentType,
            leading: FaIcon(credictCardTypeToIconData(type)),
            onTap: () => Navigator.of(context).pop(type),
          );
        },
      ),
    );
  }
}
