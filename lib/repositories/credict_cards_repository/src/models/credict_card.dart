import 'package:card_docker/repositories/credict_cards_repository/src/entities/credict_card_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/credict_cards_repository/src/enums/enums.dart';

class CredictCard extends Equatable {
  final String id;
  final String ownerId;
  final Timestamp created;
  final CredictCardCompany company;
  final String bank;
  final double balance;
  final CredictCardType type;
  final int number;

  const CredictCard({
    this.id,
    this.ownerId,
    this.created,
    this.company,
    this.bank,
    this.balance,
    this.type,
    this.number,
  });

  @override
  List<Object> get props {
    return [
      id,
      ownerId,
      created,
      company,
      bank,
      balance,
      type,
      number,
    ];
  }

  CredictCardEntity toEntity() {
    return CredictCardEntity(
      balance: balance,
      bank: bank,
      company: company,
      created: created,
      id: id,
      number: number,
      ownerId: ownerId,
      type: type,
    );
  }

  CredictCard fromEntity(CredictCardEntity entity) {
    return CredictCard(
      type: entity.type,
      balance: entity.balance,
      bank: entity.bank,
      company: entity.company,
      created: entity.created,
      id: entity.id,
      number: entity.number,
      ownerId: entity.ownerId,
    );
  }
}
