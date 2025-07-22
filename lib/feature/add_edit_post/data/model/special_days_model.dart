import 'package:flutter/material.dart';

class SpecialDaysModel {
  final String title;
  final DateTimeRange rangeDate;
  final String price;

  SpecialDaysModel(
      {required this.rangeDate, required this.price, required this.title});
}
