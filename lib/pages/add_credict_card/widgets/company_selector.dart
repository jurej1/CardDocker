import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/functions/credict_card_company_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCredictCardFormBloc, AddCredictCardFormState>(
      builder: (context, state) {
        return Card(
          margin: EdgeInsets.zero,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Company:'),
                Text(credictCardCompanyName(state.company)),
              ],
            ),
          ),
        );
      },
    );
  }
}
