import 'package:digitalflake_hackathon/models/slot_data.dart';
import 'package:digitalflake_hackathon/redux/slot_data_redux/actions.dart' as slot_actions;

//* SLOT REDUCER 
List<SlotData> slotsReducer(List<SlotData> prevSlots,dynamic action) {
  List<SlotData> newSlots = prevSlots;
  
  if(action is slot_actions.UpdateSlots) {
    newSlots = action.payload;
  }

  return newSlots;
}