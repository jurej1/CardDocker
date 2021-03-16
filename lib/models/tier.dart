import 'package:equatable/equatable.dart';

class Tier extends Equatable {
  final int amount;
  final String title;

  const Tier({
    required this.amount,
    required this.title,
  });

  @override
  List<Object?> get props => [amount, title];
}
