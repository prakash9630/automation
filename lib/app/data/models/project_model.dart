import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectModel {
  final String id;
  final String name;
  final String company;
  final String initials;
  final Color color;
  final RxBool isFavorite;

  ProjectModel({
    required this.id,
    required this.name,
    required this.company,
    required this.initials,
    required this.color,
    bool isFavorite = false,
  }) : isFavorite = isFavorite.obs;
}
