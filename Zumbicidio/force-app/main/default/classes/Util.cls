public with sharing class Util {
  public Util() {
  }

  public static sObject getRandomItem(List<sObject> items) {
    if (items == null) {
      throw new NullParameterException();
    }

    if (items.size() == 0) {
      throw new EmptyListException();
    }

    return items.get(
      Math.mod(Integer.valueOf(Math.random() * 1000000000), items.size())
    );
  }

  public class EmptyListException extends System.Exception {
  }

  public class NullParameterException extends System.Exception {
  }
}
