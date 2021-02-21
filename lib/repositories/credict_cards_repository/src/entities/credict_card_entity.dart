import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/credict_cards_repository/src/enums/enums.dart';

class CredictCardEntity extends Equatable {
  final String id;
  final String ownerId;
  final Timestamp created;
  final CredictCardCompany company;
  final String bank;
  final double balance;
  final CredictCardType type;
  final int number; // only last 4 digits

  CredictCardEntity({
    this.id,
    this.ownerId,
    Timestamp created,
    this.company,
    this.bank,
    this.balance,
    this.type,
    this.number,
  }) : created = created ?? Timestamp.now();

  @override
  List<Object> get props => [id, ownerId, created, company, bank, balance, type, number];

  @override
  String toString() {
    return 'CredictCard: { id: $id, ownerId: $ownerId, created: $created, company: $company, bank: $bank, balance: $balance, type: $type, number: $number }';
  }

  Map<String, Object> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'created': created,
      'company': company,
      'bank': bank,
      'balance': balance,
      'type': type,
      'number': number,
    };
  }

  static CredictCardEntity fromJson(Map<String, Object> data) {
    return CredictCardEntity(
      balance: data['balance'] as double,
      bank: data['bank'] as String,
      company: data['company'] as CredictCardCompany,
      created: data['created'] as Timestamp,
      id: data['id'] as String,
      number: data['number'] as int,
      ownerId: data['ownerId'] as String,
      type: data['type'] as CredictCardType,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'ownerId': ownerId,
      'created': created,
      'company': company,
      'bank': bank,
      'balance': balance,
      'type': type,
      'number': number,
    };
  }

  static CredictCardEntity fromDocument(DocumentSnapshot snap) {
    final data = snap.data();

    return CredictCardEntity(
      balance: data['balance'],
      bank: data['bank'],
      company: data['company'],
      created: data['created'],
      id: snap.id,
      number: data['number'],
      ownerId: data['ownerId'],
      type: data['type'],
    );
  }
}
