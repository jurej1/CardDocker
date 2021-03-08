import 'package:card_docker/constants/card_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:card_docker/repositories/credict_cards_repository/src/entities/credict_card_entity.dart';
import 'package:card_docker/repositories/credict_cards_repository/src/enums/enums.dart';

class CredictCard extends Equatable {
  final String? id;
  final String? ownerId;
  final DateTime? created;
  final CredictCardCompany company;
  final double balance;
  final CredictCardType type;
  final String note;
  final Color color;

  const CredictCard({
    this.id,
    required this.ownerId,
    this.created,
    required this.company,
    required this.balance,
    required this.type,
    required this.note,
    required this.color,
  });

  factory CredictCard.empty() {
    return CredictCard(
      ownerId: '',
      company: CredictCardCompany.none,
      balance: 0,
      type: CredictCardType.none,
      note: '',
      color: CardColors.blue300!,
    );
  }

  @override
  List<Object?> get props => [id, ownerId, created, company, balance, type, note, color];

  CredictCardEntity toEntity() {
    return CredictCardEntity(
      balance: balance,
      company: company,
      created: created != null ? Timestamp.fromDate(created!) : null,
      id: id,
      ownerId: ownerId!,
      type: type,
      note: note,
      color: color,
    );
  }

  static CredictCard fromEntity(CredictCardEntity entity) {
    return CredictCard(
      type: entity.type,
      balance: entity.balance,
      company: entity.company,
      created: entity.created.toDate(),
      id: entity.id,
      ownerId: entity.ownerId,
      color: entity.color,
      note: entity.note,
    );
  }

  CredictCard copyWith({
    String? id,
    String? ownerId,
    DateTime? created,
    CredictCardCompany? company,
    double? balance,
    CredictCardType? type,
    String? note,
    Color? color,
  }) {
    return CredictCard(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      created: created ?? this.created,
      company: company ?? this.company,
      balance: balance ?? this.balance,
      type: type ?? this.type,
      note: note ?? this.note,
      color: color ?? this.color,
    );
  }
}
