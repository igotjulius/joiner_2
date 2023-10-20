import 'package:joiner_1/components/user/add_budget_widget.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_graph_model.dart';
export 'budget_graph_model.dart';

class BudgetGraphWidget extends StatefulWidget {
  final Map<String, double>? budget;
  final String? lobbyId;
  const BudgetGraphWidget({Key? key, this.budget, this.lobbyId})
      : super(key: key);

  @override
  _BudgetGraphWidgetState createState() => _BudgetGraphWidgetState();
}

class _BudgetGraphWidgetState extends State<BudgetGraphWidget> {
  late BudgetGraphModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BudgetGraphModel());
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
      width: double.infinity,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Budget',
                  style: FlutterFlowTheme.of(context).titleMedium.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                ),
                FFButtonWidget(
                  text: 'Add',
                  onPressed: () {
                    _model.addBudget(context, widget.lobbyId!);
                  },
                  options: FFButtonOptions(height: 40),
                ),
              ],
            ),
            Flexible(
              fit: FlexFit.loose,
              child: _model.showBudget(),
            ),
          ],
        ),
      ),
    );
  }
}
