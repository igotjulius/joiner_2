import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/controllers/auth_controller.dart';
import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/expense_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';

class AddBudgetWidget extends StatefulWidget {
  final String lobbyId;
  const AddBudgetWidget({super.key, required this.lobbyId});

  @override
  State<AddBudgetWidget> createState() => _AddBudgetWidgetState();
}

class _AddBudgetWidgetState extends State<AddBudgetWidget> {
  TextEditingController _labelController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  @override
  void dispose() {
    _labelController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Add an expense'),
                IconButton(
                  onPressed: () {
                    context.pop();
                  },
                  icon: Icon(Icons.close_rounded),
                ),
              ],
            ),
            CustomTextInput(
              label: 'Label',
              controller: _labelController,
              validator: isEmpty,
            ),
            CustomTextInput(
              label: 'Amount',
              controller: _amountController,
              keyboardType: TextInputType.number,
              inputFormatters: FilteringTextInputFormatter.digitsOnly,
              validator: isEmpty,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.maxFinite,
              child: FilledButton(
                child: Text('Add'),
                onPressed: () {
                  final provider = context.read<Auth>() as UserController;
                  double amount = double.parse(_amountController.text);
                  provider
                      .putExpenses(
                    ExpenseModel(items: {_labelController.text: amount}),
                    widget.lobbyId,
                  )
                      .then((value) {
                    if (value)
                      context.pop();
                    else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        showError('Can\'t add exepense',
                            Theme.of(context).colorScheme.error),
                      );
                    }
                  });
                },
              ),
            ),
          ].divide(
            SizedBox(
              height: 10,
            ),
          ),
        ),
      ),
    );
  }
}
