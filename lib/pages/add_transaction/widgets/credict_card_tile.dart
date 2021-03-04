import 'dart:math';

import 'package:card_docker/functions/credict_card_company_name.dart';
import 'package:card_docker/functions/credict_card_type_name.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:card_docker/pages/add_transaction/bloc/credict_card_tile_bloc.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/models/credict_card.dart';
import 'package:intl/intl.dart';

class CredictCardTile extends StatelessWidget {
  final CredictCard card;

  const CredictCardTile({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredictCardTileBloc, CredictCardTileState>(
      builder: (context, state) {
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          height: state.isExpanded ? 180 : 56,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black26,
                offset: Offset(2, 2),
              ),
            ],
          ),
          child: _Tile(card: card),
        );
      },
    );
  }
}

class _Tile extends StatelessWidget {
  final CredictCard card;

  const _Tile({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CredictCardTileBloc, CredictCardTileState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () => Navigator.of(context).pop(card),
              contentPadding: EdgeInsets.zero,
              title: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.35),
                child: Text(
                  card.note,
                  style: TextStyle(),
                  overflow: TextOverflow.fade,
                ),
              ),
              trailing: _iconButton(context, state),
            ),
            if (state.isExpanded)
              _AdditionalInformation(
                card: card,
              ),
          ],
        );
      },
    );
  }

  Widget _iconButton(BuildContext context, CredictCardTileState state) {
    final closedIcon = Transform.rotate(
      angle: -(pi / 2),
      child: Icon(Icons.arrow_back_ios_rounded),
    );

    final openedIcon = Transform.rotate(
      angle: pi / 2,
      child: Icon(Icons.arrow_back_ios_rounded),
    );

    return IconButton(
      onPressed: () => BlocProvider.of<CredictCardTileBloc>(context).add(CredictCardChangeView()),
      icon: state.isExpanded ? openedIcon : closedIcon,
      tooltip: state.isExpanded ? 'Close' : 'Expand',
    );
  }
}

class _AdditionalInformation extends StatelessWidget {
  final CredictCard card;

  const _AdditionalInformation({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        physics: ClampingScrollPhysics(),
        children: [
          const Text(
            'Additional Info',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 6),
          _infoTile(title: 'Current balance', info: '\$${card.balance}'),
          const SizedBox(height: 6),
          _infoTile(title: 'Company', info: credictCardCompanyName(card.company)),
          const SizedBox(height: 6),
          _infoTile(title: 'CardType', info: credictCardTypeName(card.type)),
          const SizedBox(height: 6),
          _infoTile(title: 'Created', info: DateFormat('dd.MM.yyyy').format(card.created!.toDate())),
          const SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _infoTile({required String title, String? info}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(info ?? ''),
      ],
    );
  }
}
