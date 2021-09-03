@RestResource(urlMapping='/zumbicidio/humanos/*')
global class GetHumansIS {
  @HttpGet // Notation para dizer que o metodo responde a um Metodo Http Get
  global static HumanosResponse doGet() {
    String recursoParam = RestContext.request.params.get('recurso');
    String bunkerName = RestContext.request.params.get('bunker');
    String sql =
      'SELECT id, Name, Idade__c, Bunker__r.name FROM Criatura__c ' +
      'WHERE RecordType.DeveloperName = \'Humano\'';

    if (!String.isBlank(bunkerName)) {
      if (bunkerName.contains(',')) {
        List<String> bunkers = bunkerName.split(',');
        sql += ' AND bunker__r.name IN :bunkers';
      } else {
        sql += ' AND bunker__r.name = :bunkerName';
      }
    }

    List<Criatura__c> criaturas = Database.query(sql);
    HumanosResponse humanos = new HumanosResponse();

    for (Criatura__c cri : criaturas) {
      Humano hum = new Humano(cri.name, cri.idade__c, cri.bunker__r.name);
      humanos.add(hum);
    }

    return humanos;
  }

  global class HumanosResponse { // A inner class tb tem de ser global
    public List<Humano> humanos;
    public Integer total;

    public HumanosResponse() {
      this.humanos = new List<Humano>();
      this.total = 0;
    }

    public HumanosResponse add(Humano humano) {
      humanos.add(humano);
      this.total++;
      return this;
    }
  }

  global class Humano {
    public String nome;
    public Decimal idade;
    public Bunker bunker;

    public Humano(String nome, Decimal idade, String bunker_name) {
      this.nome = nome;
      this.idade = idade;
      this.bunker = new Bunker(bunker_name);
    }
  }

  global class Bunker {
    public String nome;

    public Bunker(String nome) {
      this.nome = nome;
    }
  }
}
