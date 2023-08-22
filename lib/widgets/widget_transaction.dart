import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/models/transaction_model.dart';
import 'package:joiner_1/service/api_service.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import '../flutter_flow/flutter_flow_widgets.dart';

class WidgetTransaction extends StatelessWidget {
  WidgetTransaction(this.transactions, {super.key});
  late final List<TransactionModel> transactions;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: transactions.length,
      separatorBuilder: (context, index) {
        return Divider(
          height: 10,
          thickness: 1.0,
          color: FlutterFlowTheme.of(context).secondaryText,
        );
      },
      itemBuilder: (context, index) {
        return Material(
          child: InkWell(
            onLongPress: () {
              print(transactions[index].toJson());
              // Cancel action
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text('Cancel rental'),
                  content: Text('Are you sure to cancel your rental?'),
                  actions: [
                    TextButton(
                        onPressed: () async {
                          await _cancelTransaction(transactions[index].id!);
                        },
                        child: Text('Yes')),
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text('No'),
                    ),
                  ],
                ),
              );
            },
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: EdgeInsetsDirectional.fromSTEB(10.0, 0.0, 10.0, 0.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          //'Sedan (4-seater)',
                          transactions[index].vehicleType!,
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        Text(
                          // 'July 27, 2023 - 1:03 PM',
                          transactions[index].transactDate.toString(),
                          style:
                              FlutterFlowTheme.of(context).bodyMedium.override(
                                    fontFamily: 'Roboto Flex',
                                    color: FlutterFlowTheme.of(context).accent4,
                                  ),
                        ),
                        Text(
                          transactions[index].status!,
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Text(
                          // '₱1,234.00',
                          '₱${transactions[index].amount}',
                          style: FlutterFlowTheme.of(context).bodyMedium,
                        ),
                        FFButtonWidget(
                          onPressed: () {
                            print('Button pressed ...');
                          },
                          text: 'Details',
                          options: FFButtonOptions(
                            padding: EdgeInsetsDirectional.fromSTEB(
                                8.0, 0.0, 8.0, 0.0),
                            iconPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 0.0),
                            color:
                                FlutterFlowTheme.of(context).primaryBackground,
                            textStyle: FlutterFlowTheme.of(context)
                                .titleSmall
                                .override(
                                  fontFamily: 'Roboto Flex',
                                  color: FlutterFlowTheme.of(context).primary,
                                ),
                            elevation: 0.0,
                            borderSide: BorderSide(
                              color: FlutterFlowTheme.of(context).primary,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                      ].divide(SizedBox(height: 10.0)),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Future _cancelTransaction(String transactionId) {
    final transaction = TransactionModel(id: transactionId);
    return apiService.cancelTransaction(transaction);
  }
}
