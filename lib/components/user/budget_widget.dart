import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_model.dart';
export 'budget_model.dart';

class BudgetWidget extends StatefulWidget {
  final Map<String, double>? budget;
  final String? lobbyId;
  const BudgetWidget({Key? key, this.budget, this.lobbyId}) : super(key: key);

  @override
  _BudgetWidgetState createState() => _BudgetWidgetState();
}

class _BudgetWidgetState extends State<BudgetWidget> {
  late BudgetModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BudgetModel());
    _model.keys = widget.budget?.keys.toList();
    _model.budget = widget.budget;
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    context.watch<FFAppState>();

    return Container(
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget',
                ),
                FilledButton.tonal(
                  child: Text('Add'),
                  onPressed: () {
                    _model.addBudget(context, widget.lobbyId!);
                  },
                ),
              ],
            ),
            Expanded(
              child: _model.showBudget(widget.lobbyId!),
            ),
          ],
        ),
      ),
    );
  }
}
