<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true"
    CodeBehind="Pendencia.aspx.cs" Inherits="Asseponto.Suporte.Atendimento.Pendencia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="PEN_IND" DataSourceID="sqlPendencias"
                OnDataBound="FormView1_DataBound">
                <EditItemTemplate>
                    <table class="formviewtable">
                        <tr>
                            <td>
                                <table class="formviewtableinner">
                                    <tr>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Responsável
                                            </div>
                                            <asp:Label ID="labelResponsavel" runat="server" Text='<%# Eval("SUP_NOME") %>'></asp:Label>
                                            <asp:HiddenField ID="hiddenResponsavel" runat="server" Value='<%# Bind("PEN_RESPONSAVEL1") %>' />
                                            <asp:HiddenField ID="HiddenDataHora" runat="server" Value='<%# Bind("PEN_DATAHORA") %>' />
                                        </td>
                                        <td>
                                            <div class="fieldviewcaption">
                                                Data
                                            </div>
                                            <asp:Label ID="PEN_DATAHORA" runat="server" Text='<%# Eval("PEN_DATAHORA", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Solicitante
                                </div>
                                <asp:TextBox ID="PEN_SOLICITANTE" runat="server" notnull="true" Text='<%# Bind("PEN_SOLICITANTE") %>'></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Problema
                                </div>
                                <asp:TextBox ID="textoProblema" runat="server" Height="170px" TextMode="MultiLine" notnull="true"
                                    Width="700px" Text='<%# Bind("PEN_PROBLEMA") %>' /><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="Panel1" runat="server" Visible='<%# ((FormViewMode)DataBinder.Eval(Container, "CurrentMode") == FormViewMode.Insert) || Eval("PEN_DATAHORASOLUCAO") is DBNull ? false : true %>'>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>
                                                <div class="fieldviewcaption">
                                                    Responsável
                                                </div>
                                                <asp:Label ID="labelResponsavel2" runat="server" Text='<%# Eval("NOME") %>'></asp:Label>
                                            </td>
                                            <td>
                                                <div class="fieldviewcaption">
                                                    Data e Hora da Solução
                                                </div>
                                                <asp:Label ID="TextBox1" runat="server" Text='<%# Eval("PEN_DATAHORASOLUCAO", "{0:dd/MM/yyyy HH:mm}") %>' /><br />
                                            </td>
                                        </tr>
                                    </table>
                                </asp:Panel>
                                <div class="fieldviewcaption">
                                    Solução
                                </div>
                                <asp:TextBox ID="textoSolucao" runat="server" Height="170px" TextMode="MultiLine"
                                    Width="700px" Text='<%# Bind("PEN_SOLUCAO") %>' /><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:CheckBox ID="checkboxEnviarEmail" runat="server" Text="Enviar E-mail" Checked="true" />
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="sqlPendencias" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT PEN_IND, PEN_SOLICITANTE, PEN_DATAHORA, PEN_RESPONSAVEL1, (SELECT SUP_NOME FROM AssepontoSuporte WHERE PEN_RESPONSAVEL2 = SUP_IND) AS NOME, PEN_DATAHORASOLUCAO, SUP_NOME, PEN_SITUACAO,
                PEN_PROBLEMA, PEN_SOLUCAO FROM [AssepontoPendencias] LEFT JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1 WHERE ([PEN_IND] = @PEN_IND)"
                UpdateCommand="UPDATE AssepontoPendencias SET PEN_SOLICITANTE = @PEN_SOLICITANTE, PEN_PROBLEMA = @PEN_PROBLEMA, PEN_SOLUCAO = @PEN_SOLUCAO,
                PEN_DATAHORA = @PEN_DATAHORA, PEN_DATAHORASOLUCAO = @PEN_DATAHORASOLUCAO, PEN_SITUACAO = @PEN_SITUACAO WHERE PEN_IND = @PEN_IND"
                InsertCommand="INSERT INTO AssepontoPendencias (PEN_INDCADASTRO, PEN_RESPONSAVEL1, PEN_RESPONSAVEL2, PEN_SOLICITANTE, PEN_PROBLEMA, PEN_SOLUCAO, PEN_DATAHORA, PEN_DATAHORASOLUCAO, PEN_SITUACAO, PEN_TIPO) 
                VALUES (@PEN_INDCADASTRO, @PEN_RESPONSAVEL1, @PEN_RESPONSAVEL2, @PEN_SOLICITANTE, @PEN_PROBLEMA, @PEN_SOLUCAO, GETDATE(), @PEN_DATAHORASOLUCAO, @PEN_SITUACAO, @PEN_TIPO)"
                OnUpdated="sqlPendencias_Updated" OnUpdating="sqlPendencias_Updating" OnInserting="sqlPendencias_Inserting"
                OnInserted="sqlPendencias_Inserted">
                <DeleteParameters>
                    <asp:QueryStringParameter Name="PEN_IND" QueryStringField="ind" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:QueryStringParameter Name="PEN_IND" QueryStringField="ind" Type="Int32" DefaultValue="0" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="PEN_SOLICITANTE" Type="String" />
                    <asp:Parameter Name="PEN_PROBLEMA" Type="String" Size="-1" />
                    <asp:Parameter Name="PEN_SOLUCAO" Type="String" Size="-1" />
                    <asp:Parameter Name="PEN_DATAHORA" Type="DateTime" />
                    <asp:Parameter Name="PEN_DATAHORASOLUCAO" Type="DateTime" />
                    <asp:Parameter Name="PEN_SITUACAO" Type="Byte" />
                    <asp:QueryStringParameter Name="PEN_IND" QueryStringField="ind" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="PEN_RESPONSAVEL1" Type="Int32" />
                    <asp:Parameter Name="PEN_RESPONSAVEL2" Type="Int32" />
                    <asp:Parameter Name="PEN_SOLICITANTE" Type="String" />
                    <asp:Parameter Name="PEN_PROBLEMA" Type="String" Size="-1" />
                    <asp:Parameter Name="PEN_SOLUCAO" Type="String" Size="-1" />
                    <asp:Parameter Name="PEN_DATAHORA" Type="DateTime" />
                    <asp:Parameter Name="PEN_DATAHORASOLUCAO" Type="DateTime" />
                    <asp:Parameter Name="PEN_SITUACAO" Type="Byte" />
                    <asp:Parameter Name="PEN_TIPO" Type="Byte" />
                    <asp:QueryStringParameter Name="PEN_INDCADASTRO" Type="Int32" QueryStringField="cliente" />
                </InsertParameters>
            </asp:SqlDataSource>
        </div>
        <div class="sitecorpoboxbottom">
            <asp:LinkButton ID="Salvar" runat="server" CssClass="sitebutton" OnClick="Salvar_Click">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Salvar Pendência
            </asp:LinkButton>
        </div>
    </div>
</asp:Content>
