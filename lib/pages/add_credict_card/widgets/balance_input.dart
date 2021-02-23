import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:card_docker/blocs/blocs.dart';

class BalanceInput extends StatelessWidget {
  final FocusNode focusNode;

  const BalanceInput({Key key, @required this.focusNode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCredictCardFormBloc, AddCredictCardFormState>(
      builder: (context, state) {
        return TextFormField(
          initialValue: state.balance.value,
          focusNode: focusNode,
          autocorrect: false,
          onChanged: (value) => BlocProvider.of<AddCredictCardFormBloc>(context).add(CredictCardBalanceChanged(value)),
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Balnace',
            helperText: 'The initial value. Exp \$100',
            errorText: state.balance.invalid ? 'Balance must be specified.' : null,
          ),
        );
      },
    );
  }
}
