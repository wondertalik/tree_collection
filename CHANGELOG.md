# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

### [2.0.1](https://github.com/wondertalik/tree_collection/compare/v2.0.0...v2.0.1) (2021-09-25)


### Bug Fixes

* sort when add node only when comparador is not null ([462f066](https://github.com/wondertalik/tree_collection/commit/462f066c9975ee1150ef97947f591f00a34eda29))

## [2.0.0](https://github.com/wondertalik/tree_collection/compare/v1.0.1...v2.0.0) (2021-09-15)


### ⚠ BREAKING CHANGES

* add equatable as dependency

### Features

* add equatable as dependency ([fa83157](https://github.com/wondertalik/tree_collection/commit/fa83157c523d0f3c0a7d9e418212854044f47526))

### [1.0.1](https://github.com/wondertalik/tree_collection/compare/v1.0.0...v1.0.1) (2021-09-13)

## 1.0.0 (2021-09-13)


### ⚠ BREAKING CHANGES

* rename traverseFromNodeByKey to traverseFromNode
* remove prefix Vi
* throw error if key is not found in traverseFromNodeByKey method
* remove flutter dependencies
* instead of return boolean value throw a StateError if:
- key already exists
- toKey is not found
* root can be deleted
* traversal BFS search method to separate class

### Features

* add DFS postorder searching ([e7e37b0](https://github.com/wondertalik/tree_collection/commit/e7e37b00cf2252bc8b80bc9f1486631ec1b6aa7d))
* add option sorting callback when add element ([a5cf493](https://github.com/wondertalik/tree_collection/commit/a5cf493698e2ccb740aff71c0b28b6a1e63e647b))
* Add traversal direction and DFS preorder searching ([6306e27](https://github.com/wondertalik/tree_collection/commit/6306e27bf416deb04dc87cc0472fbd94e1522b63))
* add tree with BFS searching ([ef41a3c](https://github.com/wondertalik/tree_collection/commit/ef41a3cf441ce8de095414abb892463f854580bd))
* change signature of add method ([cd090ab](https://github.com/wondertalik/tree_collection/commit/cd090ab74d2cede000a00e23a9d4abb41e5c39a2))
* remove flutter dependencies ([7d81735](https://github.com/wondertalik/tree_collection/commit/7d8173592fd4af168662c407ca4555c2766fe0f8))
* root can be deleted ([74e2def](https://github.com/wondertalik/tree_collection/commit/74e2defdee5dfc4e37fa7e4ddd7a66e00ee79e55))


* remove prefix Vi ([f8e4a48](https://github.com/wondertalik/tree_collection/commit/f8e4a485d881352217d8f88b6081fc7bc90081a8))
* rename traverseFromNodeByKey to traverseFromNode ([493735b](https://github.com/wondertalik/tree_collection/commit/493735b23cb69c1cb300e92041b3b49039caaf2b))
* throw error if key is not found in traverseFromNodeByKey method ([a97d033](https://github.com/wondertalik/tree_collection/commit/a97d033e4f76f5ec3c61efba0054398ba0ab0107))
* traversal BFS search method to separate class ([1611e76](https://github.com/wondertalik/tree_collection/commit/1611e76c34a2c836c36c20536382ce887a278bcc))
