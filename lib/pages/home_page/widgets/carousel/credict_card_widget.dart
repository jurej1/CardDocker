import 'dart:math';

import 'package:card_docker/functions/credict_card_company_name.dart';
import 'package:card_docker/repositories/credict_cards_repository/credict_cards_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CredictCardWidget extends StatelessWidget {
  final CredictCard card;

  const CredictCardWidget({Key? key, required this.card}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height * 0.3;

    return Container(
      width: width,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: card.color,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        alignment: Alignment.centerLeft,
        children: [
          Positioned(
            left: 0,
            top: 0,
            child: _NavIcon(),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: _BalanceOutput(balance: card.balance),
          ),
          _NoteOutput(note: card.note),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            child: ConstrainedBox(
              constraints: BoxConstraints(maxHeight: 35, maxWidth: width),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _DateOutput(created: card.created!),
                  _CompanyOutput(company: card.company),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _NavIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 32,
      width: 32,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.orangeAccent,
        shape: BoxShape.circle,
      ),
      child: FittedBox(
        fit: BoxFit.contain,
        child: Transform.rotate(
          alignment: Alignment.center,
          angle: pi / 6,
          child: Icon(
            Icons.navigation_rounded,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

class _BalanceOutput extends StatelessWidget {
  final double balance;

  const _BalanceOutput({Key? key, required this.balance}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      '\$ ${balance.toStringAsFixed(2)}',
      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
    );
  }
}

class _DateOutput extends StatelessWidget {
  final DateTime _created;

  final String _bullet = "\u2022 ";

  late String _bulletsText = '';

  _DateOutput({
    Key? key,
    required DateTime created,
  })   : _created = created,
        super(key: key) {
    List.generate(4, (index) {
      return _bullet;
    }).forEach((element) {
      _bulletsText = _bulletsText + element;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _bulletsText + ' ' + DateFormat('yyyy').format(_created),
      style: TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}

class _CompanyOutput extends StatelessWidget {
  final CredictCardCompany company;

  const _CompanyOutput({
    Key? key,
    required this.company,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(maxHeight: 40),
      child: FittedBox(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Placeholder(
              fallbackHeight: 40,
              fallbackWidth: 80,
            ),
            Text(
              credictCardCompanyName(company),
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NoteOutput extends StatelessWidget {
  final String note;

  const _NoteOutput({
    Key? key,
    required this.note,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Text(
      note,
      style: const TextStyle(
        color: Colors.white,
      ),
    );
  }
}
