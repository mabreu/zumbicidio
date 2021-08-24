public with sharing class Util {
  public Util() {
  }

  public static sObject getRandomItem(List<sObject> items) {
    return items.get(
      Math.mod(Integer.valueOf(Math.random() * 1000000000), items.size())
    );
  }
}
