import 'package:card_docker/blocs/blocs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/add_transaction_form/add_transaction_form_bloc.dart';

class AmountInput extends StatelessWidget {
  final FocusNode focusNode;

  const AmountInput({Key key, @required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionFormBloc, AddTransactionFormState>(
      builder: (context, state) {
        return TextFormField(
          autocorrect: false,
          focusNode: focusNode,
          initialValue: state.amount.value,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Amount',
            errorText: state.amount.invalid ? 'This field is required' : null,
            border: const OutlineInputBorder(),
          ),
          onChanged: (val) => BlocProvider.of<AddCredictCardFormBloc>(context).add(CredictCardAmountChanged(val)),
        );
      },
    );
  }
}
