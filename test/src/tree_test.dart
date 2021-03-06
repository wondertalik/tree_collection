import 'package:test/test.dart';
import 'package:tree_collection/tree_collection.dart';

void main() {
  late Node<int, dynamic> tRootNode;

  setUp(() {
    tRootNode = Node(key: 8)
      ..children.addAll([
        Node(key: 3)
          ..children.addAll([
            Node(key: 1),
            Node(key: 6)
              ..children.add(Node(key: 4))
              ..children.add(Node(key: 7))
          ]),
        Node(key: 10)
          ..children.add(
            Node(key: 14)..children.add(Node(key: 13)),
          )
      ]);
  });

  group('OrderedTree', () {
    group('Constructors test', () {
      test('Default constructor', () {
        // act
        final tree = OrderedTree<int, dynamic>(
            key: 1, traversal: TraversalBfs<int, dynamic>());

        // assert
        expect(tree.keys, equals({1}));
        expect(tree.root, isA<Node<int, dynamic>>());
      });

      test('OrderedTree.fromNode', () {
        // act
        final tree = OrderedTree<int, dynamic>.fromNode(
          Node(key: 8)
            ..children.add(
              Node(key: 1),
            ),
          traversal: TraversalBfs<int, dynamic>(),
        );

        // assert
        expect(tree.keys, equals({1, 8}));
        expect(tree.root, isA<Node<int, dynamic>>());
      });
    });

    group('Find elements in tree', () {
      test('Should return node with key 7', () {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        final result = tree.find(7);

        // assert
        expect(result, isNotNull);
      });

      test('Should return null', () {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        final result = tree.find(15);

        // assert
        expect(result, isNull);
      });

      group('Find parent in tree', () {
        test('Parent of 14 is 10', () {
          // arrange
          final tree = OrderedTree.fromNode(tRootNode,
              traversal: TraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(14);

          // assert
          expect(result, isNotNull);
          expect(result!.key, 10);
        });

        test('Parent of 13 is 14', () {
          // arrange
          final tree = OrderedTree.fromNode(tRootNode,
              traversal: TraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(13);

          // assert
          expect(result, isNotNull);
          expect(result!.key, 14);
        });

        test('Parent not found', () {
          // arrange
          final tree = OrderedTree.fromNode(tRootNode,
              traversal: TraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(20);

          // assert
          expect(result, isNull);
        });

        test('Throw OrderedTreeError when no root node', () {
          // arrange
          final tree = OrderedTree.fromNode(Node<int, dynamic>(key: 8),
              traversal: TraversalBfs<int, dynamic>());
          tree.removeByKey(8);

          // assert
          expect(() => tree.findParent(20), throwsStateError);
        });
      });
    });

    group('Add elements to tree', () {
      test('Add element to tree was success', () {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // assert
        expect(() => tree.add(toKey: 1, key: 20), returnsNormally);
      });

      test('Add element and sorting to tree was success', () {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        tree.add(
            toKey: 6, key: 5, comparator: (a, b) => a.key.compareTo(b.key));
        final result = tree.find(5);

        // assert
        expect(result, isNotNull);
        expect(tree.find(6)!.children.map((e) => e.key).toList(),
            equals([4, 5, 7]));
      });

      test('Error. No parent to add element to tree', () {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // assert
        expect(() => tree.add(toKey: 5, key: 20), throwsA(isA<StateError>()));
      });

      test("Error. Key already exist can't add new element", () {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // assert
        expect(() => tree.add(toKey: 1, key: 3), throwsStateError);
      });

      test('Throw OrderedTreeError when no root node', () {
        // arrange
        final tree = OrderedTree.fromNode(Node<int, dynamic>(key: 8),
            traversal: TraversalBfs<int, dynamic>());
        tree.removeByKey(8);

        // assert
        expect(() => tree.add(toKey: 8, key: 3), throwsStateError);
      });
    });

    group('Remove element from tree', () {
      test('Key is of root node', () async {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        final result = tree.removeByKey(8);

        // assert
        expect(result, true);
        expect(tree.root, isNull);
      });

      test('Key is of node without children', () async {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        final result = tree.removeByKey(13);

        // assert
        expect(result, true);
      });

      test('Key is of node with children', () async {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        final result = tree.removeByKey(6);

        // assert
        expect(result, true);
      });

      test('Throw OrderedTreeError when no root node', () {
        // arrange
        final tree = OrderedTree.fromNode(Node<int, dynamic>(key: 8),
            traversal: TraversalBfs<int, dynamic>());
        tree.removeByKey(8);

        // assert
        expect(() => tree.removeByKey(8), throwsStateError);
      });
    });

    group('Traverse tree from node', () {
      test('Throw OrderedTreeError when no root node', () {
        // arrange
        final tree = OrderedTree.fromNode(Node<int, dynamic>(key: 8),
            traversal: TraversalBfs<int, dynamic>());
        tree.removeByKey(8);

        // assert
        expect(
            () => tree.traverseFromNode(
                key: 8, callback: (node) => true),
            throwsStateError);
      });

      test('Return a list of nodes starting from root, startNode included',
          () async {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        final keys = <int>{};
        tree.traverseFromNode(
            key: tree.root!.key,
            callback: (node) {
              keys.add(node.key);
              return true;
            });

        // assert
        expect(keys, equals({8, 3, 10, 1, 6, 14, 4, 7, 13}));
      });

      test('Return a list of nodes starting from 6, startNode included',
          () async {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        final keys = <int>{};
        tree.traverseFromNode(
            key:6,
            callback: (node) {
              keys.add(node.key);
              return true;
            });

        // assert
        expect(keys, equals({6, 4, 7}));
      });

      test("Throw OrderedTreeError when key not found", () async {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // assert
        expect(
            () => tree.traverseFromNode(
                key: 24, callback: (node) => true),
            throwsA(isA<StateError>()));
      });
    });

    group('Change traversal', () {
      test('Change from TraversalBfs to TraversalDfsIterativePreOrder',
          () async {
        // arrange
        final tree = OrderedTree.fromNode(tRootNode,
            traversal: TraversalBfs<int, dynamic>());

        // act
        tree.setTraversal(TraversalDfsIterativePreOrder<int, dynamic>());

        // assert
        expect(
            tree.traversal, isA<TraversalDfsIterativePreOrder<int, dynamic>>());
      });
    });
  });
}
