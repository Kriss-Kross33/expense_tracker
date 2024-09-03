import 'package:expense_track/src/core/core.dart';
import 'package:flutter/material.dart';

class EmptyState extends StatelessWidget {
  const EmptyState({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          AssetConsts.emptyState,
          width: 200,
          height: 200,
          fit: BoxFit.cover,
        ),
        const Text(
          'No data available',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
