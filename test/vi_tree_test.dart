import 'package:flutter_test/flutter_test.dart';
import 'package:vi_collection/vi_collection.dart';

void main() {
  late ViNode<int, dynamic> tRootNode;

  setUp(() {
    tRootNode = ViNode(key: 8)
      ..children.addAll([
        ViNode(key: 3)
          ..children.addAll([
            ViNode(key: 1),
            ViNode(key: 6)
              ..children.add(ViNode(key: 4))
              ..children.add(ViNode(key: 7))
          ]),
        ViNode(key: 10)
          ..children.add(
            ViNode(key: 14)..children.add(ViNode(key: 13)),
          )
      ]);
  });

  group('OrderedTree', () {
    group('Constructors test', () {
      test('Default constructor', () {
        // act
        final tree = ViOrderedTree<int, dynamic>(
            key: 1, traversal: ViTraversalBfs<int, dynamic>());

        // assert
        expect(tree.keys, equals({1}));
        expect(tree.root, isA<ViNode<int, dynamic>>());
      });

      test('OrderedTree.fromNode', () {
        // act
        final tree = ViOrderedTree<int, dynamic>.fromNode(
          ViNode(key: 8)
            ..children.add(
              ViNode(key: 1),
            ),
          traversal: ViTraversalBfs<int, dynamic>(),
        );

        // assert
        expect(tree.keys, equals({1, 8}));
        expect(tree.root, isA<ViNode<int, dynamic>>());
      });
    });

    group('Find elements in tree', () {
      test('Should return node with key 7', () {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.find(7);

        // assert
        expect(result, isNotNull);
      });

      test('Should return null', () {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.find(15);

        // assert
        expect(result, isNull);
      });

      group('Find parent in tree', () {
        test('Parent of 14 is 10', () {
          // arrange
          final tree = ViOrderedTree.fromNode(tRootNode,
              traversal: ViTraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(14);

          // assert
          expect(result, isNotNull);
          expect(result!.key, 10);
        });

        test('Parent of 13 is 14', () {
          // arrange
          final tree = ViOrderedTree.fromNode(tRootNode,
              traversal: ViTraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(13);

          // assert
          expect(result, isNotNull);
          expect(result!.key, 14);
        });

        test('Parent not found', () {
          // arrange
          final tree = ViOrderedTree.fromNode(tRootNode,
              traversal: ViTraversalBfs<int, dynamic>());

          // act
          final result = tree.findParent(20);

          // assert
          expect(result, isNull);
        });

        test('Throw ViOrderedTreeError when no root node', () {
          // arrange
          final tree = ViOrderedTree.fromNode(ViNode<int, dynamic>(key: 8),
              traversal: ViTraversalBfs<int, dynamic>());
          tree.removeByKey(8);

          // assert
          expect(() => tree.findParent(20), throwsStateError);
        });
      });
    });

    group('Add elements to tree', () {
      test('Add element to tree was success', () {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.add(toKey: 1, key: 20);

        // assert
        expect(result, true);
      });

      test('Error. No parent to add element to tree', () {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.add(toKey: 5, key: 20);

        // assert
        expect(result, false);
      });

      test('Error. Key already exist cant add new element', () {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.add(toKey: 1, key: 3);

        // assert
        expect(result, false);
      });

      test('Throw ViOrderedTreeError when no root node', () {
        // arrange
        final tree = ViOrderedTree.fromNode(ViNode<int, dynamic>(key: 8),
            traversal: ViTraversalBfs<int, dynamic>());
        tree.removeByKey(8);

        // assert
        expect(() => tree.add(toKey: 8, key: 3), throwsStateError);
      });
    });

    group('Remove element from tree', () {
      test('Key is of root node', () async {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.removeByKey(8);

        // assert
        expect(result, true);
        expect(tree.root, isNull);
      });

      test('Key is of node without children', () async {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.removeByKey(13);

        // assert
        expect(result, true);
      });

      test('Key is of node with children', () async {
        // arrange
        final tree = ViOrderedTree.fromNode(tRootNode,
            traversal: ViTraversalBfs<int, dynamic>());

        // act
        final result = tree.removeByKey(6);

        // assert
        expect(result, true);
      });

      test('Throw ViOrderedTreeError when no root node', () {
        // arrange
        final tree = ViOrderedTree.fromNode(ViNode<int, dynamic>(key: 8),
            traversal: ViTraversalBfs<int, dynamic>());
        tree.removeByKey(8);

        // assert
        expect(() => tree.removeByKey(8), throwsStateError);
      });
    });
  });
}
