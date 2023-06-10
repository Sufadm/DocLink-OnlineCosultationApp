import 'package:flutter/material.dart';

import '../../../../../const/const.dart';
import '../../../../../widgets/elevated_button_widgets.dart';

class NotificationListDetailsWidget extends StatelessWidget {
  const NotificationListDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: const Color.fromARGB(255, 161, 184, 162),
          borderRadius: BorderRadius.circular(10)),
      height: 170,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [Text('Date'), Text('Time'), Text('Doctor')],
          ),
          kHeight10,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Date',
                style: kTextStyleMediumBlack,
              ),
              Text(
                '2.20pm',
                style: kTextStyleMediumBlack,
              ),
              Text(
                'Sufad M',
                style: kTextStyleMediumBlack,
              )
            ],
          ),
          kHeight10,
          const Divider(
            color: Colors.black,
            thickness: 1,
          ),
          const Row(
            children: [
              Text('Categorie'),
              SizedBox(
                width: 100,
              ),
              Text('Place')
            ],
          ),
          Row(
            children: [
              Text(
                'Dentist',
                style: kTextStyleMediumBlack,
              ),
              const SizedBox(
                width: 100,
              ),
              Text(
                'Thalassery',
                style: kTextStyleMediumBlack,
              ),
              const SizedBox(
                width: 60,
              ),
              SizedBox(
                  width: 80,
                  child: ElevatedButtons(text: 'Cancel', onPressed: () {}))
            ],
          )
        ]),
      ),
    );
  }
}
