<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="SenhaControl.ascx.cs" Inherits="Asseponto.WebControls.SenhaControl" %>

<div runat="server" id="senhacontrolwrapper">
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="NSE_IND" DefaultMode="Insert" OnDataBound="FormView1_DataBound" DataSourceID="sqlAssepontoNSeries">
        <EditItemTemplate>
            <div class="sitecorpoboxcaixa">
                <table>
                    <tr>
                        <td style="padding: 10px 0px 10px 5px;">
                            Versão</br>
                            <telerik:RadComboBox ID="comboboxVersao" runat="server" DataSourceID="sqlAssepontoVersoes" notnull="true" 
                                DataTextField="VER_NOME" DataValueField="VER_COD" SelectedValue='<%# Bind("P_VERSAO") %>'
                                Skin="flv" Width="170px" EnableEmbeddedSkins="false" EmptyMessage="Selecione a Versão">
                            </telerik:RadComboBox>
                        </td>
                        <td style="padding: 10px 0px 10px 5px;">
                            Número de Série</br>
                            <asp:TextBox ID="NSE_NS" runat="server" Text='<%# Bind("P_SERIAL") %>' Width="180px" notnull="true" />
                        </td>
                        <td style="padding: 26px 6px 10px 5px;">
                            <asp:Button ID="Salvar" runat="server" Text="Gerar Contra-Senha"  CssClass="sitebutton blue" CommandName="Insert" />
                        </td>
                    </tr>
                </table>
            </div>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sqlAssepontoNSeries" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        InsertCommand="asseponto_pass" InsertCommandType="StoredProcedure" OnInserted="sqlAssepontoNSeries_Inserted"
        OnInserting="sqlAssepontoNSeries_Inserting">
        <InsertParameters>
            <asp:Parameter Name="P_SERIAL"/>
            <asp:Parameter Name="P_VERSAO"/>
            <asp:Parameter Name="P_SUPORTE"/>
            <asp:Parameter Name="P_CLIENTE"/>
            <asp:Parameter Name="R_SENHA" Direction="Output" Size="30" />
        </InsertParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="sqlAssepontoVersoes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT [VER_COD], [VER_NOME] FROM [AssepontoVersoes] WHERE VER_ATIVO = 1 ORDER BY VER_COD">
    </asp:SqlDataSource>
</div>
