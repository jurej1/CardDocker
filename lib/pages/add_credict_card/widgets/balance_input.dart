import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_docker/blocs/blocs.dart';

class AmountInput extends StatelessWidget {
  final FocusNode focusNode;

  const AmountInput({Key key, @required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCredictCardFormBloc, AddCredictCardFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.balance.value,
          focusNode: focusNode,
          keyboardType: TextInputType.number,
          autocorrect: false,
          onChanged: (value) => BlocProvider.of<AddCredictCardFormBloc>(context).add(CredictCardAmountChanged(value)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Amount',
            helperText: 'The initial value. Exp \$100',
            errorText: state.balance.invalid ? 'Amount must be specified.' : null,
          ),
        );
      },
    );
  }
}
