import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:joiner_1/components/user/add_budget_model.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/widgets/atoms/text_input.dart';

class AddBudgetWidget extends StatefulWidget {
  const AddBudgetWidget({super.key});

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
    return Dialog(
      insetPadding: EdgeInsets.all(20),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Wrap(
          alignment: WrapAlignment.center,
          children: [
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
            FFButtonWidget(
              text: 'Add',
              onPressed: () {
                _model.addBudget();
                context.pop();
              },
              options: FFButtonOptions(height: 40),
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
