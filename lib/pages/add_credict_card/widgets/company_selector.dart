import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/functions/credict_card_company_name.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CompanySelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCredictCardFormBloc, AddCredictCardFormState>(
      builder: (context, state) {
        return InputCard(
          onTap: () async {
            final company = await showModalBottomSheet<CredictCardCompany>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              barrierColor: Colors.black.withOpacity(0.6),
              builder: (_) => _companiesBottomSheet(context, state.company),
            );

            BlocProvider.of<AddCredictCardFormBloc>(context).add(CredictCardCompanyChanged(company!));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Company'),
              Text(
                credictCardCompanyName(state.company),
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

  Widget _companiesBottomSheet(BuildContext context, CredictCardCompany selectedCompany) {
    return BottomSheetGround(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemCount: CredictCardCompany.values.length,
        itemBuilder: (context, index) {
          final company = CredictCardCompany.values[index];

          return ListTile(
            selected: company == selectedCompany,
            title: Text(credictCardCompanyName(company)),
            onTap: () => Navigator.of(context).pop(company),
          );
        },
      ),
    );
  }
}
