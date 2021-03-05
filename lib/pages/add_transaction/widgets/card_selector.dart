import 'package:card_docker/blocs/blocs.dart';
import 'package:card_docker/pages/add_credict_card/widgets/widgets.dart';
import 'package:card_docker/pages/add_transaction/bloc/credict_card_tile_bloc.dart';
import 'package:card_docker/pages/add_transaction/widgets/credict_card_tile.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/models.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CardSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddTransactionFormBloc, AddTransactionFormState>(
      builder: (context, state) {
        return InputCard(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Card',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(state.card.value),
                ],
              ),
              if (state.card.invalid) ...{
                Text('This field is required'),
              }
            ],
          ),
          onTap: () async {
            final CredictCard? card = (await _bottomSheet(context))!;
            if (card != null) BlocProvider.of<AddTransactionFormBloc>(context).add(TransactionCardChanged(card));
          },
        );
      },
    );
  }

  Future<CredictCard?> _bottomSheet(BuildContext context) async {
    return showModalBottomSheet<CredictCard>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return BottomSheetGround(
          // child: BlocBuilder<CardsBloc, CardsState>(
          //   builder: (context, state) {
          //     if (state is CardsLoading) {
          //       return Center(
          //         child: CircularProgressIndicator(),
          //       );
          //     }
          //     return _cardsList((state as CardsLoadSuccess).cards);
          //   },
          // ),
          child: _cardsList([
            CredictCard(
              note: 'MY card',
              ownerId: '68460480ds49fs',
              balance: 50,
              color: Colors.red,
              company: CredictCardCompany.americanExspress,
              created: Timestamp.now(),
              id: 'USFHOIGJDSKV',
              type: CredictCardType.business,
            ),
            CredictCard(
              note: 'MY card2',
              ownerId: 'sgpodfsdg875dfg8f4x',
              balance: 150,
              color: Colors.blue,
              company: CredictCardCompany.bankOfAmerica,
              created: Timestamp.now(),
              id: 'PAJPFODDF',
              type: CredictCardType.debit,
            ),
            CredictCard(
              note: 'MY bakn card',
              ownerId: 'PAPOKPFD*AFA*',
              balance: 10000,
              color: Colors.green,
              company: CredictCardCompany.citibank,
              created: Timestamp.now(),
              id: 'USFHOIGJDSKV',
              type: CredictCardType.business,
            ),
          ]),
        );
      },
    );
  }

  Widget _cardsList(List<CredictCard> cards) {
    if (cards.isEmpty) {
      return Center(
        child: Text('First you need to add a credict card.'),
      );
    }
    return ListView.separated(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      itemCount: cards.length,
      itemBuilder: (context, index) {
        return BlocProvider(
          create: (context) => CredictCardTileBloc(),
          child: CredictCardTile(card: cards[index]),
        );
      },
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 8,
        );
      },
    );
  }
}
