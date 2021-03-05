import 'package:card_docker/repositories/transactions_repository/src/entities/entities.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/transactions_repository/src/enums/enums.dart';

class Transaction extends Equatable {
  final String? id;
  final String ownerId;
  final String? note;
  final String title;
  final TransactionPurpose purpose;
  final num amount;
  final String cardId;
  final Timestamp? created;

  const Transaction({
    this.id,
    required this.ownerId,
    this.note,
    required this.title,
    required this.purpose,
    required this.amount,
    required this.cardId,
    this.created,
  });

  @override
  List<Object?> get props {
    return [
      id,
      note,
      ownerId,
      title,
      purpose,
      amount,
      cardId,
      created,
    ];
  }

  static final empty = Transaction(
    amount: 0,
    cardId: '',
    ownerId: '',
    purpose: TransactionPurpose.none,
    title: '',
  );

  Transaction copyWith({
    String? id,
    String? ownerId,
    String? note,
    String? title,
    TransactionPurpose? purpose,
    num? amount,
    String? cardId,
    Timestamp? created,
  }) {
    return Transaction(
      id: id ?? this.id,
      ownerId: ownerId ?? this.ownerId,
      note: note ?? this.note,
      title: title ?? this.title,
      purpose: purpose ?? this.purpose,
      amount: amount ?? this.amount,
      cardId: cardId ?? this.cardId,
      created: created ?? this.created,
    );
  }

  TransactionEntity toEntity() {
    return TransactionEntity(
      amount: amount,
      cardId: cardId,
      created: created,
      id: id,
      note: note!,
      ownerId: ownerId,
      purpose: purpose,
      title: title,
    );
  }

  factory Transaction.fromEntity(TransactionEntity entity) {
    return Transaction(
      amount: entity.amount,
      cardId: entity.cardId,
      created: entity.created,
      id: entity.id!,
      note: entity.note,
      ownerId: entity.ownerId,
      purpose: entity.purpose,
      title: entity.title,
    );
  }
}
