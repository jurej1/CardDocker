import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'package:card_docker/repositories/transactions_repository/src/enums/enums.dart';

class TransactionEntity extends Equatable {
  final String id;
  final String ownerId;
  final String note;
  final String title;
  final TransactionPurpose purpose;
  final num amount;
  final String connectedTo; // credict card Id
  final Timestamp created;

  const TransactionEntity({
    this.id,
    this.ownerId,
    this.note,
    this.title,
    this.purpose,
    this.amount,
    this.connectedTo,
    this.created,
  });

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
}
