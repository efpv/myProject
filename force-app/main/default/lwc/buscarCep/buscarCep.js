import { LightningElement, api } from 'lwc';
import consultarCep from '@salesforce/apex/ConsultaCepFinal.consultarCep';
import atualizarEndereco from '@salesforce/apex/AtualizarEnderecoAccount.atualizarEndereco';

export default class BuscarCep extends LightningElement {
    @api recordId;
    cep = '';

    handleCepChange(event) {
        this.cep = event.target.value.replace(/\D/g, '');
    }

    async buscarEndereco() {
        try {
            const dados = await consultarCep(this.cep);

            const texto =
                `📍 Endereço encontrado:\n\n` +
                `${dados.logradouro}, ${dados.bairro}\n` +
                `${dados.localidade} - ${dados.uf}\n\n` +
                `Deseja salvar este endereço na Account?`;

            const confirmado = window.confirm(texto);

            if (confirmado) {
                const ruaCompleta = `${dados.logradouro}, ${dados.bairro}`;
                await atualizarEndereco(
                    this.recordId,
                    ruaCompleta,
                    dados.localidade,
                    dados.uf,
                    dados.cep
                );

                alert('🏁 Endereço salvo com sucesso!');
            }

        } catch (error) {
            console.error('❌ Erro ao consultar ou salvar endereço:', error);
            alert(error.body?.message || 'Falha ao buscar ou salvar o endereço.');
        }
    }
}