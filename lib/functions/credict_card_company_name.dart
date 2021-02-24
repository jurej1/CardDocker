import 'package:card_docker/repositories/credict_cards_repository/src/enums/enums.dart';

String credictCardCompanyName(CredictCardCompany company) {
  if (company == CredictCardCompany.americanExspress) {
    return 'American Exspress';
  } else if (company == CredictCardCompany.bankOfAmerica) {
    return 'Bank of America';
  } else if (company == CredictCardCompany.barclays) {
    return 'Barclays';
  } else if (company == CredictCardCompany.capitalOne) {
    return 'Capital One';
  } else if (company == CredictCardCompany.chase) {
    return 'Chase';
  } else if (company == CredictCardCompany.citibank) {
    return 'Citibank';
  } else if (company == CredictCardCompany.discover) {
    return 'Discover';
  } else if (company == CredictCardCompany.mastercard) {
    return 'MasterCard';
  } else if (company == CredictCardCompany.none) {
    return 'none';
  } else if (company == CredictCardCompany.pncBank) {
    return 'PNC Bank';
  } else if (company == CredictCardCompany.synchronyFinancial) {
    return 'Synchrony Financial';
  } else if (company == CredictCardCompany.usBank) {
    return 'U.S. Bank';
  } else if (company == CredictCardCompany.visa) {
    return 'Visa';
  } else {
    return 'none';
  }
}
