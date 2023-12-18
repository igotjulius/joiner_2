import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/resources/modals/add_budget_model.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class AddBudgetWidget extends StatefulWidget {
  final String? lobbyId;
  const AddBudgetWidget({super.key, this.lobbyId});

  @override
  State<AddBudgetWidget> createState() => _AddBudgetWidgetState();
}

class _AddBudgetWidgetState extends State<AddBudgetWidget> {
  late AddBudgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => AddBudgetModel());

    _model.labelController ??= TextEditingController();
    _model.amountController ??= TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _model.dispose();
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
              controller: _model.labelController,
              validator: _model.labelValidator,
            ),
            CustomTextInput(
              label: 'Amount',
              controller: _model.amountController,
              keyboardType: TextInputType.number,
              inputFormatters: FilteringTextInputFormatter.digitsOnly,
              validator: _model.amountValidator,
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: double.maxFinite,
              child: FilledButton(
                child: Text('Add'),
                onPressed: () {
                  _model.addExpenses(widget.lobbyId!);
                  context.pop();
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
