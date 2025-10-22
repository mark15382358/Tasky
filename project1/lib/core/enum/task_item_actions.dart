enum TaskItemActions {
  markAsDone("Done|Undone"),
  delete("Delete"),
  edit("Edit");

  final String name;

  const TaskItemActions( this.name);
}
