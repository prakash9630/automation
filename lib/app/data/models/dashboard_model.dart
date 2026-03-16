import 'package:flutter/material.dart';

class PipelineItem {
  final int count;
  final String label;
  final Color color;

  PipelineItem(this.count, this.label, this.color);
}

class ActionItem {
  final String title;
  final String iconPath; // For emoji or simple SVG paths

  ActionItem(this.title, this.iconPath);
}

class DashboardData {
  final String initials;
  final String title;
  final String subTitle;
  final Color color;
  final bool isPinned;
  final String? timestamp;

  DashboardData({
    required this.initials,
    required this.title,
    required this.subTitle,
    required this.color,
    this.isPinned = false,
    this.timestamp,
  });
}
