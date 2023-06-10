import 'package:digitalflake_hackathon/models/booking_data.dart';
import 'package:digitalflake_hackathon/redux/booking_history_data_redux/actions.dart';

//* BOOKING HISTORY REDUCER 
List<BookingData> bookingHistoryReducer(List<BookingData> prevBookingData,dynamic action) {
  List<BookingData> newBookingData = prevBookingData;
  if(action is UpdateBookingHistory) {
     newBookingData = action.payload;
  }
  return newBookingData;
}