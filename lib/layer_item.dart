import 'package:flutter/material.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LayerItem extends StatelessWidget {
  const LayerItem({
    super.key,
    required this.index,
    required this.name,
    required this.isSelected,
    required this.isVisible,
    required this.isLocked,
    required this.onToggleVisibility,
    required this.onToggleLocked,
  });

  final int index;
  final String name;
  final bool isSelected;
  final bool isVisible;
  final bool isLocked;
  final Function() onToggleVisibility;
  final Function() onToggleLocked;

  @override
  Widget build(BuildContext context) {
    return ReorderableDragStartListener(
      key: super.key,
      index: index,
      child: Container(
        height: 34.0,
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        decoration: BoxDecoration(
          color: isSelected ? Color(0xFF363636) : Color(0xFF292929),
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Row(
                spacing: 8.0,
                children: [
                  PhosphorIcon(
                    PhosphorIcons.caretRight(PhosphorIconsStyle.light),
                    color: Colors.white70,
                    size: 12.0,
                  ),
                  Container(
                    color: Colors.white,
                    width: 26.0,
                    height: 16.0,
                  ),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.only(right: 4.0),
                      child: Text(
                        name,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              spacing: 8.0,
              children: [
                InkWell(
                  onTap: onToggleLocked,
                  child: PhosphorIcon(
                    isLocked
                        ? PhosphorIcons.lock(PhosphorIconsStyle.light)
                        : PhosphorIcons.lockOpen(PhosphorIconsStyle.light),
                    color: Colors.white70,
                    size: 14.0,
                  ),
                ),
                InkWell(
                  onTap: onToggleVisibility,
                  child: PhosphorIcon(
                    isVisible
                        ? PhosphorIcons.eye(PhosphorIconsStyle.light)
                        : PhosphorIcons.eyeSlash(PhosphorIconsStyle.light),
                    color: Colors.white70,
                    size: 14.0,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
