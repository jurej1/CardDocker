import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

IconData credictCardCompanyToIconData(CredictCardCompany company) {
  if (company == CredictCardCompany.americanExspress) {
    return FontAwesomeIcons.ccAmex;
  } else if (company == CredictCardCompany.bankOfAmerica) {
    return FontAwesomeIcons.flagUsa;
  } else if (company == CredictCardCompany.barclays) {
    return FontAwesomeIcons.dove;
  } else if (company == CredictCardCompany.capitalOne) {
    return FontAwesomeIcons.piggyBank;
  } else if (company == CredictCardCompany.chase) {
    return FontAwesomeIcons.piggyBank;
  } else if (company == CredictCardCompany.citibank) {
    return FontAwesomeIcons.city;
  } else if (company == CredictCardCompany.discover) {
    return FontAwesomeIcons.ccDiscover;
  } else if (company == CredictCardCompany.masterCard) {
    return FontAwesomeIcons.ccMastercard;
  } else if (company == CredictCardCompany.none) {
    return FontAwesomeIcons.piggyBank;
  } else if (company == CredictCardCompany.pncBank) {
    return FontAwesomeIcons.piggyBank;
  } else if (company == CredictCardCompany.synchronyFinancial) {
    return FontAwesomeIcons.piggyBank;
  } else if (company == CredictCardCompany.usBank) {
    return FontAwesomeIcons.flagUsa;
  } else if (company == CredictCardCompany.usaa) {
    return FontAwesomeIcons.dove;
  } else if (company == CredictCardCompany.visa) {
    return FontAwesomeIcons.ccVisa;
  } else {
    return FontAwesomeIcons.piggyBank;
  }
}
