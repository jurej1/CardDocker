enum CredictCardType {
  business,
  rewards,
  premiumRewards,
  students,
  retail,
  credict,
  debit,
  none,
}

CredictCardType stringToCredictCardType(String value) {
  if (value == 'business') {
    return CredictCardType.business;
  } else if (value == 'rewards') {
    return CredictCardType.rewards;
  } else if (value == 'premiumRewards') {
    return CredictCardType.premiumRewards;
  } else if (value == 'students') {
    return CredictCardType.students;
  } else if (value == 'retail') {
    return CredictCardType.retail;
  } else if (value == 'credict') {
    return CredictCardType.credict;
  } else if (value == 'debit') {
    return CredictCardType.debit;
  } else {
    return CredictCardType.none;
  }
}
