enum CredictCardCompany {
  visa,
  masterCard,
  citibank,
  chase,
  americanExspress,
  capitalOne,
  bankOfAmerica,
  discover,
  synchronyFinancial,
  barclays,
  usBank,
  usaa,
  pncBank,
  none,
}

CredictCardCompany stringToCredictCardCompany(String value) {
  if (value == 'visa') {
    return CredictCardCompany.visa;
  } else if (value == 'masterCard') {
    return CredictCardCompany.masterCard;
  } else if (value == 'citibank') {
    return CredictCardCompany.citibank;
  } else if (value == 'chase') {
    return CredictCardCompany.chase;
  } else if (value == 'americanExspress') {
    return CredictCardCompany.americanExspress;
  } else if (value == 'capitalOne') {
    return CredictCardCompany.capitalOne;
  } else if (value == 'bankOfAmerica') {
    return CredictCardCompany.bankOfAmerica;
  } else if (value == 'discover') {
    return CredictCardCompany.discover;
  } else if (value == 'synchronyFinancial') {
    return CredictCardCompany.synchronyFinancial;
  } else if (value == 'barclays') {
    return CredictCardCompany.barclays;
  } else if (value == 'usBank') {
    return CredictCardCompany.usBank;
  } else if (value == 'usaa') {
    return CredictCardCompany.usaa;
  } else if (value == 'pncBanke') {
    return CredictCardCompany.pncBank;
  } else {
    return CredictCardCompany.none;
  }
}
