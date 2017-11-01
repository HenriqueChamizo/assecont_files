
using System;
namespace AssecontNovo.Classes
{
    public class Util
    {
        public Util()
        { }

        public string Andress()
        {
            return "@Copyright Assecont Contabilidade Ltda | Telefone comercial: 11 2173 8888 | Horário 08:00 - 12:00 - 13:00 - 17:30";
            //"Rua Mário, 194 | Vila Romana | São Paulo/SP | CEP 05.048-010 | 11 2173-8888 | Horário 08:00-12:00-13:00-17:30";
        }

        public string getAvisos(int aviso, DateTime[] saidas = null, DateTime? saida = null, DateTime? volta = null, int tipo = 0)
        {
            if (aviso == 1)
                return getAvisoBanner(saidas, volta, tipo);
            else if (aviso == 2)
                return getAvisoTecnologia(saidas, volta, tipo);
            else if (aviso == 3)
                return getAvisoContabilidade(saidas, volta);
            else if (aviso == 4)
                return getAvisoFeriado25janeiro();
            else if (aviso == 5)
                return getAvisoCarnaval();
            else
                return "";
        }

        public string getAvisoBanner(DateTime[] saida = null, DateTime? volta = null, int tipo = 0)
        {
            if (tipo == 0)
            {
                return "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
                "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
                "</tr> " +
                "<tr><td><p>Caros clientes,</p> " +

                    "<p>Estamos com problemas em nossos telefones, e infelizmente um fator externo (no caso a EMBRATEL) está comprometendo tanto o recebimento de chamadas como também a execução das mesmas.</p> " +

                    "<p>Por favor, nesse período, o contato pode ser feito via  e-mail: &nbsp; " +
                        "<a class='link' href='http://www.assecont.com.br/Grupo/Atendimento/contato.aspx'>Clique aqui para visualizar contatos</a> " +
                        "<br />ou então no caso dos clientes que utilizam o AssePonto e o Assefin através do acesso remoto pelos links:</p> " +

                    "<p><a id='btnSuporte' class='sitebutton grayDark' href='https://secure.corporate.beanywhere.com/integration/integration2.php?uid=20ea03c4-63cc-11e2-b330-1231392ccdf2|2604'>Acesso remoto para Suporte " +
                        "<img src='../Imagens/16x16/OpenWhite16x16.png' /></a></p> " +

                    "<p><a id='btnImplantacao' class='sitebutton grayDark' href='https://secure.corporate.beanywhere.com/integration/integration2.php?uid=20ea03c4-63cc-11e2-b330-1231392ccdf2|774'>Acesso remoto para Instalação/Implantação " +
                            "<img src='../Imagens/16x16/OpenWhite16x16.png' /></a></p> " +

                    "<p style='text-align: center;'>Agradecemos a compreensão de todos, e estamos aguardando a EMBRATEL solucionar o problema. <br /> Assim que o nosso sistema for restaurado esse aviso irá sumir da página.</p></td> " +
                "</tr></table>";
            }
            else if (tipo == 1)
            {
                string retorno = "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
                "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
                "</tr> " +
                "<tr><td>";

                retorno += "<p>Comunicamos a nossos clientes e Parceiros que não haverá expediente no dia " + 
                    saida[0].ToString("dd") + " de " +
                    EscreveMes(saida[0].Month) + " de " + 
                    saida[0].ToString("yyyy") + ". </p>" +
                    "<p>A equipe volta atender normalmente dia " + 
                    volta.Value.ToString("dd") + " de " + 
                    EscreveMes(volta.Value.Month) + " de " + 
                    volta.Value.ToString("yyyy") + ". </p>" +
                    "<p>Atenciosamente, <br />Grupo Assecont</p></td> " +
                "</tr></table>";

                return retorno;
            }
            else if (tipo == 2)
            {
                string retorno = "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
                "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
                "</tr> " +
                "<tr><td>";

                retorno += "O desafio de " +
                    saida[0].ToString("yyyy") + " está se encerrando, é hora de nos prepararmos para o novo ano, e, com ele, os novos desafios, novas oportunidades e novas conquistas.<br />" +
                    "Informamos que no dia " +
                    saida[0].ToString("dd") + " de " +
                    EscreveMes(saida[0].Month) + " de " +
                    saida[0].ToString("yyyy") + " não teremos expediente. Assim, pedimos que verifiquem suas necessidades e antecipem suas " +
                    "solicitações para que possamos atender-lhes com a capacidade normal até o próximo dia " +
                    (saida[0].Day - 1).ToString() + " deste mês. <br />" +
                    "A equipe de suporte técnico estará atendendo com capacidade reduzida no periodo de ";

                bool controle = true;
                for (int i = 1; i < saida.Length; i++)
                {
                    if (controle)
                    {
                        retorno += saida[i].ToString("dd") + " a " + saida[i + 1].ToString("dd") + " de " + EscreveMes(saida[i].Month) + ", e ";
                        controle = false;
                    }
                    else controle = true;
                }

                retorno = retorno.Substring(0, retorno.Length - 4) + ". " + 
                          "Retornaremos com a capacidade de atendimento normal dia " + volta.Value.ToString("dd") + " de " + 
                          EscreveMes(volta.Value.Month) + " de " + volta.Value.ToString("yyyy") + ".</p>" +
                    "<p>Atenciosamente, <br />Grupo Assecont</p></td> " +
                "</tr></table>";
                return retorno;
            }
            else return "";
        }

        public string getAvisoTecnologia(DateTime[] saidas = null, DateTime? volta = null, int tipo = 0)
        {
            if (tipo == 0)
            {
                #region tipo 0
                string retorno = "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
                "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
                "</tr> " +
                "<tr><td>";

                retorno = "<p>Comunicamos a nossos clientes e Parceiros que não haverá expediente no dia " +
                    saidas[0].ToString("dd") + " de " +
                    EscreveMes(saidas[0].Month) + " de " +
                    saidas[0].ToString("yyyy") + ". </p>" +
                    "<p>A equipe volta atender normalmente dia " +
                    volta.Value.ToString("dd") + " de " +
                    EscreveMes(volta.Value.Month) + " de " +
                    volta.Value.ToString("yyyy") + ". </p>" +

                    "<p>Atenciosamente, <br />Assecont Tecnologia</p></td> " +
                "</tr></table>";
                return retorno;
                #endregion
            }
            else if (tipo == 1)
            {
                #region tipo 1
                string retorno = "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
                "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
                "</tr> " +
                "<tr><td>";

                retorno += "O desafio de " +
                    saidas[0].ToString("yyyy") + " está se encerrando, é hora de nos prepararmos para o novo ano, e, com ele, os novos desafios, novas oportunidades e novas conquistas.<br />" +
                    "Informamos que no dia " +
                    saidas[0].ToString("dd") + " de " +
                    EscreveMes(saidas[0].Month) + " de " +
                    saidas[0].ToString("yyyy") + " não teremos expediente. Assim, pedimos que verifiquem suas necessidades e antecipem suas " +
                    "solicitações para que possamos atender-lhes com a capacidade normal até o próximo dia " +
                    (saidas[0].Day - 1).ToString() + " deste mês. <br />" +
                    "A equipe de suporte técnico estará atendendo com capacidade reduzida no periodo de ";

                bool controle = true;
                for (int i = 1; i < saidas.Length; i++)
                {
                    if (controle)
                    {
                        retorno += saidas[i].ToString("dd") + " a " + saidas[i + 1].ToString("dd") + " de " + EscreveMes(saidas[i].Month) + ", e ";
                        controle = false;
                    }
                    else controle = true;
                }

                retorno = retorno.Substring(0, retorno.Length - 4) + ". " +
                          "Retornaremos com a capacidade de atendimento normal dia " + volta.Value.ToString("dd") + " de " +
                          EscreveMes(volta.Value.Month) + " de " + volta.Value.ToString("yyyy") + ".</p>" +
                    "<p>Atenciosamente, <br />Assecont Tecnologia</p></td> " +
                "</tr></table>";
                return retorno;
                #endregion
            }
            else if (tipo == 3)
            {
                #region tipo 0
                string retorno = "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
                "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
                "</tr> " +
                "<tr><td>";

                retorno = retorno + "<p>Comunicamos a nossos clientes e Parceiros que devido a greve, estamos trabalhando com suporte reduzido" +
                    "<p>Atenciosamente, <br />Assecont Tecnologia</p></td> " +
                "</tr></table>";
                return retorno;
                #endregion
            }
            else return "";
        }

        public string getAvisoContabilidade(DateTime[] saidas = null, DateTime? volta = null, int tipo = 0)
        {
            if (tipo == 0)
            {
                string retorno = "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
                "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
                "</tr> " +
                "<tr><td>";

                retorno = "<p>Comunicamos a nossos clientes e Parceiros que não haverá expediente no dia " +
                    saidas[0].ToString("dd") + " de " +
                    EscreveMes(saidas[0].Month) + " de " +
                    saidas[0].ToString("yyyy") + ". </p>" +
                    "<p>A equipe volta atender normalmente dia " +
                    volta.Value.ToString("dd") + " de " +
                    EscreveMes(volta.Value.Month) + " de " +
                    volta.Value.ToString("yyyy") + ". </p>" +

                    "<p>Atenciosamente, <br />Assecont Contabilidade</p></td> " +
                "</tr></table>";
                return retorno;
            }
            else if (tipo == 1)
            {
                string retorno = "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
                "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
                "</tr> " +
                "<tr><td>";

                retorno += "O desafio de " +
                    saidas[0].ToString("yyyy") + " está se encerrando, é hora de nos prepararmos para o novo ano, e, com ele, os novos desafios, novas oportunidades e novas conquistas.<br />" +
                    "Informamos que no dia " +
                    saidas[0].ToString("dd") + " de " +
                    EscreveMes(saidas[0].Month) + " de " +
                    saidas[0].ToString("yyyy") + " não teremos expediente. Assim, pedimos que verifiquem suas necessidades e antecipem suas " +
                    "solicitações para que possamos atender-lhes com a capacidade normal até o próximo dia " +
                    (saidas[0].Day - 1).ToString() + " deste mês. <br />" +
                    "A equipe de suporte técnico estará atendendo com capacidade reduzida no periodo de ";

                bool controle = true;
                for (int i = 1; i < saidas.Length; i++)
                {
                    if (controle)
                    {
                        retorno += saidas[i].ToString("dd") + " a " + saidas[i + 1].ToString("dd") + " de " + EscreveMes(saidas[i].Month) + ", e ";
                        controle = false;
                    }
                    else controle = true;
                }

                retorno = retorno.Substring(0, retorno.Length - 4) + ". " +
                          "Retornaremos com a capacidade de atendimento normal dia " + volta.Value.ToString("dd") + " de " +
                          EscreveMes(volta.Value.Month) + " de " + volta.Value.ToString("yyyy") + ".</p>" +
                    "<p>Atenciosamente, <br />Assecont Tecnologia</p></td> " +
                "</tr></table>";
                return retorno;
            }
            else return "";
        }

        public string getAvisoFeriado25janeiro()
        {
            return "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
            "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
            "</tr> " +
            "<tr><td>" +

                "<p>Caro usuário, em virtude do feriado em São Paulo (aniversario da cidade), não haverá expediente no dia 25/01/2016.</p>" +

                "<p>Retornaremos ao nosso expediente normal no dia 26/01/2016. </p>" +

                "<p>Gratos pela compreensão</p><p>Grupo Assecont</p></td> " +
            "</tr></table>";
        }

        public string getAvisoCarnaval()
        {
            return "<table style='width: 100%; background: #FCF9ED; padding: 0px 20px 0px 20px; border: 2px solid rgb(176, 73, 73);'> " +
            "<tr> <td style='text-align: center; font-size: 20pt; color: rgb(176, 73, 73);'><img src='../Imagens/Email/aviso/Aviso.png' width='80' />AVISO </td> " +
            "</tr> " +
            "<tr><td>" +

            "<p>Prezado (a),</p> " +
            "<p>Informamos que a ASSECONT, suspenderá as suas atividades nos próximos dias 8 e 9 de fevereiro, segunda e terça-feira, devido ao carnaval.</p>" +
            "<p>O expediente será retomado na quarta-feira (10/2), a partir das 08hs.</p>" +
            "<p>Atenciosamente,</p>" +
            "<p>Assecont</p>" +

            "</td></tr></table>";
        }

        public static string getMesAnoFormat(string Mes, string Ano)
        {
            return Wr.Classes.DateUtils.getMonthName(Convert.ToInt32(Mes)) + " / " + Ano;
        }

        public static string getContentType(string extensao)
        {
            switch (extensao)
            {
                case "pdf": return "application/pdf";
                case "zip": return "application/zip"; 
                case "rar": return "application/x-rar-compressed"; 
                case "docx": return "application/vnd.openxmlformats-officedocument.wordprocessingml.document"; 
                case "doc": return "application/msword"; 
                case "xls": return "application/vnd.ms-excel"; 
                case "xlsx": return "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"; 
                default: return "application/octet-stream"; 
            }
        }

        public string EscreveMes(int mes)
        {
            return System.Globalization.DateTimeFormatInfo.CurrentInfo.GetMonthName(mes);
        }
    }
}