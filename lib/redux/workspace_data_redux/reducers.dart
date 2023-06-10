import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/models/workspace_data.dart';
import 'package:digitalflake_hackathon/redux/workspace_data_redux/actions.dart' as workspace_actions;

//* WORKSPACE AVAILABILITY REDUCER 
List<WorkspaceData> workspaceAvailabilityReducer (List<WorkspaceData> prevWorkSpacesData, dynamic action) {
  List<WorkspaceData> newWorkspacesData = prevWorkSpacesData;

  if(action is workspace_actions.UpdateWorkSpacesAvailability) {
     newWorkspacesData = action.payload;
  }

  return newWorkspacesData;
}

//* WORKSPACE SELECTOR REDUCER 
WorkspaceType workspaceSelectorReducer(WorkspaceType prevWorkspaceType,dynamic action) {
  WorkspaceType newWorkspaceType = prevWorkspaceType;
  if(action is workspace_actions.UpdateSelectedWorkspace) {
     newWorkspaceType = action.payload;
  }
  return newWorkspaceType;
}