import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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

IconData credictCardTypeToIconData(CredictCardType type) {
  if (type == CredictCardType.business) {
    return FontAwesomeIcons.briefcase;
  } else if (type == CredictCardType.credict) {
    return FontAwesomeIcons.creditCard;
  } else if (type == CredictCardType.debit) {
    return FontAwesomeIcons.moneyCheck;
  } else if (type == CredictCardType.none) {
    return FontAwesomeIcons.moneyBill;
  } else if (type == CredictCardType.premiumRewards) {
    return FontAwesomeIcons.gem;
  } else if (type == CredictCardType.retail) {
    return FontAwesomeIcons.store;
  } else if (type == CredictCardType.rewards) {
    return FontAwesomeIcons.award;
  } else if (type == CredictCardType.students) {
    return FontAwesomeIcons.graduationCap;
  } else {
    return FontAwesomeIcons.creditCard;
  }
}
