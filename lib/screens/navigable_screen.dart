import 'package:flutter/material.dart';

abstract class NavigableScreen extends StatelessWidget {
  const NavigableScreen({
    super.key,
    required this.title,
    this.floatingActionButton,
  });

  final String title;
  final FloatingActionButton? floatingActionButton;
}
