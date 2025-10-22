import 'dart:math';

class TaskModels {
  // final String taskName;
  // final String description;
  // final bool isHighpriority;
  // final int id;
   String taskName;
   String description;
   bool isHighpriority;
  final int id;
  bool isDone;
  TaskModels( {

    required this.taskName,
    required this.id,
    required this.description,
    required this.isHighpriority,
    this.isDone = false,
  });
  //////////////////////////////////////////////////////////////////////
  factory TaskModels.fromJson(Map<String, dynamic> json) {
    return TaskModels(
      id: json["id"]??Random().nextInt(1000000),
      taskName: json["taskName"] ?? "",
      description: json["description"] ?? "",
      isHighpriority: json["isHighpriority"] ?? false,
      isDone: json["isDone"] ?? false,
    );
  }
  ////////////////////////////////////////////////////
  Map<String, dynamic> toJson() {
    return {
      "taskName": taskName,
      "description": description,
      "isHighpriority": isHighpriority,
      "isDone": isDone,
    };
  }
}
