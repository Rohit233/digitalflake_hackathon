import 'package:digitalflake_hackathon/enums/workspace_type_enum.dart';
import 'package:digitalflake_hackathon/models/workspace_data.dart';

//* UPDATE WORKSPACES AVAILABILITY ACTION
class UpdateWorkSpacesAvailability {
  final List<WorkspaceData> payload;
  UpdateWorkSpacesAvailability(this.payload);
} 

//* UPDATE SELECTED WORKSPACE ACTION
class UpdateSelectedWorkspace {
  final WorkspaceType payload;
  UpdateSelectedWorkspace(this.payload);
}