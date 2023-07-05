class NavigationState {
  final bool? _unknown;
  final bool? _newTaskPage;
  final String? selectedTaskId;

  bool get isUnknown => _unknown ?? false;

  bool get isNewTaskPage => _newTaskPage ?? false;

  bool get isEditTaskPage => selectedTaskId != null;

  bool get isRoot => !isNewTaskPage && !isUnknown && !isEditTaskPage;


  NavigationState.unknown()
      : _unknown = true,
        selectedTaskId = null,
        _newTaskPage = false;

  NavigationState.newTask()
      : _unknown = false,
        selectedTaskId = null,
        _newTaskPage = true;

  NavigationState.editTask(this.selectedTaskId)
      : _unknown = false,
        _newTaskPage = false;
        
  NavigationState.root()
      : selectedTaskId = null,
        _newTaskPage = false,
        _unknown = false;
}
