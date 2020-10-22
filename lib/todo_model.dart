class Todo {
  final String _id;
  final String _title;
  final bool _isCompleted;

  Todo(
    this._id,
    this._title,
    this._isCompleted,
  );

  String get id {
    return _id;
  }

  String get title {
    return _title;
  }

  bool get isComplited {
    return _isCompleted;
  }
}
