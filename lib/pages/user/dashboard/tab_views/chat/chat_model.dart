import 'dart:async';
import 'package:joiner_1/models/helpers/user.dart';
import 'package:joiner_1/models/message_model.dart';
import 'package:joiner_1/service/api_service.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatModel {
  ChatModel(String conversationId) {
    initSocket(conversationId);
  }
  late IO.Socket socket;
  StreamSocket streamSocket = StreamSocket();
  ScrollController scrollController = ScrollController();
  TextEditingController textController = TextEditingController();
  List<MessageModel> allMessages = [];

  void initSocket(String conversationId) {
    socket = IO.io(serverUrl + 'chats', <String, dynamic>{
      'autoConnect': false,
      'reconnection': false,
      'transports': ['websocket'],
      'query': {'conversationId': conversationId},
    });

    socket.connect();
    socket.onConnect((_) {
      print('Connection established.');
    });

    socket.on('joinChat', (data) {
      data = data as List;
      print('data received');

      if (data.isNotEmpty) {
        data.forEach((json) {
          final message = MessageModel.fromJson(json);
          allMessages.add(message);
          streamSocket.socketResponse.add(message);
        });
      } else {
        streamSocket.addResponse(null);
      }
    });

    socket.on('messageEvent', (json) {
      final message = MessageModel.fromJson(json);
      allMessages.add(message);
      streamSocket.socketResponse.add(message);
      if (scrollController.hasClients) {
        scrollController.animateTo(
          0.0,
          curve: Curves.easeOut,
          duration: const Duration(milliseconds: 500),
        );
      }
    });
    // Leave lobby on disconnect
    socket.onDisconnect((data) => print('disconnect'));
  }

  void dispose() {
    socket.dispose();
    scrollController.dispose();
    textController.dispose();
  }

  /// Action blocks are added here.
  void sendMessage(String conversationId, User currentUser) {
    final message = textController.text.trim();
    if (message.isEmpty) return;

    final nMessage = MessageModel(
      creatorId: currentUser.id,
      creator: currentUser.firstName,
      message: message,
    );
    // socket!.
    socket.emit('messageEvent', nMessage);
  }
}

// STEP1:  Stream setup
class StreamSocket {
  final socketResponse = StreamController<MessageModel?>();

  void Function(MessageModel?) get addResponse => socketResponse.sink.add;

  Stream<MessageModel?> get getResponse => socketResponse.stream;

  void dispose() {
    socketResponse.close();
  }
}
