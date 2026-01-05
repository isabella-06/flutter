import 'package:flutter/material.dart';

/// Widget that displays a large index/ranking number with a styled shadow effect
/// Used to show rankings (1-5) on top movie, series, and actor items
class IndexNumber extends StatelessWidget {
  const IndexNumber({
    super.key,
    required this.number,
  });
  /// The number to display (typically 1-5 for top rankings)
  final int number;
  @override
  Widget build(BuildContext context) {
    return Text(
      (number).toString(),
      style: const TextStyle(
        fontSize: 120,
        fontWeight: FontWeight.w600,
        shadows: [
          Shadow(
            offset: Offset(-1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, -1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
          Shadow(
            offset: Offset(-1.5, 1.5),
            color: Color(0xFF0296E5),
          ),
        ],
        color: Color(0xFF242A32),
      ),
    );
  }
}
