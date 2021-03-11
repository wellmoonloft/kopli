import 'dart:collection';

///模拟栈操作.
class Stack<E> {
  final Queue<E> _stack;
  final int _maxSize;

  Stack(this._maxSize) : _stack = ListQueue<E>();

  bool get isEmpty => _stack.isEmpty;

  bool get isFull => _stack.length == _maxSize;

  int get size => _stack.length;

  ///入栈
  push(E e) {
    if (isFull) {
      _stack.removeLast();
    }
    _stack.addFirst(e);
  }

  ///出栈
  E pop() {
    if (isEmpty) return null;
    return _stack.removeFirst();
  }

  ///清空
  clear() {
    _stack.clear();
  }

  E get top {
    if (isEmpty) return null;
    return _stack.first;
  }
}

///存储撤销和重写文本内容的栈.
class TextChangeStack {
  final int maxSize;

  Stack<String> _undoStack;
  Stack<String> _redoStack;

  String _current;

  /// [maxSize]最多撤销/重写次数, [init]初始值
  TextChangeStack({this.maxSize, String init}) {
    _undoStack = Stack<String>(maxSize);
    _redoStack = Stack<String>(maxSize);
    _current = init;
  }

  add(String s) {
    _redoStack.clear();
    if (_current != null) {
      _undoStack.push(_current);
    }
    _current = s;
  }

  ///撤销并返回上一次内容
  String undo() {
    String s = _undoStack.pop();
    if (s != null) {
      _redoStack.push(_current);
      _current = s;
    }
    return s;
  }

  ///重写并返回上一次撤销内容.
  String redo() {
    String s = _redoStack.pop();
    if (s != null) {
      _undoStack.push(_current);
      _current = s;
    }
    return s;
  }
}
