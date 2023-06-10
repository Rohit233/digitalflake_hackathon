import 'package:digitalflake_hackathon/models/slot_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/redux/slot_data_redux/actions.dart' as slot_data_actions;

import 'package:digitalflake_hackathon/services/booking_services.dart';
import 'package:digitalflake_hackathon/utils/date_time_utils.dart';
import 'package:flutter/material.dart';
class SlotViewModel{



  //* GET SLOTS BY DATE 
  Future getSlots(BuildContext context,DateTime date) async{
    DateTime dateTime = date;
    List<SlotData> slots = await BookingServices.getSlotsService(context,DateTimeUtils.getFormatedDate(dateTime));
    ReduxStore.slotsStore.dispatch(slot_data_actions.UpdateSlots(slots));
  }
}