import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewExpanse extends StatefulWidget {
  const NewExpanse({super.key});

  @override
  State<NewExpanse> createState() => _NewExpanseState();
}

class _NewExpanseState extends State<NewExpanse> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  final formatter = DateFormat.yMd();
  DateTime? _selectedDate;

  @override
  void dispose() {
    super.dispose();
    _titleController.dispose();
    _amountController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            controller: _titleController,
            maxLength: 50, // طول الاحرف
            decoration: const InputDecoration(
              label: Text("Title"),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    label: Text("Amount"),
                    prefixText: "\$ ",
                  ),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 16,),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                        _selectedDate == null
                            ? "Select Date"
                            : formatter.format(_selectedDate!),
                    ),
                    IconButton(
                        onPressed: () async {
                          final now = DateTime.now();
                          final firstDate = DateTime(now.year-50, now.month, now.day);
                          final DateTime? pickedDate =  await showDatePicker(
                              context: context,
                              initialDate: now,
                              firstDate: firstDate,
                              lastDate: now);
                          setState(() {
                            _selectedDate = pickedDate;
                          });
                        },
                        icon: const Icon(Icons.date_range)
                    ),
                  ],
                ),
              )
            ],
          ),
          const SizedBox(height: 30,),
          Row(
            children: [
              TextButton(
                // what is the thing that you want to close ? (context)
                  onPressed: ()=>Navigator.pop(context) ,
                  child: const Text("Cancel")
              ),
              ElevatedButton(
                onPressed: (){
                  log(_titleController.text);
                },
                child: const Text("Save Expanse"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
