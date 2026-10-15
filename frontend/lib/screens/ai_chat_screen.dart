import 'package:flutter/material.dart';

import '../services/api_service.dart';
import '../utils/colors.dart';


class AIChatScreen
    extends StatefulWidget {

  const AIChatScreen({
    super.key
  });


  @override
  State<AIChatScreen>
      createState()
      =>
      _AIChatScreenState();

}


class _AIChatScreenState
    extends State<AIChatScreen> {

  final messageController =
      TextEditingController();


  final List<
      Map<String, String>>
      messages = [

    {

      "sender": "ai",

      "message":
          "Hi! I am your FinGuard AI assistant. Ask me about your spending, savings or financial score.",

    }

  ];


  bool waiting = false;


  Future<void>
      sendMessage() async {

    final question =
        messageController.text
            .trim();


    if (
      question.isEmpty ||
      waiting
    ) {

      return;

    }


    messageController.clear();


    setState(() {

      messages.add({

        "sender":
            "user",

        "message":
            question,

      });


      waiting = true;

    });


    final answer =
        await ApiService.askAI(

      userId:
          "user1",

      question:
          question,

    );


    if (!mounted) return;


    setState(() {

      messages.add({

        "sender":
            "ai",

        "message":
            answer,

      });


      waiting = false;

    });

  }


  @override
  void dispose() {

    messageController.dispose();

    super.dispose();

  }


  @override
  Widget build(
      BuildContext context) {

    return Scaffold(

      backgroundColor:
          AppColors.background,


      appBar:
          AppBar(

        title:
            const Text(
          "FinGuard AI",
        ),

        backgroundColor:
            AppColors.primary,

        foregroundColor:
            Colors.white,

      ),


      body:
          Column(

        children: [

          Expanded(

            child:
                ListView.builder(

              padding:
                  const EdgeInsets.all(
                16,
              ),

              itemCount:
                  messages.length,


              itemBuilder:
                  (context,
                      index) {

                final msg =
                    messages[
                        index];


                final isUser =
                    msg[
                        "sender"]
                    == "user";


                return Align(

                  alignment:
                      isUser
                          ? Alignment.centerRight
                          : Alignment.centerLeft,


                  child:
                      Container(

                    constraints:
                        BoxConstraints(

                      maxWidth:
                          MediaQuery.of(
                                    context)
                                .size
                                .width
                          *
                          0.75,

                    ),

                    margin:
                        const EdgeInsets.symmetric(
                      vertical: 6,
                    ),

                    padding:
                        const EdgeInsets.all(
                      14,
                    ),

                    decoration:
                        BoxDecoration(

                      color:
                          isUser
                              ? AppColors.primary
                              : Colors.grey.shade200,

                      borderRadius:
                          BorderRadius.circular(
                        15,
                      ),

                    ),

                    child:
                        Text(

                      msg["message"]
                          ?? "",

                      style:
                          TextStyle(

                        color:
                            isUser
                                ? Colors.white
                                : Colors.black87,

                      ),

                    ),

                  ),

                );

              },

            ),

          ),


          if (waiting)

            const Padding(

              padding:
                  EdgeInsets.all(
                6,
              ),

              child:
                  Text(
                "FinGuard AI is thinking...",
              ),

            ),


          Padding(

            padding:
                const EdgeInsets.all(
              12,
            ),


            child:
                Row(

              children: [

                Expanded(

                  child:
                      TextField(

                    controller:
                        messageController,

                    onSubmitted:
                        (_) =>
                            sendMessage(),

                    decoration:
                        InputDecoration(

                      hintText:
                          "Ask financial advice...",

                      border:
                          OutlineInputBorder(

                        borderRadius:
                            BorderRadius.circular(
                          20,
                        ),

                      ),

                    ),

                  ),

                ),


                const SizedBox(
                  width: 10,
                ),


                CircleAvatar(

                  backgroundColor:
                      AppColors.primary,

                  child:
                      IconButton(

                    onPressed:
                        waiting
                            ? null
                            : sendMessage,

                    icon:
                        const Icon(

                      Icons.send,

                      color:
                          Colors.white,

                    ),

                  ),

                ),

              ],

            ),

          ),

        ],

      ),

    );

  }

}