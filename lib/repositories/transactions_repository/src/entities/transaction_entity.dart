import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/transactions_repository/src/enums/enums.dart';
import 'package:flutter/foundation.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String ownerId;
  final String note;
  final String title;
  final TransactionPurpose purpose;
  final num amount;
  final String connectedTo; // credict card Id
  final Timestamp created;

  TransactionEntity({
    this.id,
    this.ownerId,
    this.note,
    this.title,
    this.purpose,
    this.amount,
    this.connectedTo,
    Timestamp created,
  }) : created = created ?? Timestamp.now();

  @override
  List<Object> get props {
    return [
      id,
      ownerId,
      note,
      title,
      purpose,
      amount,
      connectedTo,
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
      'connectedTo': connectedTo,
      'created': created,
    };
  }

  factory TransactionEntity.fromJson(Map<String, Object> data) {
    return TransactionEntity(
      amount: data['amount'],
      connectedTo: data['connectedTo'],
      created: data['created'],
      id: data['id'],
      note: data['note'],
      ownerId: data['ownerId'],
      title: data['title'],
      purpose: stringToTransactionPurpose(data['purpose']),
    );
  }

  factory TransactionEntity.fromDocument(DocumentSnapshot snap) {
    final data = snap.data();

    return TransactionEntity(
      amount: data['amount'],
      connectedTo: data['connectedTo'],
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
      'connectedTo': connectedTo,
      'created': created,
    };
  }
}
