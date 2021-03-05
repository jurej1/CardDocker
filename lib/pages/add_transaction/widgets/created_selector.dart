import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/add_credict_card/widgets/input_card.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class CreatedSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionFormBloc, AddTransactionFormState>(
      builder: (context, state) {
        return InputCard(
          onTap: () async {
            final created = await _showBottomSheet(context, state.created.value);

            if (created != null) {
              BlocProvider.of<AddTransactionFormBloc>(context).add(TransactionCreatedChanged(created));
            }
          },
          child: InputCardChild(
            title: 'Created',
            child: DateFormat('d MMMM yyyy').format(state.created.value),
          ),
        );
      },
    );
  }

  Future<DateTime?> _showBottomSheet(BuildContext context, DateTime initialDate) async {
    return showDatePicker(
      context: context,
      initialDate: initialDate,
      lastDate: DateTime.now(),
      firstDate: DateTime.now().subtract(
        const Duration(days: 365),
      ),
    );
  }
}
