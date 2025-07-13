# 🚀 ConsultaCEP — Atualização de Endereço via Flow + Apex no Salesforce

Este projeto implementa uma automação inteligente no Salesforce que permite consultar um endereço brasileiro via CEP usando a API ViaCEP, e atualizar os campos do registro de Account com os dados encontrados.

---

## 🧩 Funcionalidades

- 🔍 Entrada de CEP via Flow
- ⚙️ Consulta de endereço com Apex (`ConsultaCepViaApex`)
- 🧠 Atualização da Account com:
  - `BillingStreet`, `BillingCity`, `BillingState`, `BillingPostalCode`, `BillingCountry`
  - Campos customizados: `BillingNumber__c`, `BillingComplement__c`
- 💡 Interface amigável com telas interativas

---

## 📂 Estrutura
MYPROJECT/
└── force-app/
    └── main/
        └── default/
            ├── classes/              # Classes Apex invocáveis e wrappers
            ├── flexipages/           # Página personalizada da Account
            ├── flows/                # Flow ConsultaCep
            └── objects/              # Campos customizados da Account