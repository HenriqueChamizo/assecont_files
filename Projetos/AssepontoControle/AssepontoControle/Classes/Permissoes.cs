
using System.Web;
namespace Asseponto.Classes
{
    public class Permissoes
    {
        private BDApp bd;
        private UserApp user;

        public Permissoes(BDApp bd)
        {
            this.bd = bd;
            this.user = new UserApp();
        }

        public void getAcessoResponse(string pagina, HttpResponse Response)
        {
            if (!getAcesso(pagina))
                Response.RedirectPermanent("~/suporte/default.aspx");
        }

        public bool getAcesso(string pagina)
        {
            switch (getStatus())
            {
                case (int)Types.Perfil.administrador:
                    return true;

                case (int)Types.Perfil.gerente:
                    return Gerente(pagina.ToLower());

                case (int)Types.Perfil.comercial:
                    return Comercial(pagina.ToLower());

                case (int)Types.Perfil.implantacao:
                    return Implantacao(pagina.ToLower());

                case (int)Types.Perfil.treinamento:
                    return Treinamento(pagina.ToLower());
            }
            return false;
        }

        public int getStatus()
        {
            return bd.getFieldValueInteger(string.Format("SELECT SUP_PERFIL FROM AssepontoSuporte WHERE SUP_IND = {0}", UserApp.UserId));
        }

        private bool Comercial(string pagina)
        {
            if (pagina == "usuarios" ||
                pagina == "questionarios" || 
                pagina == "agendacliente" ||
                pagina == "questionarios/relatorioatendimento.aspx" ||
                pagina == "questionarios/relatoriotreinamento.aspx" ||
                pagina == "questionarios/relatoriosoftware.aspx" ||
                pagina == "excluirimplantacao" ||
                pagina == "alteracaocnpj")
                return false;
            else
                return true;            
        }

        private bool Implantacao(string pagina)
        {
            if (pagina == "usuarios" || 
                pagina == "relatorios" ||
                pagina == "questionarios" || 
                pagina == "agendacliente" ||
                pagina == "questionarios/relatorioatendimento.aspx" ||
                pagina == "questionarios/relatoriotreinamento.aspx" ||
                pagina == "questionarios/relatoriosoftware.aspx" ||
                pagina == "manutencao" ||
                pagina == "relatoriotreinamento")
                return false;
            else
                return true;
        }

        private bool Treinamento(string pagina)
        {
            if (pagina == "usuarios" ||  
                pagina == "relatorios" || 
                pagina == "questionarios" ||
                pagina == "questionarios/relatorioatendimento.aspx" ||
                pagina == "questionarios/relatoriosoftware.aspx" ||
                pagina == "excluirimplantacao" ||
                pagina == "manutencao" || 
                pagina == "alteracaocnpj" || 
                pagina == "contrato")
                return false;
            else 
            return true;
        }

        private bool Gerente(string pagina)
        {
            //if (pagina == "pesquisa")
              //  return false;
            //else 
                return true;
        }
    }
}