import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

import 'package:card_docker/repositories/credict_cards_repository/src/enums/enums.dart';
import 'package:flutter/foundation.dart';

class CredictCardEntity extends Equatable {
  final String? id;
  final String ownerId;
  final Timestamp created;
  final CredictCardCompany company;
  final double balance;
  final CredictCardType type;
  final Color color;
  final String note;

  CredictCardEntity({
    Timestamp? created,
    this.id,
    required this.ownerId,
    required this.company,
    required this.balance,
    required this.type,
    required this.color,
    required this.note,
  }) : created = created ?? Timestamp.now();

  @override
  List<Object?> get props => [id, ownerId, created, company, balance, type, color, note];

  @override
  String toString() {
    return 'CredictCard: { id: $id, ownerId: $ownerId, created: $created, company: $company, balance: $balance, type: $type, color: $color, note: $note}';
  }

  Map<String, Object> toJson() {
    return {
      'id': id!,
      'ownerId': ownerId,
      'created': created,
      'company': company,
      'balance': balance,
      'type': type,
      'color': color,
      'note': note
    };
  }

  static CredictCardEntity fromJson(Map<String, Object> data) {
    return CredictCardEntity(
      balance: data['balance'] as double,
      company: data['company'] as CredictCardCompany,
      created: data['created'] as Timestamp,
      id: data['id'] as String,
      ownerId: data['ownerId'] as String,
      type: data['type'] as CredictCardType,
      color: data['color'] as Color,
      note: data['note'] as String,
    );
  }

  Map<String, Object> toDocument() {
    return {
      'ownerId': ownerId,
      'created': created,
      'company': describeEnum(company),
      'balance': balance,
      'type': describeEnum(type),
      'color': color.value,
      'note': note,
    };
  }

  static CredictCardEntity fromDocument(DocumentSnapshot snap) {
    final data = snap.data();

    return CredictCardEntity(
      balance: data!['balance'],
      created: data['created'],
      id: snap.id,
      ownerId: data['ownerId'],
      color: Color(data['color']),
      note: data['note'],
      type: stringToCredictCardType(data['type']),
      company: stringToCredictCardCompany(data['company']),
    );
  }

  CredictCardEntity copyWith({
    String? id,
    String? ownerId,
    Timestamp? created,
    CredictCardCompany? company,
    double? balance,
    CredictCardType? type,
    Color? color,
    String? note,
  }) {
    return CredictCardEntity(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      created: created ?? this.created,
      company: company ?? this.company,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      color: color ?? this.color,
      note: note ?? this.note,
    );
  }
}
