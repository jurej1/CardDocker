import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/transactions_repository/src/enums/enums.dart';
import 'package:flutter/foundation.dart';

class TransactionEntity extends Equatable {
  final String? id;
  final String ownerId;
  final String? note;
  final String title;
  final TransactionPurpose purpose;
  final num amount;
  final String cardId; // credict card Id
  final Timestamp created;

  TransactionEntity({
    this.id,
    required this.ownerId,
    this.note,
    required this.title,
    required this.purpose,
    required this.amount,
    required this.cardId,
    Timestamp? created,
  }) : created = created ?? Timestamp.now();

  @override
  List<Object> get props {
    return [
      id!,
      ownerId,
      note!,
      title,
      purpose,
      amount,
      cardId,
      created,
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ownerId': ownerId,
      'note': note,
      'title': title,
      'purpose': describeEnum(purpose),
      'amount': amount,
      'cardId': cardId,
      'created': created,
    };
  }

  factory TransactionEntity.fromJson(Map<String, Object> data) {
    return TransactionEntity(
      amount: data['amount'] as num,
      cardId: data['cardId'] as String,
      created: data['created'] as Timestamp,
      id: data['id'] as String,
      note: data['note'] as String,
      ownerId: data['ownerId'] as String,
      title: data['title'] as String,
      purpose: stringToTransactionPurpose(data['purpose'] as String),
    );
  }

  factory TransactionEntity.fromDocument(DocumentSnapshot snap) {
    var data = snap.data();

    return TransactionEntity(
      amount: data!['amount'],
      cardId: data['cardId'],
      created: data['created'],
      id: snap.id,
      note: data['note'],
      ownerId: data['ownerId'],
      purpose: stringToTransactionPurpose(data['purpose']),
      title: data['title'],
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'ownerId': ownerId,
      'note': note,
      'title': title,
      'purpose': describeEnum(purpose),
      'amount': amount,
      'cardId': cardId,
      'created': created,
    };
  }
}
