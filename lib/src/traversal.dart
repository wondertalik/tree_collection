part of tree.collection;

typedef TraversalCall<K, V> = bool Function(Node<K, V> node);

abstract class Traversal<K, V> {
  Traversal({this.direction = TraversalDirection.leftToRight});

  final TraversalDirection direction;

  traverse(Node<K, V> startNode, {required TraversalCall<K, V> callback});
}

enum TraversalDirection { leftToRight, rightToLeft }

class TraversalBfs<K, V> extends Traversal<K, V> {
  TraversalBfs({
    TraversalDirection direction = TraversalDirection.leftToRight,
  }) : super(direction: direction);

  @override
  traverse(Node<K, V> startNode, {required TraversalCall<K, V> callback}) {
    var queue = ListQueue<Node<K, V>>();
    queue.add(startNode);
    do {
      var currentNode = queue.removeFirst();

      final nodeChildren = direction == TraversalDirection.leftToRight
          ? currentNode.children.reversed
          : currentNode.children;
      for (final child in nodeChildren) {
        queue.add(child);
      }
      final result = callback(currentNode);
      if (!result) break;
    } while (queue.isNotEmpty);
  }
}

class TraversalDfsIterativePreOrder<K, V> extends Traversal<K, V> {
  TraversalDfsIterativePreOrder({
    TraversalDirection direction = TraversalDirection.leftToRight,
  }) : super(direction: direction);

  @override
  traverse(Node<K, V> startNode, {required TraversalCall<K, V> callback}) {
    var stack = <Node<K, V>>[];
    stack.add(startNode);
    do {
      var currentNode = stack.removeLast();
      final result = callback(currentNode);
      if (!result) break;

      final nodeChildren = direction == TraversalDirection.leftToRight
          ? currentNode.children.reversed
          : currentNode.children;
      for (final child in nodeChildren) {
        stack.add(child);
      }
    } while (stack.isNotEmpty);
  }
}
