import 'dart:async';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/service/api_service.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatModel extends FlutterFlowModel {
  ///  State fields for stateful widgets in this component.
  IO.Socket? socket;
  ScrollController? scrollController;

  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;
  List<MessageModel> allMessages = [];
  StreamSocket? streamSocket;

  /// Initialization and disposal methods.
  @override
  void initState(BuildContext context) {}

  void initSocket(String conversationId) {
    socket = IO.io(serverUrl + 'chats', <String, dynamic>{
      'autoConnect': false,
      'reconnection': false,
      'transports': ['websocket'],
      'query': {'conversationId': conversationId},
    });

    socket!.connect();
    socket!.onConnect((_) {
      print('Connection established.');
    });

    socket!.on('joinChat', (data) {
      data = data as List;
      print('data received');

      if (data.isNotEmpty) {
        data.forEach((json) {
          final message = MessageModel.fromJson(json);
          allMessages.add(message);
          streamSocket!._socketResponse.add(message);
        });
      } else {
        streamSocket!.addResponse(null);
      }
    });

    socket!.on('messageEvent', (json) {
      final message = MessageModel.fromJson(json);
      allMessages.add(message);
      streamSocket!._socketResponse.add(message);
      if (scrollController!.hasClients) {
        scrollController!.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
    // Leave lobby on disconnect
    socket!.onDisconnect((data) => print('disconnect'));
  }

  @override
  void dispose() {
    socket?.dispose();
    scrollController?.dispose();
    textController?.dispose();
  }

  /// Action blocks are added here.
  void sendMessage(String conversationId) {
    final message = textController.text.trim();
    if (message.isEmpty) return;
    final currentUser = FFAppState().currentUser!;

    final nMessage = MessageModel(
      creatorId: currentUser.id,
      creator: currentUser.firstName,
      message: message,
    );
    // socket!.
    socket!.emit('messageEvent', nMessage);
  }

  /// Additional helper methods are added here.
}

// STEP1:  Stream setup
class StreamSocket {
  final _socketResponse = StreamController<MessageModel?>();

  void Function(MessageModel?) get addResponse => _socketResponse.sink.add;

  Stream<MessageModel?> get getResponse => _socketResponse.stream;

  void dispose() {
    _socketResponse.close();
  }
}
