import 'package:digitalflake_hackathon/models/booking_data.dart';
import 'package:digitalflake_hackathon/redux/booking_history_data_redux/actions.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/services/booking_services.dart';
import 'package:flutter/material.dart';

class BookingHistoryViewModel {

//* GET BOOKING HISTORY

Future getBookingHistory(BuildContext context) async {
  List<BookingData> res =  await BookingServices.getBookingHistoryService(context);
  ReduxStore.bookingHistoryStore.dispatch(UpdateBookingHistory(res));
} 

}