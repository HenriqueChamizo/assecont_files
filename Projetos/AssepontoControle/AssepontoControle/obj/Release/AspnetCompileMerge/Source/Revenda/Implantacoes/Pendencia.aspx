<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true"
    CodeBehind="Pendencia.aspx.cs" Inherits="Asseponto.Revenda.Implantacoes.Pendencia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="PEN_IND" DataSourceID="sqlPendencias" DefaultMode="Edit"
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
                                <asp:Label ID="PEN_SOLICITANTE" runat="server" Text='<%# Eval("PEN_SOLICITANTE") %>' />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Descrição
                                </div>
                                <asp:Label ID="textoProblema" runat="server" Text='<%# Eval("PEN_PROBLEMA") %>' /><br />
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Panel ID="Panel1" runat="server" Visible='<%# ((FormViewMode)DataBinder.Eval(Container, "CurrentMode") == FormViewMode.Insert) || Eval("PEN_DATAHORASOLUCAO") is DBNull ? false : true %>'>
                                    <table class="formviewtableinner">
                                        <tr>
                                            <td>
                                                <div class="fieldviewcaption">
                                                    Responsável 2
                                                </div>
                                                <asp:Label ID="labelResponsavel2" runat="server" Text='<%# Eval("NOME") %>'></asp:Label>
                                                <br />
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
                                <asp:Panel runat="server" Visible='<%# string.IsNullOrEmpty(Eval("PEN_SOLUCAO").ToString()) ? false : true %>'>
                                    <div class="fieldviewcaption">
                                        Solução
                                    </div>
                                    <asp:Label ID="textoSolucao" runat="server" Text='<%# Eval("PEN_SOLUCAO") %>' /><br />
                                </asp:Panel>
                            </td>
                        </tr>
                    </table>
                </EditItemTemplate>
            </asp:FormView>
        </div>
        <div id="sitecorpoboxbottom" class="sitecorpoboxbottom" runat="server">
            <asp:LinkButton ID="btSalvar" runat="server" CssClass="sitebutton">
                <asp:Image ID="Image1" runat="server" ImageUrl="~/Images/16x16/AcceptWhite.png" />Salvar
            </asp:LinkButton>
        </div>
    </div>
    <asp:SqlDataSource ID="sqlPendencias" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT PEN_IND, PEN_SOLICITANTE, PEN_DATAHORA, PEN_RESPONSAVEL1, PEN_DATAHORASOLUCAO, SUP_NOME, PEN_SITUACAO, (SELECT SUP_NOME FROM AssepontoSuporte WHERE PEN_RESPONSAVEL2 = SUP_IND) AS NOME,
                PEN_PROBLEMA, PEN_SOLUCAO FROM [AssepontoPendencias] LEFT JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1 WHERE ([PEN_IND] = @PEN_IND)"
        UpdateCommand="UPDATE AssepontoPendencias SET PEN_RESPONSAVEL1 = @PEN_RESPONSAVEL1, PEN_SOLICITANTE = @PEN_SOLICITANTE, PEN_PROBLEMA = @PEN_PROBLEMA, PEN_SOLUCAO = @PEN_SOLUCAO,
                PEN_DATAHORA = @PEN_DATAHORA, PEN_DATAHORASOLUCAO = @PEN_DATAHORASOLUCAO, PEN_SITUACAO = @PEN_SITUACAO WHERE PEN_IND = @PEN_IND"
        InsertCommand="INSERT INTO AssepontoPendencias (PEN_INDCADASTRO, PEN_RESPONSAVEL1, PEN_SOLICITANTE, PEN_PROBLEMA, PEN_SOLUCAO, PEN_DATAHORA, PEN_DATAHORASOLUCAO, PEN_SITUACAO, PEN_TIPO, PEN_IMPLANTACAO) 
                VALUES (@PEN_INDCADASTRO, @PEN_RESPONSAVEL1, @PEN_SOLICITANTE, @PEN_PROBLEMA, @PEN_SOLUCAO, GETDATE(), @PEN_DATAHORASOLUCAO, @PEN_SITUACAO, @PEN_TIPO, @PEN_IMPLANTACAO)"
        OnUpdated="sqlPendencias_Updated" OnUpdating="sqlPendencias_Updating" OnInserting="sqlPendencias_Inserting"
        OnInserted="sqlPendencias_Inserted">
        <DeleteParameters>
            <asp:QueryStringParameter Name="PEN_IND" QueryStringField="ind" Type="Int32" />
        </DeleteParameters>
        <SelectParameters>
            <asp:QueryStringParameter Name="PEN_IND" QueryStringField="ind" Type="Int32" DefaultValue="0" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="PEN_RESPONSAVEL1" Type="Int32" />
            <asp:Parameter Name="PEN_SOLICITANTE" Type="String" />
            <asp:Parameter Name="PEN_PROBLEMA" Type="String" />
            <asp:Parameter Name="PEN_SOLUCAO" Type="String" />
            <asp:Parameter Name="PEN_DATAHORA" Type="DateTime" />
            <asp:Parameter Name="PEN_DATAHORASOLUCAO" Type="DateTime" />
            <asp:Parameter Name="PEN_SITUACAO" Type="Byte" />
            <asp:QueryStringParameter Name="PEN_IND" QueryStringField="ind" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="PEN_INDCADASTRO" Type="Int32" />
            <asp:Parameter Name="PEN_RESPONSAVEL1" Type="Int32" />
            <asp:Parameter Name="PEN_SOLICITANTE" Type="String" />
            <asp:Parameter Name="PEN_PROBLEMA" Type="String" />
            <asp:Parameter Name="PEN_SOLUCAO" Type="String" />
            <asp:Parameter Name="PEN_DATAHORA" Type="DateTime" />
            <asp:Parameter Name="PEN_DATAHORASOLUCAO" Type="DateTime" />
            <asp:Parameter Name="PEN_SITUACAO" Type="Byte" />
            <asp:Parameter Name="PEN_TIPO" Type="Byte" />
            <asp:QueryStringParameter Name="PEN_IMPLANTACAO" Type="Int32" QueryStringField="implantacao" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
