class WorkspaceData {
  late String workspaceName;
  late int workspaceId;
  late bool workspaceActive;

  WorkspaceData({
    required this.workspaceActive,
    required this.workspaceId,
    required this.workspaceName,
  });

  static WorkspaceData getObjectFromJson (Map<String,dynamic> jsonData) {
    return WorkspaceData(
      workspaceActive: jsonData['workspace_active'],
      workspaceId: jsonData['workspace_id'], 
      workspaceName: jsonData['workspace_name']);
  }
}