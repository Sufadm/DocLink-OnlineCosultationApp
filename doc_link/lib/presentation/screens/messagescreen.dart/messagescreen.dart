import 'package:doc_link/shared/const/const.dart';
import 'package:doc_link/presentation/screens/messagescreen.dart/widgets/messagelist_widget.dart';
import 'package:doc_link/core/search_form.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight10,
              const SearchForm(),
              kHeight15,
              Text(
                'Messages',
                style: kTextStyleLargeBlack,
              ),
              kHeight15,

              const MessageListDoctors(), // Replace with your widget that represents a message
            ],
          ),
        ),
      ),
    );
  }
}
