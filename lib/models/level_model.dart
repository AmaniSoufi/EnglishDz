import 'package:flutter/material.dart';

class LevelModel {
  String title;
  String subtitle;
  String image;
  Color? color;
  LevelModel({
    required this.title,
    required this.subtitle,
    required this.image,
    this.color,
  });
}
