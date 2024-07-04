

import '../../../models/message.dart';

abstract class ChatStates{}
class IntialeState extends ChatStates {}

class ChatSucsses extends ChatStates{
  List <Message>mesagesList;
  ChatSucsses({required this.mesagesList});
}

