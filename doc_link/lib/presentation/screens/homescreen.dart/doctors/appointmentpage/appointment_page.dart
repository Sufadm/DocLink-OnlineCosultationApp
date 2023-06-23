import 'package:doc_link/const/const.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

import '../../../../../provider/appointmentpage_provider.dart';

class AppointmantPage extends StatelessWidget {
  const AppointmantPage({Key? key}) : super(key: key);

  void _onSelectionChanged(
      BuildContext context, DateRangePickerSelectionChangedArgs args) {
    final model =
        Provider.of<AppointmentScreenStateModel>(context, listen: false);

    if (args.value is PickerDateRange) {
      model.setSelectedDate(
          '${DateFormat('dd/MM/yyyy').format(args.value.startDate)} - ${DateFormat('dd/MM/yyyy').format(args.value.endDate ?? args.value.startDate)}');
    } else if (args.value is DateTime) {
      // Handle DateTime case if needed
    } else if (args.value is List<DateTime>) {
      model.setSelectedDate(args.value.length.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Provider.of<AppointmentScreenStateModel>(context,
                              listen: false)
                          .setSelectedDate(null);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const SizedBox(
                    width: 100,
                  ),
                  Text(
                    'Select Date',
                    style: kTextStyleLargeBlack,
                  ),
                ],
              ),
              Expanded(
                child: SizedBox(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Positioned(
                        left: 0,
                        top: 30,
                        right: 0,
                        bottom: 300,
                        child: SfDateRangePicker(
                          onSelectionChanged: (args) =>
                              _onSelectionChanged(context, args),
                          selectionMode: DateRangePickerSelectionMode.single,
                          initialSelectedRange: PickerDateRange(
                            DateTime.now().subtract(const Duration(days: 4)),
                            DateTime.now().add(const Duration(days: 3)),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        right: 0,
                        bottom: 200,
                        child: Container(
                          alignment: Alignment.center,
                          padding: const EdgeInsets.all(16.0),
                          child: Text(
                            Provider.of<AppointmentScreenStateModel>(context)
                                    .selectedDate ??
                                'No Doctors Available',
                            style: kTextStyleMediumBlack,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
