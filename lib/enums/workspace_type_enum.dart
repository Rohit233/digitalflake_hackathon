enum WorkspaceType {
   // ignore: constant_identifier_names
   DESKS,
   // ignore: constant_identifier_names
   MeetingRooms,
}

int getWorkspaceTypeInInt(WorkspaceType workspaceType) {
   if(WorkspaceType.DESKS == workspaceType) {
      return 1; 
   }
   return 2;
}

WorkspaceType getWorkspaceTypeInEnum(int workspaceTypeInInt) {
  if(workspaceTypeInInt == 1) {
    return WorkspaceType.DESKS;
  }
  return WorkspaceType.MeetingRooms;
}