import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:card_docker/repositories/transactions_repository/transactions_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TransactionPurposeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionFormBloc, AddTransactionFormState>(
      builder: (context, state) {
        return InputCard(
          onTap: () {
            showBottomSheet(context);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Purpose',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(transactionPurposeToString(state.purpose)),
            ],
          ),
        );
      },
    );
  }

  Future<void> showBottomSheet(BuildContext context) async {
    TransactionPurpose purpose = await showModalBottomSheet<TransactionPurpose>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSheetGround(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            physics: const BouncingScrollPhysics(),
            itemCount: TransactionPurpose.values.length,
            itemBuilder: (context, index) {
              final purpose = TransactionPurpose.values[index];

              return ListTile(
                contentPadding: EdgeInsets.zero,
                onTap: () => Navigator.of(context).pop(purpose),
                title: Text(transactionPurposeToString(purpose)),
              );
            },
          ),
        );
      },
    );

    if (purpose != null) {
      BlocProvider.of<AddTransactionFormBloc>(context).add(TransactionPurposeChanged(purpose));
    }
  }
}