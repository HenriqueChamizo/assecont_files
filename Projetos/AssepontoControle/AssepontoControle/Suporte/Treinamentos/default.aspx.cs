using System;
using Asseponto.Classes;
using Telerik.Web.UI.Calendar.View;
using System.Collections.Generic;
using Telerik.Web.UI;
using System.Drawing;
using System.Data;

namespace Asseponto.Suporte.Treinamentos
{
    public partial class _default : System.Web.UI.Page
    {
        struct Compromisso
        {
            public DateTime dataHora;
            public string descicao;
            public bool realizado;
            public bool cancelado;
            public bool feriado;
            public bool individual;
            public int clientes;
        }

        private BDApp bd;
        private List<Compromisso> listaComp;

        private DateTime startDate;
        private DateTime endDate;

        protected void Page_Load(object sender, EventArgs e)
        {
            bd = new BDApp();
            if(!IsPostBack)
                Utils.Cultura();
        }

        protected override void OnPreRender(EventArgs e)
        {
            base.OnPreRender(e);

            startDate = ((MonthView)RadCalendar1.CalendarView).MonthStartDate;
            endDate = ((MonthView)RadCalendar1.CalendarView).MonthEndDate;
        }

        private void AddSpecialDay(List<RadCalendarDay> SpecialDays, DateTime Date)
        {
            RadCalendarDay specialDay = new RadCalendarDay();
            specialDay.Date = Date;
            specialDay.ItemStyle.BackColor = Color.Red;
            specialDay.ItemStyle.BorderColor = Color.Blue;
            specialDay.ItemStyle.ForeColor = Color.Yellow;
            specialDay.ToolTip = "TEST";
            SpecialDays.Add(specialDay);
        }

        protected void CustomizeDay(object sender, Telerik.Web.UI.Calendar.DayRenderEventArgs e)
        {
            verificarCompromissos();
            verificarFeriado();

            if (listaComp.Count > 0)
            {
                foreach (Compromisso comp in listaComp)
                {
                    DateTime CurrentDate = e.Day.Date;
                    if (startDate <= CurrentDate && CurrentDate <= endDate)
                    {
                        if (CurrentDate.Day == comp.dataHora.Day)
                        {
                            if (!comp.feriado)
                            {
                                e.Cell.Text += "<table class='calendarioComp'><tr><td style='background: transparent !important;' >" + comp.dataHora.ToString("HH:mm") + "<br />" +
                                    comp.descicao.Trim() + "</br>" + (comp.clientes == 0 ? "" : comp.clientes + " Clientes</br>") + "</td><td style='background: " +
                                    (comp.realizado ? "green;" : comp.cancelado ? "blueviolet;" : !comp.individual && comp.clientes < 15 ? "dodgerblue;" : comp.individual && comp.clientes == 0 ? "#FFC961;" : "crimson;") + "width: 5px;'></td></tr></table>";
                            }
                            else
                            {
                                e.Cell.Text += "<table class='calendarioComp'><tr><td style='background: transparent !important;' > Feriado<br /> " + comp.descicao.Trim() + " </td><td style='background: " +
                                               (comp.realizado ? "green;" : comp.cancelado ? "blueviolet;" : "dodgerblue;") + "width: 5px;'></td></tr></table>";
                            }
                        }
                    }
                }
            }
        }

        protected void RadCalendar1_SelectionChanged1(object sender, Telerik.Web.UI.Calendar.SelectedDatesEventArgs e)
        {
            string date = e.SelectedDates.Count - 1 >= 0 ? e.SelectedDates[e.SelectedDates.Count - 1].Date.ToString() : "0";
            Response.Redirect("~/Suporte/Treinamentos/Compromisso.aspx?data=" + date);
        }

        void verificarCompromissos()
        {
            string query = "SELECT AGE_IND, AGE_DATA_HORA,AGE_DESCRICAO, AGE_TREINAMENTO_INDIVIDUAL, AGE_FINALIZADO_POR, AGE_REALIZADO, AGE_CANCELADO, AGE_FERIADO " +
                       ",(SELECT COUNT(AGECLI_IND) FROM AssepontoAgendaClientes WHERE AGECLI_AGENDA = AGE_IND AND AGECLI_PRESENCIAL = 0) AS Clientes " +
                       "FROM AssepontoAgendaTreinamentos WHERE CONVERT(DATE, AGE_DATA_HORA) >= '{0}' AND CONVERT(DATE, AGE_DATA_HORA) <= '{1}'";

            listaComp = new List<Compromisso>();

            DataTable tbCompromisso = bd.getDataTable(string.Format(query, startDate, endDate));

            foreach(DataRow reader in tbCompromisso.Rows)
            {
                Compromisso comp = new Compromisso();
                comp.dataHora = Convert.ToDateTime(reader["AGE_DATA_HORA"].ToString());
                comp.descicao = reader["AGE_DESCRICAO"].ToString();
                comp.feriado = Convert.ToBoolean(reader["AGE_FERIADO"].ToString());
                comp.realizado = Convert.ToBoolean(reader["AGE_REALIZADO"].ToString());
                comp.cancelado = Convert.ToBoolean(reader["AGE_CANCELADO"].ToString());
                comp.clientes = Convert.ToInt32(reader["Clientes"].ToString());
                comp.individual = Convert.ToBoolean(reader["AGE_TREINAMENTO_INDIVIDUAL"].ToString());

                listaComp.Add(comp);
            }
        }

        void verificarFeriado()
        {
            string query = "SELECT FER_DIA, FER_MES, FER_DESCRICAO FROM Feriados " +
                                "WHERE FER_MES >= '{0}' AND FER_MES <= '{1}'";

            DataTable tbFeriados = bd.getDataTable(string.Format(query, startDate.Month, endDate.Month));

            foreach (DataRow reader in tbFeriados.Rows)
            {
                Compromisso comp = new Compromisso();
                int dia = Convert.ToInt32(reader["FER_DIA"].ToString());
                int mes = Convert.ToInt32(reader["FER_MES"].ToString());

                comp.dataHora = Convert.ToDateTime(dia + "/" + mes + "/" + startDate.Year);
                comp.descicao = reader["FER_DESCRICAO"].ToString();
                comp.feriado = true;
                comp.realizado = true;
                comp.cancelado = false;
                comp.clientes = 0;

                listaComp.Add(comp);
            }
        }
    }
}