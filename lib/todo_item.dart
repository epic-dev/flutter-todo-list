import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/todo_model.dart';
import 'package:todolist/todos_provider.dart';

class TodoItem extends StatefulWidget {
  final Function onTap;
  final String id;
  final String title;
  final bool state;
  final TextEditingController textController = TextEditingController();

  TodoItem({Key key, this.onTap, this.id, this.title, this.state}) : super(key: key);

  @override
  _TodoItemState createState() => _TodoItemState();
}

class _TodoItemState extends State<TodoItem> {
  bool _state;
  bool _editing;
  @override
  void initState() {
    super.initState();
    _state = widget.state;
    _editing = false;
  }

  void _toggleState(bool state) {
    setState(() {
      _state = state;
    });
    widget.onTap(state);
  }

  void _toggleEdit() {
    setState(() {
      _editing = !_editing;
    });
  }

  void _submitValue() async {
    final todo = Todo(widget.id, widget.textController.text, widget.state);
    await Provider.of<TodosProvider>(context, listen: false).editTodo(widget.id, todo);
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        if (!_editing)
          ListTile(
            onTap: _toggleEdit,
            leading: Checkbox(value: _state, onChanged: _toggleState),
            title: Text(
              widget.title,
              style: TextStyle(decoration: _state ? TextDecoration.lineThrough : TextDecoration.none),
            ),
          ),
        if (_editing)
          TextField(
            controller: widget.textController,
            autofocus: true,
            onEditingComplete: () {
              _toggleEdit();
              _submitValue();
            },
          )
      ],
    );
  }
}
