import 'package:joiner_1/widgets/atoms/budget_category.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'budget_allocation_model.dart';
export 'budget_allocation_model.dart';

class BudgetAllocationWidget extends StatefulWidget {
  final Map<String, double>? budgetCategories;
  const BudgetAllocationWidget({Key? key, this.budgetCategories})
      : super(key: key);

  @override
  _BudgetAllocationWidgetState createState() => _BudgetAllocationWidgetState();
}

class _BudgetAllocationWidgetState extends State<BudgetAllocationWidget> {
  late BudgetAllocationModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BudgetAllocationModel());
    _model.keys = widget.budgetCategories!.keys.toList();
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
      height: double.infinity,
      decoration: BoxDecoration(
        color: FlutterFlowTheme.of(context).secondaryBackground,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(0.0),
          bottomRight: Radius.circular(0.0),
          topLeft: Radius.circular(20.0),
          topRight: Radius.circular(20.0),
        ),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsetsDirectional.fromSTEB(20.0, 20.0, 20.0, 20.0),
              child: Container(
                decoration: BoxDecoration(
                  color: FlutterFlowTheme.of(context).secondaryBackground,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(
                    color: FlutterFlowTheme.of(context).accent3,
                    width: 1.0,
                  ),
                ),
                child: ListView.builder(
                  itemCount: _model.keys!.length,
                  itemBuilder: (context, index) {
                    return BudgetCategoryWidget(
                      label: _model.keys?[index],
                      amount: widget.budgetCategories?[_model.keys?[index]],
                      prefixIcon: Icons.money,
                      suffixIcon: Icons.wallet,
                    );
                  },
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () {
                print('Button pressed ...');
              },
              text: 'Add expenses',
              icon: Icon(
                Icons.add,
                size: 24.0,
              ),
              options: FFButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                color: FlutterFlowTheme.of(context).primary,
                textStyle: FlutterFlowTheme.of(context).titleSmall.override(
                      fontFamily: 'Roboto Flex',
                      color: Colors.white,
                    ),
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
