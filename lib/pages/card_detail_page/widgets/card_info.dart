import 'package:card_docker/functions/credict_card_company_name.dart';
import 'package:card_docker/functions/credict_card_type_name.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CardInfo extends StatelessWidget {
  final CredictCard card;
  final box = SizedBox(height: 8);

  CardInfo({Key? key, required this.card}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).primaryColor.withOpacity(0.25),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Info',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          box,
          _TextColumn(
            title: 'Note',
            content: card.note,
          ),
          box,
          _TextColumn(
            title: 'Balance',
            content: '\$ ${card.balance.toStringAsFixed(2)}',
          ),
          box,
          _TextColumn(
            title: 'Company',
            content: credictCardCompanyName(card.company),
          ),
          box,
          _TextColumn(
            title: 'Created',
            content: DateFormat('dd MMMM yyyy').format(card.created!),
          ),
          box,
          _TextColumn(
            title: 'Type',
            content: credictCardTypeName(card.type),
          ),
        ],
      ),
    );
  }
}

class _TextColumn extends StatelessWidget {
  final String title;
  final String content;

  const _TextColumn({
    Key? key,
    required this.title,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(
          height: 2,
        ),
        Text(
          content,
        ),
      ],
    );
  }
}
