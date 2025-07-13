public with sharing class ConsultaCepViaApex {
    @InvocableMethod(label='Consultar CEP ViaCEP para Flow')
    public static List<CepResultadoWrapper> consultarCep(List<CepEntradaWrapper> entradas) {
        List<CepResultadoWrapper> resultados = new List<CepResultadoWrapper>();

        for (CepEntradaWrapper entrada : entradas) {
            CepResultadoWrapper e = new CepResultadoWrapper();

            try {
                Http http = new Http();
                HttpRequest req = new HttpRequest();
                req.setEndpoint('https://viacep.com.br/ws/' + entrada.cep + '/xml/');
                req.setMethod('GET');
                req.setTimeout(5000);

                HttpResponse res = http.send(req);
                if (res.getStatusCode() != 200) { continue; }

                Dom.Document doc = new Dom.Document();
                doc.load(res.getBody());
                Dom.XmlNode root = doc.getRootElement();

                for (Dom.XmlNode node : root.getChildElements()) {
                    String nome = node.getName();
                    String valor = node.getText();

                    if (nome == 'cep')        e.cep        = valor;
                    else if (nome == 'logradouro') e.logradouro = valor;
                    else if (nome == 'bairro')     e.bairro     = valor;
                    else if (nome == 'localidade') e.localidade = valor;
                    else if (nome == 'uf')         e.uf         = valor;
                }

                resultados.add(e);

            } catch (Exception ex) {
                continue;
            }
        }

        return resultados;
    }
}