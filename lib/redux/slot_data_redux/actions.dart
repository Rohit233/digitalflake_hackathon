//* UPDATE SLOT ACTION 
import 'package:digitalflake_hackathon/models/slot_data.dart';

//* UPDATE SLOTS ACTION 
class UpdateSlots {
  final List<SlotData> payload;
  UpdateSlots(this.payload);
}