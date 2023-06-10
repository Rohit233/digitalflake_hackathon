import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/models/booking_data.dart';
import 'package:digitalflake_hackathon/models/slot_data.dart';
import 'package:digitalflake_hackathon/models/workspace_data.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/utils/api_routes.dart';
import 'package:digitalflake_hackathon/utils/services_utils.dart';
import 'package:flutter/material.dart';

class BookingServices {

  //* GET SLOTS SERVICE
  static Future<List<SlotData>> getSlotsService(BuildContext context ,String date) async {
    List<SlotData> slots = [];
    String url = ApiRoutes.getSlotsApiRoute(date);
    Map<String,dynamic> res = await ServicesUtils.sendHttpGetRequest(url, context);
    for(Map<String,dynamic> slot in res['slots']) {
      slots.add(SlotData.getObjectFromJson(slot));
    }
    return slots;
  }


  //* GET WORKSPACE AVAILABILITY SERVICE
  static Future<List<WorkspaceData>> getWorkspaceAvailabilityService(BuildContext context,String date,String slotId,String type) async {
    List<WorkspaceData> workspacesAvailability = [];
    String url = ApiRoutes.getAvailailityApiRoute(date, slotId, type);
    Map<String,dynamic> res = await ServicesUtils.sendHttpGetRequest(url, context);
    for(Map<String,dynamic> workspaceAvailability in res['availability']) {
       workspacesAvailability.add(WorkspaceData.getObjectFromJson(workspaceAvailability));
    }
    return workspacesAvailability;
  }

  //* GET BOOKING HISTORY SERVICE
   static Future<List<BookingData>> getBookingHistoryService(BuildContext context) async {
     List<BookingData> bookingHistory = [];
     String url = ApiRoutes.getBookingsApiRoute(ReduxStore.loggedInUserDataStore.state!.userId.toString());
     Map<String,dynamic> res = await  ServicesUtils.sendHttpGetRequest(url, context);
     for(Map<String,dynamic> booking in res['bookings']) {
       bookingHistory.add(BookingData.getObjectFromJson(booking));
     }
     return bookingHistory;
   }

  //* BOOK WORKSPACE SERVICE
  static Future<String> bookWorkspaceService(BuildContext context,String date,int slotId,int workspcaeId,WorkspaceType type) async {
    var payload = {
      "date": "2023-05-01",
      "slot_id": slotId,
      "workspace_id": workspcaeId,
      "type": getWorkspaceTypeInInt(type)
    };
    String url = ApiRoutes.getConfirmBookingApiRoute();
    Map<String,dynamic> res = await ServicesUtils.sendHttpPostRequest(url, payload, context);
    return res['message'];
  }  
 

}