/// Base class for all properties.
class Property {
  Property({
    required this.id,
    required this.dataType,
    required this.value,
  });

  final String id;
  final Type dataType;
  dynamic value;

  void setValue(dynamic newValue) {
    value = newValue;
  }
}

/// Integer input.
class IntegerProperty extends Property {
  IntegerProperty({
    required super.id,
    required super.dataType,
    required super.value,
  }) : assert(value is int);
}

/// Base class for all parameters.
class Parameter {
  Parameter({
    required this.id,
    required this.dataType,
    required this.value,
  });

  final String id;
  final dynamic dataType;
  dynamic value;
  NodeBase? connection;

  void setValue(dynamic newValue) {
    value = newValue;
  }

  void setConnection(NodeBase newConnection) {
    connection = newConnection;
  }
}

/// Integer output.
class IntegerParameter extends Parameter {
  IntegerParameter({
    required super.id,
    required super.dataType,
    required super.value,
  });
}

/// The base class for all nodes.
class NodeBase {
  NodeBase({
    required this.id,
  }) {
    defineProperties();
    defineParameters();
  }

  final String id;

  Map<String, Property> properties = {};
  Map<String, Parameter> parameters = {};

  bool isOutput() {
    return false;
  }

  /// Use for the output node only.
  NodeBase? get connectedNode {
    return null;
  }

  void defineProperties() {
    properties = {};
  }

  void defineParameters() {
    parameters = {};
  }

  void setPropertyValue(String name, dynamic newValue) {
    Property? property = properties[name];
    assert(property != null);
    property?.setValue(newValue);
  }

  void setParameterConnection(String name, NodeBase connectedNode) {
    Parameter? parameter = parameters[name];
    assert(parameter != null);
    parameter?.setConnection(connectedNode);
  }

  dynamic evaluateProperty(EvalInfo eval, String id) {
    return eval.evaluateProperty(id);
  }

  dynamic evaluateParameter(EvalInfo eval, String id) {
    return eval.evaluateParameter(id);
  }

  dynamic evaluateNode(EvalInfo eval) {
    return null;
  }
}

class IntegerNode extends NodeBase {
  IntegerNode({super.id = 'int'});

  //final String name;

  @override
  void defineProperties() {
    properties = {
      'number': IntegerProperty(id: 'number', dataType: int, value: 21),
    };
  }

  @override
  int evaluateNode(EvalInfo eval) {
    int number = eval.evaluateProperty('number');
    return number;
  }
}

class AddNode extends NodeBase {
  AddNode({super.id = 'add'});

  //final String name;

  @override
  void defineParameters() {
    parameters = {
      'a': IntegerParameter(
        id: 'a',
        dataType: int,
        value: 0,
      ),
      'b': IntegerParameter(
        id: 'b',
        dataType: int,
        value: 0,
      ),
    };
  }

  @override
  int evaluateNode(EvalInfo eval) {
    int inputA = evaluateParameter(eval, 'a');
    int inputB = evaluateParameter(eval, 'b');

    return inputA + inputB;
  }
}

class OutputNode extends NodeBase {
  OutputNode({super.id = 'output'});

  //final String name;

  @override
  bool isOutput() {
    return true;
  }

  @override
  NodeBase? get connectedNode {
    return parameters['final']?.connection;
  }

  @override
  void defineParameters() {
    parameters = {
      'final': IntegerParameter(
        id: 'final',
        dataType: int,
        value: 10,
      ),
    };
  }
}

class OutputNode2 extends NodeBase {
  OutputNode2({super.id = 'output2'});

  //final String name;

  @override
  bool isOutput() {
    return true;
  }

  @override
  NodeBase? get connectedNode {
    return parameters['final']?.connection;
  }

  @override
  void defineParameters() {
    parameters = {
      'final': IntegerParameter(
        id: 'final',
        dataType: int,
        value: 10,
      ),
    };
  }
}

class EvalInfo {
  EvalInfo({required this.node});

  final NodeBase node;

  /// Evaluate the value of the parameter [name] of [node].
  dynamic evaluateParameter(String name) {
    Parameter param = node.parameters[name]!;
    if (param.connection != null) {
      // Evaluate the next node
      EvalInfo info = EvalInfo(node: param.connection!);
      return param.connection?.evaluateNode(info);
    }
    return param.value;
  }

  /// Evaluate the value of the property [name] of [node].
  dynamic evaluateProperty(String name) {
    Property prop = node.properties[name]!;
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
    print('${outputNode.id} connection -> ${outputNode.parameters['final']?.connection}');

    NodeBase? nodeConnectedToOutput = outputNode.connectedNode;
    if (nodeConnectedToOutput == null) {
      // No node is connected to the output node.
      return -1;
    }

    EvalInfo evalInfo = EvalInfo(node: nodeConnectedToOutput);
    int result = evalInfo.node.evaluateNode(evalInfo);

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
  nodes['add']?.setParameterConnection('a', nodes['integer']!);
  nodes['add']?.setParameterConnection('b', nodes['integer2']!);

  nodes['output']?.setParameterConnection('final', nodes['add']!);

  int result = renderer.render('output');
  print(result.toString());

  // Second output node
  nodes['output2']?.setParameterConnection('final', nodes['integer']!);

  int result2 = renderer2.render('output2');
  print(result2.toString());
}
