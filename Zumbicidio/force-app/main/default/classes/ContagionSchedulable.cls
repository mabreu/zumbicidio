global class ContagionSchedulable implements Schedulable {
  global void execute(SchedulableContext sc) {
    System.Database.executeBatch(new ContagiarBatchable(), 100);
  }
}
