import 'package:expenses/Components/adaptative_button.dart';
import 'package:expenses/Components/adaptative_date_picker.dart';
import 'package:expenses/Components/adaptative_text_field.dart';
import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleController = TextEditingController();

  final _valueController = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleController.text;
    final value = double.tryParse(_valueController.text) ?? 0.0;

    if (title.isEmpty || value <= 0 || _selectedDate == null) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              AdaptativeTextField(
                controller: _titleController,
                onSubmitted: (value) => _submitForm(),
                label: 'Titulo',
              ),
              AdaptativeTextField(
                controller: _valueController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (value) => _submitForm(),
                label: 'Valor (R\$)',
              ),
              AdaptativeDatePicker(
                selectedDate: _selectedDate,
                onDateChanged: (newDate) => {
                  setState(() {
                    _selectedDate = newDate;
                  })
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AdapativeButton(
                    label: 'Nova Transa????o',
                    onPressed: _submitForm,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
