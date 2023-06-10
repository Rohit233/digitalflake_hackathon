import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/redux/redux_store.dart';
import 'package:digitalflake_hackathon/redux/workspace_data_redux/actions.dart';

class HomeViewModel {

  //* CHANGE WORKSPACE
  changeWorkspace(WorkspaceType type) {
      ReduxStore.selectedWorkSpaceStore.dispatch(UpdateSelectedWorkspace(type));
  } 
}