import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTrans extends StatefulWidget {
  final Function addTx;
  NewTrans(this.addTx);

  @override
  _NewTransState createState() => _NewTransState();
}

class _NewTransState extends State<NewTrans> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _subData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final entTitle = _titleController.text;
    final entAmount = double.parse(_amountController.text);
    if (entTitle.isEmpty || entAmount <= 0 || _selectedDate == null) {
      return;
    }
    widget.addTx(
      entTitle,
      entAmount,
      _selectedDate,
    );
    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2021),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'На что потратил?'),
              controller: _titleController,
              onSubmitted: (_) => _subData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Сколько потратил?'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(),
              onSubmitted: (_) => _subData(),
            ),
            Container(
              height: 60,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Дата не выбрана!'
                          : DateFormat.yMEd().format(_selectedDate),
                    ),
                  ),
                  // ignore: deprecated_member_use
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                    child: Text(
                      'выбрать день',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              // ignore: deprecated_member_use
              child: RaisedButton(
                padding: EdgeInsets.all(15),
                onPressed: _subData,
                child: Text('ДОБАВИТЬ'),
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
