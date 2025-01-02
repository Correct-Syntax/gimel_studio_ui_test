import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:gimel_studio_ui_test/layer.dart';
import 'package:gimel_studio_ui_test/layer_item.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class LayersPanel extends StatefulWidget {
  const LayersPanel({super.key});

  @override
  State<LayersPanel> createState() => _LayersPanelState();
}

class _LayersPanelState extends State<LayersPanel> {
  final List<Layer> layers = [
    Layer(
      id: 0,
      index: 0,
      name: 'Really long named Layer 1',
      selected: true,
      visible: true,
      locked: false,
      opacity: 100,
      blend: BlendMode.normal,
      data: 0,
    ),
    Layer(
      id: 1,
      index: 1,
      name: 'Layer 2',
      selected: false,
      visible: true,
      locked: false,
      opacity: 100,
      blend: BlendMode.normal,
      data: 0,
    ),
    Layer(
      id: 2,
      index: 2,
      name: 'Layer 3',
      selected: false,
      visible: true,
      locked: false,
      opacity: 100,
      blend: BlendMode.normal,
      data: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final List<Widget> layerWidgets = [
      for (Layer layer in layers)
        InkWell(
          key: Key('${layer.id}'),
          onTap: () {
            // Select layer
            for (Layer ilayer in layers) {
              if (layer == ilayer) {
                ilayer.setSelected(true);
              } else {
                ilayer.setSelected(false);
              }
            }
            setState(() {});
          },
          child: LayerItem(
            key: Key('${layer.id}'),
            index: layers.indexWhere((i) => layer.id == i.id),
            name: layer.name,
            isSelected: layer.selected,
            isVisible: layer.visible,
            isLocked: layer.locked,
            onToggleVisibility: () {
              layer.setVisibility(!layer.visible);
              setState(() {});
            },
            onToggleLocked: () {
              layer.setLocked(!layer.locked);
              setState(() {});
            },
          ),
        ),
    ];

    Widget proxyDecorator(Widget child, int index, Animation<double> animation) {
      return AnimatedBuilder(
        animation: animation,
        builder: (BuildContext context, Widget? child) {
          final double animValue = Curves.easeInOut.transform(animation.value);
          final double scale = lerpDouble(1, 1.02, animValue)!;
          return Transform.scale(
            scale: scale,
            child: Material(
              color: Colors.transparent,
              shadowColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
              child: layerWidgets[index],
            ),
          );
        },
        child: child,
      );
    }

    return Container(
      color: Color(0xFF292929),
      width: 250.0,
      padding: const EdgeInsets.all(5.0),
      child: Column(
        children: [
          Row(
            spacing: 5.0,
            children: [
              // Layer blend
              Expanded(
                child: Container(
                  height: 30,
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  decoration: BoxDecoration(
                    color: Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Color(0xFF363636),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Normal',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12.0,
                        ),
                      ),
                      PhosphorIcon(
                        PhosphorIcons.caretDown(PhosphorIconsStyle.light),
                        color: Colors.white70,
                        size: 12.0,
                      ),
                    ],
                  ),
                ),
              ),

              // Opacity
              Expanded(
                child: Container(
                  height: 30,
                  //width: 140,
                  decoration: BoxDecoration(
                    color: Color(0xFF1F1F1F),
                    borderRadius: BorderRadius.circular(4.0),
                    border: Border.all(
                      color: Color(0xFF363636),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: double.infinity,
                          height: 30,
                          decoration: BoxDecoration(
                            color: Color(0xFF363636),
                            borderRadius: BorderRadius.circular(4.0),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            '100%',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12.0,
                            ),
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Text(
                            'Opacity',
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
              ),
            ],
          ),

          // STACK
          const SizedBox(height: 8.0),

          Expanded(
            child: ReorderableListView(
              buildDefaultDragHandles: false,
              proxyDecorator: proxyDecorator,
              onReorder: (int oldIndex, int newIndex) {
                setState(() {
                  if (oldIndex < newIndex) {
                    newIndex -= 1;
                  }
                  final Layer item = layers.removeAt(oldIndex);
                  //item.index = newIndex;
                  layers.insert(newIndex, item);
                  print(layers);
                });
              },
              children: layerWidgets,
            ),
          ),

          // Bottom
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: PhosphorIcon(
                  PhosphorIcons.plus(PhosphorIconsStyle.light),
                  color: Colors.white70,
                  size: 16.0,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: PhosphorIcon(
                  PhosphorIcons.trashSimple(PhosphorIconsStyle.light),
                  color: Colors.white70,
                  size: 16.0,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
