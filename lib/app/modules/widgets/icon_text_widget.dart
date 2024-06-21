import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class IconTextWidget extends StatelessWidget {
  const IconTextWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.color,
  });

  final String icon;
  final String text;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SvgPicture.asset(icon,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn), width: 16),
        const SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            color: color,
          ),
        ),
      ],
    );
  }
}
