import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:expenses/models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String) onRemove;

  TransactionList(this.transactions, this.onRemove);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: <Widget>[
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Nenhuma despesas cadastrada!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: constraints.maxHeight * (Platform.isIOS ? 1 : 0.6),
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (ctx, index) {
              final tr = transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text('R\$${tr.value}'),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.title,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  subtitle: Text(
                    DateFormat('d MM y').format(tr.date),
                  ),
                  trailing: MediaQuery.of(context).size.width > 400
                      ? TextButton(
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.delete,
                              ),
                              Text(
                                'Excluir',
                                style: TextStyle(
                                    color: Theme.of(context).errorColor),
                              )
                            ],
                          ),
                          onPressed: () => onRemove(tr.id),
                        )
                      : IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () => onRemove(tr.id),
                        ),
                ),
              );
            },
          );
  }
}
