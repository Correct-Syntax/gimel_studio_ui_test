//import 'package:flutter/material.dart';
//import 'package:phosphor_flutter/phosphor_flutter.dart';

enum DataType {
  integer,
}

class Output {
  Output({
    required this.name,
    required this.dataType,
  });

  /// The string by which this output will be referenced.
  /// This should be unique per node type.
  final String name;

  /// The data type of this output.
  final DataType dataType;
}

/// Base class for all properties.
///
/// A Property is the representation of a single point of
/// data that can changed either be evaluation of an input
/// or by the change of the value directly by the user.
class Property {
  Property({
    required this.name,
    required this.dataType,
    required this.value,
  });

  /// The string by which this property will be referenced.
  /// This should be unique per node type.
  final String name;

  /// The data type of this property.
  final DataType dataType;

  /// The current value of the property, which is
  /// used if ``connection`` is null.
  Object value;

  /// The connected node to evaluate the value from.
  /// If this is null, then value is used during evaluation.
  /// (NodeBase object, name of the connected node's Output)
  (NodeBase, String)? connection;

  void setValue(Object newValue) {
    if (dataType == DataType.integer) {
      assert(newValue is int);
    }
    value = newValue;
  }

  void setConnection((NodeBase, String) newConnection) {
    connection = newConnection;
  }
}

/// Integer input.
class IntegerProperty extends Property {
  IntegerProperty({
    required super.name,
    required super.dataType,
    required super.value,
  }) : assert(value is int);
}

/// The base class for all nodes.
class NodeBase {
  NodeBase({
    required this.name,
  }) {
    defineMeta();
    defineProperties();
    defineOutputs();
  }

  /// The string by which the node type will be referenced.
  /// This should be unique among all nodes.
  final String name;

  String label = '...';
  //PhosphorIconData icon = PhosphorIcons.notepad(PhosphorIconsStyle.light);
  //Offset position = const Offset(0, 0);
  bool selected = false;

  Map<String, Property> properties = {};
  Map<String, Output> outputs = {};

  bool isOutput() {
    return false;
  }

  /// Use for the output node only.
  (NodeBase, String)? get connectedNode {
    return null;
  }

  void defineMeta() {}

  void defineProperties() {
    properties = {};
  }

  void defineOutputs() {
    outputs = {};
  }

  void setPropertyValue(String name, Object newValue) {
    Property? property = properties[name];
    assert(property != null);
    property?.setValue(newValue);
  }

  void setConnection(String name, NodeBase connectedNode, String connectedNodeOutputName) {
    Property? property = properties[name];
    assert(property != null);
    property?.setConnection((connectedNode, connectedNodeOutputName));
  }

  dynamic evaluateProperty(EvalInfo eval, String id) {
    return eval.evaluateProperty(id);
  }

  Map<String, dynamic> evaluateNode(EvalInfo eval) {
    return {};
  }
}

class IntegerNode extends NodeBase {
  IntegerNode({super.name = 'integer'});

  @override
  void defineMeta() {
    label = 'Integer';
    //icon = PhosphorIcons.numberCircleOne(PhosphorIconsStyle.light);
  }

  @override
  void defineProperties() {
    properties = {
      'number': IntegerProperty(name: 'number', dataType: DataType.integer, value: 21),
    };
  }

  @override
  void defineOutputs() {
    outputs = {
      'output': Output(
        name: 'output',
        dataType: DataType.integer,
      ),
    };
  }

  @override
  Map<String, int> evaluateNode(EvalInfo eval) {
    int number = eval.evaluateProperty('number');
    return {
      'output': number,
    };
  }
}

class AddNode extends NodeBase {
  AddNode({super.name = 'add'});

  @override
  void defineMeta() {
    label = 'Add';
    //icon = PhosphorIcons.plusCircle(PhosphorIconsStyle.light);
  }

  @override
  void defineProperties() {
    properties = {
      'a': IntegerProperty(
        name: 'a',
        dataType: DataType.integer,
        value: 0,
      ),
      'b': IntegerProperty(
        name: 'b',
        dataType: DataType.integer,
        value: 0,
      ),
    };
  }

  @override
  void defineOutputs() {
    outputs = {
      'output': Output(
        name: 'output',
        dataType: DataType.integer,
      ),
    };
  }

  @override
  Map<String, int> evaluateNode(EvalInfo eval) {
    int inputA = evaluateProperty(eval, 'a');
    int inputB = evaluateProperty(eval, 'b');

    return {
      'output': inputA + inputB,
    };
  }
}

class OutputNode extends NodeBase {
  OutputNode({super.name = 'output'});

  @override
  bool isOutput() {
    return true;
  }

  @override
  (NodeBase, String)? get connectedNode {
    return properties['final']?.connection;
  }

  @override
  void defineMeta() {
    label = 'Output';
    //icon = PhosphorIcons.layout(PhosphorIconsStyle.light);
  }

  @override
  void defineProperties() {
    properties = {
      'final': IntegerProperty(
        name: 'final',
        dataType: DataType.integer,
        value: 10,
      ),
    };
  }
}

class OutputNode2 extends NodeBase {
  OutputNode2({super.name = 'output2'});

  @override
  bool isOutput() {
    return true;
  }

  @override
  (NodeBase, String)? get connectedNode {
    return properties['final']?.connection;
  }

  @override
  void defineProperties() {
    properties = {
      'final': IntegerProperty(
        name: 'final',
        dataType: DataType.integer,
        value: 10,
      ),
    };
  }
}

class EvalInfo {
  EvalInfo({required this.node});

  final NodeBase node;

  /// Evaluate the value of the parameter [name] of [node].
  dynamic evaluateProperty(String name) {
    Property prop = node.properties[name]!;
    if (prop.connection != null) {
      // Evaluate the next node
      EvalInfo info = EvalInfo(node: prop.connection!.$1);
      return prop.connection?.$1.evaluateNode(info)[prop.connection!.$2];
    }
    return prop.value;
  }
}

class Renderer {
  Renderer({
    required this.nodes,
  });

  final Map<String, NodeBase> nodes;

  int render(String outputNodeId) {
    NodeBase outputNode = getOutputNode(outputNodeId);
    print('${outputNode.name} connection -> ${outputNode.properties['final']?.connection}');

    // The node that is connected to this output node.
    NodeBase? nodeConnectedToOutput = outputNode.connectedNode?.$1;
    // The name of the output of the node connected to this output node.
    String? connectedOutputName = outputNode.connectedNode?.$2;

    if (nodeConnectedToOutput == null || connectedOutputName == null) {
      // No node is connected to the output node.
      return -1;
    }

    EvalInfo evalInfo = EvalInfo(node: nodeConnectedToOutput);
    int result = evalInfo.node.evaluateNode(evalInfo)[connectedOutputName];

    return result;
  }

  NodeBase getOutputNode(String outputNodeId) {
    NodeBase? outputNode;
    for (String key in nodes.keys) {
      if (nodes[key]?.isOutput() == true && outputNodeId == key) {
        outputNode = nodes[key];
      }
    }
    assert(outputNode != null);
    return outputNode!;
  }
}

void main() {
  Map<String, NodeBase> nodes = {
    'integer': IntegerNode(),
    'integer2': IntegerNode(),
    'add': AddNode(),
    'output': OutputNode(),
    'output2': OutputNode2(),
  };

  Renderer renderer = Renderer(nodes: nodes);
  Renderer renderer2 = Renderer(nodes: nodes);

  // First output node
  nodes['integer']!.setPropertyValue('number', 6);
  nodes['add']?.setConnection('a', nodes['integer']!, 'output');
  nodes['add']?.setConnection('b', nodes['integer2']!, 'output');

  nodes['output']?.setConnection('final', nodes['add']!, 'output');

  int result = renderer.render('output');
  print(result.toString());

  // Second output node
  nodes['output2']?.setConnection('final', nodes['integer']!, 'output');

  int result2 = renderer2.render('output2');
  print(result2.toString());
}
