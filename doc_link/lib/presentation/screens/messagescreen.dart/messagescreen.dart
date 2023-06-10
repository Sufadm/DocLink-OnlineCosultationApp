import 'package:doc_link/const/const.dart';
import 'package:doc_link/presentation/screens/messagescreen.dart/widgets/messagelist_widget.dart';
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
              const SearchBar(
                hintText: 'Search a Doctor',
              ),
              kHeight15,
              Text(
                'Messages',
                style: kTextStyleLargeBlack,
              ),
              kHeight15,
              Expanded(
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(height: 10),
                  itemCount: 5, // Replace with the actual item count
                  itemBuilder: (BuildContext context, int index) {
                    return const MessageListDoctors(); // Replace with your widget that represents a message
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
