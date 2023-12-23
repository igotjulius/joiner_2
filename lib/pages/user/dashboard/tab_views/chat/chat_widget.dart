import 'package:joiner_1/models/message_model.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'package:flutter/material.dart';
import 'chat_model.dart';

export 'chat_model.dart';

class ChatWidget extends StatefulWidget {
  final String? lobbyId;
  final String? conversationId;
  final Function callback;
  final List<MessageModel> messages;
  const ChatWidget(
      this.callback, this.lobbyId, this.conversationId, this.messages,
      {super.key});

  @override
  _ChatWidgetState createState() => _ChatWidgetState(messages);
}

class _ChatWidgetState extends State<ChatWidget>
    with AutomaticKeepAliveClientMixin {
  _ChatWidgetState(this.messages);
  List<MessageModel> messages;
  late ChatModel _model;

  @override
  bool get wantKeepAlive => true;

  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ChatModel());
    _model.scrollController ??= ScrollController();
    _model.textController ??= TextEditingController();
    _model.streamSocket ??= StreamSocket();
    // _model.initSocket(widget.conversationId!);
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Container(
      padding: EdgeInsets.all(20),
      child: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Column(
          children: [
            Expanded(
              child: mockMessages(),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _model.textController,
                        autofocus: true,
                        style: Theme.of(context).textTheme.bodyMedium,
                        keyboardType: TextInputType.multiline,
                        maxLines: 4,
                        minLines: 1,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor:
                              Theme.of(context).colorScheme.primaryContainer,
                          hintText: 'Enter message..',
                          hintStyle: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                color: Theme.of(context).colorScheme.secondary,
                              ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.transparent,
                      ),
                      onPressed: () {
                        if (_model.textController.text.trim().isNotEmpty) {
                          // _model.sendMessage(widget.conversationId!);
                          setState(() {
                            messages.insert(
                              0,
                              MessageModel(
                                creator: 'John',
                                creatorId: 'user-1',
                                createdAt: DateTime.now(),
                                message: _model.textController.text,
                              ),
                            );
                            _model.textController.text = '';
                          });
                        }
                      },
                      child: Text('SEND'),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget mockMessages() {
    return ListView.separated(
      reverse: true,
      shrinkWrap: true,
      itemCount: messages.length,
      controller: _model.scrollController,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: 10,
        );
      },
      itemBuilder: (context, index) {
        return chatBubble(messages[index]);
      },
    );
  }

  StreamBuilder<MessageModel?> streamSocket() {
    return StreamBuilder(
      stream: _model.streamSocket!.getResponse,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(child: CircularProgressIndicator());

        if (_model.allMessages.isEmpty)
          return Center(
            child: Text('Hi there :)'),
          );

        return ListView.separated(
          reverse: true,
          shrinkWrap: true,
          itemCount: _model.allMessages.length,
          controller: _model.scrollController,
          itemBuilder: (context, index) {
            // final message = _model.allMessages.reversed.toList()[index];
            final message = messages[index];
            print(message.message);
            return chatBubble(message);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 10,
            );
          },
        );
      },
    );
  }

  Widget chatBubble(MessageModel message) {
    bool isUserMessage = message.creatorId == FFAppState().currentUser!.id;
    return Column(
      crossAxisAlignment:
          isUserMessage ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 8, bottom: 2),
          child: Row(
            mainAxisAlignment:
                isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
            children: [
              Text(
                isUserMessage ? '' : message.creator!,
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                DateFormat('jm').format(message.createdAt!),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ),
        Container(
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isUserMessage ? Colors.blue : Color(0xFFDADADA),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            message.message!,
            style:
                TextStyle(color: isUserMessage ? Colors.white : Colors.black),
          ),
        ),
      ],
    );
  }
}
