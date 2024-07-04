import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hieroglyphic_app/compenets/constant/colors.dart';
import '../../compenets/cashe_helper.dart';
import '../../compenets/constants.dart';
import '../../widgets/chat_bubble.dart';
import '../../widgets/chat_bubble_for_friend.dart';
import 'chat_cubit.dart';
import 'chat_state.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ChatPage extends StatefulWidget {
  static String id = 'ChatPage';

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    BlocProvider.of<ChatCubit>(context).getMessages();

  }

  final _controller = ScrollController();

  CollectionReference messages =
  FirebaseFirestore.instance.collection(kMessagesCollections);

  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var email  = CacheHelper.getData(key: 'name');
    var messagesList=[];
    return Scaffold(

      body: Column(
        children: [
          Expanded(
            child: BlocConsumer<ChatCubit,ChatStates>(
              builder:(context,state) {
                var messagesList=BlocProvider.of<ChatCubit>(context).messageList;
                return ListView.builder(
                    reverse: true,
                    controller: _controller,
                    itemCount: messagesList.length,
                    itemBuilder: (context, index) {
                      return messagesList[index].id == email ?

                      ChatBubble(
                        message: messagesList[index],
                      ) : ChatBubleForFriend(message: messagesList[index]);
                    });
              },
              listener: (context,state){
                if(state is ChatSucsses){
                  messagesList=state.mesagesList;
                }
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16,right: 16,top: 5,bottom: 45),
            child: TextField(
              controller: controller,
              onSubmitted: (data) {
                BlocProvider.of<ChatCubit>(context).
                SendMessage(message: data, email: email.toString());
                controller.clear();
                _controller.animateTo(0,
                    duration: Duration(milliseconds: 500),
                    curve: Curves.easeIn);
              },
              decoration: InputDecoration(
                hintText: AppLocalizations.of(context)!.sendMessage,
                hintStyle: TextStyle(
                  color: AppColor.primaryColor
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    BlocProvider.of<ChatCubit>(context).
                    SendMessage(message: controller.text, email: email.toString());
                    controller.clear();
                    FocusScope.of(context).unfocus();

                  },
                  child: Icon(
                    Icons.send,
                    color: AppColor.primaryColor,
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: AppColor.primaryColor,
                  ),
                ),
              ),
            ),
          ),

        ],
      ),
    );
    }
}