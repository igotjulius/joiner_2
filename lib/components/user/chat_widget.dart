import 'package:joiner_1/controllers/user_controller.dart';
import 'package:joiner_1/models/message_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/flutter_flow_widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_model.dart';

export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  final String? lobbyId;
  final String? conversationId;
  final Function callback;
  // final String? userId;
  const ChatWidget(this.callback, this.lobbyId, this.conversationId, {Key? key})
      : super(key: key);

  @override
  _ChatWidgetState createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late ChatModel _model;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());

    _model.textController ??= TextEditingController();
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appState = context.watch<FFAppState>();
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(children: [
        Expanded(
            child: UserController.getConversation(appState.currentUser!.id!,
                widget.lobbyId!, widget.conversationId!)),
        Material(
          color: Colors.transparent,
          elevation: 0.0,
          child: Container(
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 8.0,
                  color: Color(0x33000000),
                  offset: Offset(0.0, 0.0),
                  spreadRadius: 2.0,
                )
              ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.max,
              children: [
                Expanded(
                  child: Padding(
                    padding:
                        EdgeInsetsDirectional.fromSTEB(10.0, 10.0, 10.0, 10.0),
                    child: Container(
                      width: 100.0,
                      height: 100.0,
                      decoration: BoxDecoration(
                        color: Color(0xFFDADADA),
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(
                            20.0, 0.0, 20.0, 0.0),
                        child: TextFormField(
                          controller: _model.textController,
                          autofocus: true,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter message..',
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            errorBorder: InputBorder.none,
                            focusedErrorBorder: InputBorder.none,
                            contentPadding: EdgeInsetsDirectional.fromSTEB(
                                0.0, 0.0, 0.0, 10.0),
                          ),
                          validator: _model.textControllerValidator
                              .asValidator(context),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 10.0, 0.0),
                  child: FFButtonWidget(
                    onPressed: () async {
                      String mssg = _model.textController.text.trim();
                      if (mssg.isNotEmpty) {
                        final message = MessageModel(
                          creatorId: appState.currentUser!.id,
                          creator: appState.currentUser!.firstName,
                          message: mssg,
                        );
                        await UserController.createMessage(
                            message,
                            context,
                            appState.currentUser!.id!,
                            widget.lobbyId!,
                            widget.conversationId!);
                        widget.callback(() {});
                        _model.textController!.clear();
                      } else
                        print(appState.currentUser!.id);
                    },
                    text: 'SEND',
                    options: FFButtonOptions(
                      height: 40.0,
                      padding:
                          EdgeInsetsDirectional.fromSTEB(24.0, 0.0, 24.0, 0.0),
                      iconPadding:
                          EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                      elevation: 3.0,
                      borderSide: BorderSide(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ]),
    );
  }
}
