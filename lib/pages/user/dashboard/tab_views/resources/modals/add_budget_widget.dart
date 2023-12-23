import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:joiner_1/pages/user/dashboard/provider/lobby_provider.dart';
import 'package:joiner_1/pages/user/dashboard/tab_views/resources/modals/add_budget_model.dart';
import 'package:joiner_1/utils/utils.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';
import 'package:provider/provider.dart';

class AddBudgetWidget extends StatefulWidget {
  final String? lobbyId;
  const AddBudgetWidget({super.key, this.lobbyId});

  @override
  State<AddBudgetWidget> createState() => _AddBudgetWidgetState();
}

class _AddBudgetWidgetState extends State<AddBudgetWidget> {
  late AddBudgetModel _model;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _model = AddBudgetModel();

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
        child: Form(
          key: _formKey,
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
                validator: isEmpty,
              ),
              CustomTextInput(
                label: 'Amount',
                controller: _model.amountController,
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
                    // _model.addExpenses(widget.lobbyId!);
                    if (_formKey.currentState!.validate()) {
                      context.read<LobbyProvider>().addExpense(
                            _model.labelController!.text,
                            double.parse(_model.amountController!.text),
                          );
                      context.pop();
                    }
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
      ),
    );
  }
}
