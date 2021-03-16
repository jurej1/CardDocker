import 'package:card_docker/models/tier.dart';

class Tiers {
  static final justStarted = const Tier(amount: 1, title: 'Just started');
  static final starter = const Tier(amount: 10, title: 'Starter');
  static final getingUsed = const Tier(amount: 50, title: 'Getting used');
  static final amateur = const Tier(amount: 100, title: 'Amateur');
  static final theBasic = const Tier(amount: 500, title: 'The basic');
  static final fastLearner = const Tier(amount: 1000, title: 'Fast learner');
  static final stepedUpTheGame = const Tier(amount: 2500, title: 'Steped up the game');
  static final middleLeague = const Tier(amount: 5000, title: 'Middle League');
  static final pro = const Tier(amount: 7000, title: 'Pro');
  static final legendary = const Tier(amount: 10000, title: 'Legendary');

  static final values = [
    justStarted,
    starter,
    getingUsed,
    amateur,
    theBasic,
    fastLearner,
    middleLeague,
    pro,
    legendary,
  ];
}
