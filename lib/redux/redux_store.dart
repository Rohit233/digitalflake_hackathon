import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/models/booking_data.dart';
import 'package:digitalflake_hackathon/models/slot_data.dart';
import 'package:digitalflake_hackathon/models/user_data.dart';
import 'package:digitalflake_hackathon/models/workspace_data.dart';
import 'package:digitalflake_hackathon/redux/booking_history_data_redux/reducer.dart';
import 'package:digitalflake_hackathon/redux/slot_data_redux/reducer.dart';
import 'package:digitalflake_hackathon/redux/user_data_redux/reducers.dart';
import 'package:digitalflake_hackathon/redux/workspace_data_redux/reducers.dart';
import 'package:redux/redux.dart';

class ReduxStore {
  static late Store<List<SlotData>> slotsStore;
  static late Store<List<WorkspaceData>> workspacesAvailibilityStore;
  static late Store<UserData?> loggedInUserDataStore;
  static late Store<List<BookingData>> bookingHistoryStore;
  static late Store<WorkspaceType> selectedWorkSpaceStore;
  static initialize() {
    slotsStore = Store(slotsReducer, initialState: []);
    workspacesAvailibilityStore = Store(workspaceAvailabilityReducer, initialState: []);
    loggedInUserDataStore = Store(loggedInUserDataReducer,initialState: null);
    bookingHistoryStore = Store(bookingHistoryReducer,initialState: []);
    selectedWorkSpaceStore = Store(workspaceSelectorReducer,initialState: WorkspaceType.DESKS);
  }
}