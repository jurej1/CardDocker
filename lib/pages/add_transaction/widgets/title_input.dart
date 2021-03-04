import 'package:card_docker/models/models.dart' as model;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/blocs/add_transaction_form/add_transaction_form_bloc.dart';

class TitleInput extends StatelessWidget {
  final FocusNode focusNode;

  const TitleInput({Key? key, required this.focusNode}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionFormBloc, AddTransactionFormState>(
      builder: (context, state) {
        return TextFormField(
          keyboardType: TextInputType.text,
          autocorrect: false,
          focusNode: focusNode,
          initialValue: state.title.value,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: 'Transaction title',
            errorText: _errorText(state.title),
          ),
          onChanged: (value) => BlocProvider.of<AddTransactionFormBloc>(context).add(TransactionTitleChanged(value)),
        );
      },
    );
  }

  String? _errorText(model.Title title) {
    if (title.invalid) {
      final error = title.error;
      if (error == model.TitleValidationError.must) {
        return 'This field is required';
      } else if (error == model.TitleValidationError.invalid) {
        return 'Max 100 characters';
      } else {
        return null;
      }
    }
    return null;
  }
}
