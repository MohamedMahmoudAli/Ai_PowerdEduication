import 'package:cloud_firestore/cloud_firestore.dart';
import '../../compenets/cashe_helper.dart';
import '../../compenets/constants.dart';
import '../../models/message.dart';
import 'chat_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatCubit extends Cubit<ChatStates> {
  ChatCubit() : super(IntialeState());

  CollectionReference messages =
      FirebaseFirestore.instance.collection(kMessagesCollections);
  List<Message> messageList = [];
  var isAdmin;
  void SendMessage({required String message, required String email,}) {
    CollectionReference data =
    FirebaseFirestore.instance.collection('users');
    data.where("uId", isEqualTo: uid).get().then((value) {
      value.docs.forEach((element) {
         isAdmin = element.get('isAdmin');
      });
    });
    try {
      messages.add(
        {kMessage: message,
          kCreatedAt: DateTime.now(),
          'id': email,
          'name':"${CacheHelper.getData(key: 'name')}"},
      );
    } on Exception catch (e) {
      // TODO
    }
  }

  void getMessages() {
    messages.orderBy(kCreatedAt, descending: true).snapshots().listen((event) {
      messageList.clear();
      for (var doc in event.docs) {
        messageList.add(Message.fromJson(doc));
      }
      emit(ChatSucsses(mesagesList: messageList));
    });
  }
}
