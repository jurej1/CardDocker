import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

enum TransactionPurpose {
  rent,
  autoInsurance,
  healthInsurance,
  medicalCosts,
  electricity,
  water,
  sanitation,
  internet,
  carPayment,
  gasoline,
  publicTransportation,
  food,
  clothing,
  gym,
  movies,
  homeDecor,
  alcohol,
  largePurchase,
  none,
}

TransactionPurpose stringToTransactionPurpose(String value) {
  if (value == 'rent') {
    return TransactionPurpose.rent;
  } else if (value == 'autoInsurance') {
    return TransactionPurpose.autoInsurance;
  } else if (value == 'healthInsurance') {
    return TransactionPurpose.healthInsurance;
  } else if (value == 'medicalCosts') {
    return TransactionPurpose.medicalCosts;
  } else if (value == 'electricity') {
    return TransactionPurpose.electricity;
  } else if (value == 'water') {
    return TransactionPurpose.water;
  } else if (value == 'sanitation') {
    return TransactionPurpose.sanitation;
  } else if (value == 'internet') {
    return TransactionPurpose.internet;
  } else if (value == 'carPayment') {
    return TransactionPurpose.carPayment;
  } else if (value == 'gasoline') {
    return TransactionPurpose.gasoline;
  } else if (value == 'publicTransportation') {
    return TransactionPurpose.publicTransportation;
  } else if (value == 'food') {
    return TransactionPurpose.food;
  } else if (value == 'clothing') {
    return TransactionPurpose.clothing;
  } else if (value == 'gym') {
    return TransactionPurpose.gym;
  } else if (value == 'movies') {
    return TransactionPurpose.movies;
  } else if (value == 'homeDecor') {
    return TransactionPurpose.homeDecor;
  } else if (value == 'alcohol') {
    return TransactionPurpose.alcohol;
  } else if (value == 'largePurchase') {
    return TransactionPurpose.largePurchase;
  } else {
    return TransactionPurpose.none;
  }
}

String transactionPurposeToString(TransactionPurpose? purpose) {
  if (purpose == TransactionPurpose.alcohol) {
    return 'Alcohol';
  } else if (purpose == TransactionPurpose.autoInsurance) {
    return 'Auto insurance';
  } else if (purpose == TransactionPurpose.carPayment) {
    return 'Car payment';
  } else if (purpose == TransactionPurpose.clothing) {
    return 'Clothing';
  } else if (purpose == TransactionPurpose.electricity) {
    return 'Electricity';
  } else if (purpose == TransactionPurpose.food) {
    return 'Food';
  } else if (purpose == TransactionPurpose.gasoline) {
    return 'Gasoline';
  } else if (purpose == TransactionPurpose.gym) {
    return 'Gym';
  } else if (purpose == TransactionPurpose.healthInsurance) {
    return 'Health Insurance';
  } else if (purpose == TransactionPurpose.homeDecor) {
    return 'Home Decor';
  } else if (purpose == TransactionPurpose.internet) {
    return 'Internet';
  } else if (purpose == TransactionPurpose.largePurchase) {
    return 'Large purchase';
  } else if (purpose == TransactionPurpose.medicalCosts) {
    return 'Medical cost';
  } else if (purpose == TransactionPurpose.movies) {
    return 'Movies';
  } else if (purpose == TransactionPurpose.none) {
    return 'None';
  } else if (purpose == TransactionPurpose.publicTransportation) {
    return 'Publical Transportation';
  } else if (purpose == TransactionPurpose.rent) {
    return 'Rent';
  } else if (purpose == TransactionPurpose.sanitation) {
    return 'Sanitation';
  } else if (purpose == TransactionPurpose.water) {
    return 'Water';
  } else {
    return '';
  }
}

IconData transactionPurposeToIconData(TransactionPurpose purpose) {
  if (purpose == TransactionPurpose.alcohol) {
    return FontAwesomeIcons.cocktail;
  } else if (purpose == TransactionPurpose.autoInsurance) {
    return FontAwesomeIcons.carCrash;
  } else if (purpose == TransactionPurpose.carPayment) {
    return FontAwesomeIcons.car;
  } else if (purpose == TransactionPurpose.clothing) {
    return FontAwesomeIcons.userTie;
  } else if (purpose == TransactionPurpose.electricity) {
    return FontAwesomeIcons.bolt;
  } else if (purpose == TransactionPurpose.food) {
    return FontAwesomeIcons.hamburger;
  } else if (purpose == TransactionPurpose.gasoline) {
    return FontAwesomeIcons.gasPump;
  } else if (purpose == TransactionPurpose.gym) {
    return FontAwesomeIcons.dumbbell;
  } else if (purpose == TransactionPurpose.healthInsurance) {
    return FontAwesomeIcons.heartbeat;
  } else if (purpose == TransactionPurpose.homeDecor) {
    return FontAwesomeIcons.home;
  } else if (purpose == TransactionPurpose.internet) {
    return FontAwesomeIcons.wifi;
  } else if (purpose == TransactionPurpose.largePurchase) {
    return FontAwesomeIcons.coins;
  } else if (purpose == TransactionPurpose.medicalCosts) {
    return FontAwesomeIcons.userMd;
  } else if (purpose == TransactionPurpose.movies) {
    return FontAwesomeIcons.ticketAlt;
  } else if (purpose == TransactionPurpose.none) {
    return FontAwesomeIcons.moneyBillWave;
  } else if (purpose == TransactionPurpose.publicTransportation) {
    return FontAwesomeIcons.subway;
  } else if (purpose == TransactionPurpose.rent) {
    return FontAwesomeIcons.building;
  } else if (purpose == TransactionPurpose.sanitation) {
    return FontAwesomeIcons.toiletPaper;
  } else if (purpose == TransactionPurpose.water) {
    return FontAwesomeIcons.tint;
  } else {
    return FontAwesomeIcons.moneyBillWave;
  }
}
