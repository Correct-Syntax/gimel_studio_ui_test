import 'package:uuid/uuid.dart';

/*

{
  "layers": [
    "layer_001": {
      "id": 0,
      "name": "Layer 001",
      "visible": true,
      "locked": false,
    }
  ]
}

*/

enum BlendMode {
  normal,
  darken,
  multiply,
  colorBurn,
  // ...
}

class Layer {
  Layer({
    required this.id,
    required this.index,
    required this.name,
    required this.selected,
    required this.visible,
    required this.locked,
    required this.opacity,
    required this.blend,
    required this.data,
  });

  final int id;
  int index;
  String name;
  bool selected;
  bool visible;
  bool locked;
  int opacity;
  BlendMode blend;
  Object data;

  dynamic thumbnail = null;

  void setIndex(int newIndex) {
    index = newIndex;
  }

  void setSelected(bool isSelected) {
    selected = isSelected;
  }

  void setVisibility(bool isVisible) {
    visible = isVisible;
  }

  void setLocked(bool isLocked) {
    locked = isLocked;
  }

  @override
  String toString() {
    return '$index';
  }
}

class LayerStack {
  LayerStack({
    required this.layeringOpacity,
    required this.layeringBlendMode,
  });

  final Object layeringOpacity;
  final Object layeringBlendMode;
  List<Layer> layers = [];

  /// Inserts a new [layer] at [index] to the layer stack.
  void insertNewLayer(Layer layer, int index) {
    UuidValue uuidValue = Uuid().v4obj();
  }

  /// Move [layer] to the index [moveToIndex].
  void moveLayer(Layer layer, int moveToIndex) {}

  /// Delete the layer at [index].
  void deleteLayer(int index) {}
}

void main() {}
