import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class ToolItem extends StatelessWidget {
  const ToolItem({
    super.key,
    required this.isSelected,
    required this.normalIcon,
    required this.selectedIcon,
    required this.onTap,
  });

  final bool isSelected;
  final PhosphorIconData normalIcon;
  final PhosphorIconData selectedIcon;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      borderRadius: BorderRadius.circular(6.0),
      child: Container(
        width: 40.0,
        height: 40.0,
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF1C1C1C) : Colors.transparent,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: PhosphorIcon(
          isSelected ? selectedIcon : normalIcon,
          color: isSelected ? const Color(0xff5C7AD8) : Colors.white60,
          size: 20.0,
        ),
      ),
    );
  }
}
