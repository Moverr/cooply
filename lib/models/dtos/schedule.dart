
class Schedule{
 final  int id;
 final DateTime scheduleDate;
 final  String farm;
 final  String coop;
 final  String type;
 final  DateTime from;
 final  DateTime to;
 final  String priority;
 final  String assignedTo;
 final  TaskStatus status;
 Schedule({ required this.id, required this.scheduleDate,required  this.farm, required this.coop,required  this.type,
   required this.from,required  this.to, required this.priority, required this.assignedTo,required this.status});


}


enum TaskStatus {
 pending,
 finished,
 missed,
 rescheduled,
 skipped
}
