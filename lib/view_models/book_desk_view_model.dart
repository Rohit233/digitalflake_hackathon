import 'package:digitalflake_hackathon/enums/snackbar_type_enum.dart';
import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/models/form_model.dart/slot_booking_form.dart';
import 'package:digitalflake_hackathon/models/slot_data.dart';
import 'package:digitalflake_hackathon/models/workspace_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/redux/workspace_data_redux/actions.dart';
import 'package:digitalflake_hackathon/services/booking_services.dart';
import 'package:digitalflake_hackathon/utils/basic_utils.dart';
import 'package:digitalflake_hackathon/utils/date_time_utils.dart';
import 'package:flutter/material.dart';

class BookDeskViewModel {
  
  //* GET WORKSPACE
  Future getAvailableWorkspaces(BuildContext context,WorkspaceType workspaceType,SlotData slotData,DateTime dateTime) async {
    String date = DateTimeUtils.getFormatedDate(dateTime);
    String slotId = slotData.slotId.toString();
    String type = getWorkspaceTypeInInt(workspaceType).toString();
    List<WorkspaceData> workspaces = await BookingServices.getWorkspaceAvailabilityService(context, date, slotId, type);
    ReduxStore.workspacesAvailibilityStore.dispatch(UpdateWorkSpacesAvailability(workspaces));
  } 

  //* CONFIRM BOOKING
  Future confirmBooking(BuildContext context,SlotBookingForm form) async {
    String dateTime = DateTimeUtils.getFormatedDate(form.date);
    int slotId = form.slot!.slotId;
    int workspaceId = form.workspace!.workspaceId;
    String message = await BookingServices.bookWorkspaceService(context, dateTime, slotId, workspaceId, form.workspaceType!);
    // ignore: use_build_context_synchronously
    BasicUtils.showSnackBar(context, message, SnackBarType.SUCCESS);
  } 

}