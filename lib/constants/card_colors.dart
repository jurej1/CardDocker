import 'package:flutter/material.dart';

class CardColors {
  const CardColors();

  static final purple100 = Colors.purple[100];
  static final purple300 = Colors.purple[300];
  static final pink100 = Colors.pink[100];
  static final pink300 = Colors.pink[300];
  static final red100 = Colors.red[100];
  static final red400 = Colors.red[300];
  static final deepPurple100 = Colors.deepPurple[100];
  static final deepPurple300 = Colors.deepPurple[300];
  static final indigo100 = Colors.indigo[100];
  static final indigo300 = Colors.indigo[300];
  static final blue100 = Colors.blue[100];
  static final blue300 = Colors.blue[300];
  static final lightBlue100 = Colors.lightBlue[100];
  static final lightBlue300 = Colors.lightBlue[300];
  static final cyan100 = Colors.cyan[100];
  static final cyan300 = Colors.cyan[300];
  static final teal100 = Colors.teal[100];
  static final teal300 = Colors.teal[300];
  static final green100 = Colors.green[100];
  static final green300 = Colors.green[300];
  static final lightGreen100 = Colors.lightGreen[100];
  static final lightGreen300 = Colors.lightGreen[300];
  static final deepOrange100 = Colors.deepOrange[100];
  static final deepOrange300 = Colors.deepOrange[300];

  static final List<Color> colors = [
    purple100,
    purple300,
    pink100,
    pink300,
    red100,
    red400,
    deepPurple100,
    deepPurple300,
    indigo100,
    indigo300,
    blue100,
    blue300,
    lightBlue100,
    lightBlue300,
    cyan100,
    cyan300,
    teal100,
    teal300,
    green100,
    green300,
    lightGreen100,
    lightGreen300,
    deepOrange100,
    deepOrange300,
  ];

  static String colorName(Color color) {
    if (color == purple100) {
      return 'Light purple';
    } else if (color == teal100) {
      return 'Light teal';
    } else if (color == teal300) {
      return 'Teal';
    } else if (color == green100) {
      return 'Light dark green';
    } else if (color == green300) {
      return 'Dark gree';
    } else if (color == lightGreen100) {
      return 'Light light green';
    } else if (color == lightGreen300) {
      return 'Light green';
    } else if (color == deepOrange100) {
      return 'Light deep orange';
    } else if (color == deepOrange300) {
      return 'Deep orange';
    } else if (color == purple300) {
      return 'Purple';
    } else if (color == pink100) {
      return 'Light pink';
    } else if (color == pink300) {
      return 'Pink';
    } else if (color == red100) {
      return 'Light red';
    } else if (color == red400) {
      return 'Red';
    } else if (color == deepPurple100) {
      return 'Light deep purple';
    } else if (color == deepPurple300) {
      return 'Deep purple';
    } else if (color == indigo100) {
      return 'Light indigo';
    } else if (color == indigo300) {
      return 'Indigo';
    } else if (color == blue100) {
      return 'Light dark blue';
    } else if (color == blue300) {
      return 'Dark Blue';
    } else if (color == lightBlue100) {
      return 'Light light blue';
    } else if (color == lightBlue300) {
      return 'Light blue';
    } else if (color == cyan100) {
      return 'Light cyan';
    } else if (color == cyan300) {
      return 'Cyan';
    } else {
      return 'None';
    }
  }
}
