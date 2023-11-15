import 'package:flutter/material.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_util.dart';
import 'package:joiner_1/flutter_flow/flutter_flow_widgets.dart';
import 'package:joiner_1/models/lobby_model.dart';

class WidgetTripDetails extends StatefulWidget {
  final LobbyModel currentLobby;
  const WidgetTripDetails({super.key, required this.currentLobby});

  @override
  State<WidgetTripDetails> createState() => _WidgetTripDetailsState();
}

class _WidgetTripDetailsState extends State<WidgetTripDetails> {
  TextEditingController? _titleController;
  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              autofocus: true,
              obscureText: false,
              decoration: InputDecoration(
                labelText: 'Title',
                hintText: widget.currentLobby.title,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                errorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedErrorBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    width: 2.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
            FFButtonWidget(
              onPressed: () async {
                // final updatedLobby = LobbyModel(
                //   id: widget.currentLobby.id,
                //   title: _titleController.text,
                // );
                // await apiService.updateLobby(updatedLobby);
              },
              text: 'Save',
              options: FFButtonOptions(
                height: 40.0,
                padding: EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                iconPadding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                elevation: 3.0,
                borderSide: BorderSide(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
          ].divide(SizedBox(
            height: 10,
          )),
        ),
      ),
    );
  }
}
