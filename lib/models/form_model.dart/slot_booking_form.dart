import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/models/slot_data.dart';
import 'package:digitalflake_hackathon/models/workspace_data.dart';

class SlotBookingForm {
  late DateTime date = DateTime.now();
  SlotData? slot;
  WorkspaceData? workspace;
  WorkspaceType? workspaceType;
  SlotBookingForm({
    this.workspaceType
  });
}