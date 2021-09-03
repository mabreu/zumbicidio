public class CalloutToSalesForce {
  public static final String clientId = '3MVG9cHH2bfKACZbw4FIJzzLXnHIegCG.vdQKV4F68gKpiJKGcOksSLSyuePs1f95X5S2NfF6_T4Bn4bslk2z';
  public static final String clientSecret = '1C1F23E8F6C03CA16A4386E53A15D21CC76E5D0B59C163FBF3093A07FFBB1B5B';
  public static final String userName = 'integration@00d5e000002hhkveao.com';
  public static final String password = 'Bootcamp4';
  public static final String url = 'https://login.salesforce.com/services/oauth2/token';
  public static final String endPoint = '/services/apexrest/marvel/availableheroes';

  public static String access_token = '';
  public static String instance_url = '';

  public static Boolean getAuth() {
    try {
      HttpRequest req = new HttpRequest();
      req.setHeader('Content-Type', 'application/x-www-form-urlencoded');
      req.setMethod('POST');
      req.setEndpoint(url);
      String body =
        'grant_type=password' +
        '&client_id=' +
        clientId +
        '&client_secret=' +
        clientSecret +
        '&username=' +
        userName +
        '&password=' +
        password;
      req.setBody(body);

      Http http = new Http();
      HttpResponse response = http.send(req);
      System.debug('response: ' + response);

      if (response.getStatusCode() == 200) {
        Map<String, Object> resMap = (Map<String, Object>) JSON.deserializeUntyped(
          response.getBody()
        );
        access_token = (String) resMap.get('access_token');
        instance_url = (String) resMap.get('instance_url');
        System.debug('access_token: ' + access_token);
        System.debug('instance_url: ' + instance_url);
      } else {
        System.debug('Deu erro: ' + response.getStatus());
      }
    } catch (Exception e) {
      System.debug('Error: ' + e.getMessage());
      return false;
    }

    return true;
  }

  @AuraEnabled(
    cacheable=true
  ) // Só o que vai ser chamado precisa do AuraEnabled
  public static ResponseHerois getHeroisBootcamp3() {
    ResponseHerois herois = null;

    try {
      if (getAuth()) {
        if (!String.isBlank(access_token)) {
          HttpRequest req = new HttpRequest();
          req.setMethod('GET');
          req.setEndpoint(instance_url + endPoint);
          req.setHeader('Authorization', 'Bearer ' + access_token);

          Http http = new Http();
          HttpResponse response = http.send(req);
          System.debug('Response:' + response.getBody());

          if (response.getStatusCode() == 200) {
            herois = (ResponseHerois) JSON.deserialize(
              response.getBody(),
              ResponseHerois.class
            );
            System.debug('Herois: ' + herois);
          } else {
            System.debug('Deu erro: ' + response.getStatus());
          }
        }
      }
    } catch (Exception e) {
      System.debug('Error: ' + e.getMessage());
    }

    return herois;
  }

  public class ResponseHerois {
    @AuraEnabled
    public List<Heroi> herois;

    @AuraEnabled
    public Integer total;

    public ResponseHerois() {
      this.herois = new List<Heroi>();
      this.total = 0;
    }

    public ResponseHerois add(Heroi heroi) {
      herois.add(heroi);
      this.total++;
      return this;
    }
  }

  public class Heroi {
    @AuraEnabled
    public String nome;

    @AuraEnabled
    public String nivel;

    @AuraEnabled
    public List<Habilidade> habilidades;

    @AuraEnabled
    public Integer total;

    public Heroi(String nome, String nivel) {
      this.nome = nome;
      this.nivel = nivel;
      this.habilidades = new List<Habilidade>();
      this.total = 0;
    }

    public Heroi add(Habilidade habilidade) {
      this.habilidades.add(habilidade);
      this.total++;
      return this;
    }
  }

  public class Habilidade {
    @AuraEnabled
    public String nome;

    @AuraEnabled
    public String nivel;

    public Habilidade(String nome, String nivel) {
      this.nome = nome;
      this.nivel = nivel;
    }
  }
}
