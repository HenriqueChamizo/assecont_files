<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Revenda.Master" AutoEventWireup="true" CodeBehind="Pendencia.aspx.cs" Inherits="Asseponto.Revenda.Clientes.Pendencia" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner">
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="PEN_IND" DataSourceID="sqlClientes" DefaultMode="ReadOnly">
                <ItemTemplate>
                    <table class="formviewtable">
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Solicitante
                                </div>
                                <asp:Label ID="PEN_SOLICITANTE" runat="server" Text='<%# Eval("PEN_SOLICITANTE") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Data
                                </div>
                                <asp:Label ID="PEN_DATAHORA" runat="server" Text='<%# Eval("PEN_DATAHORA", "{0:dd/MM/yyyy hh:mm}") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Técnico Resposável
                                </div>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("SUP_NOME") %>'></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <div class="fieldviewcaption">
                                    Descrição da Pendência
                                </div>
                                <asp:Label ID="PEN_PROBLEMA" runat="server" Text='<%# Eval("PEN_PROBLEMA") %>'></asp:Label>
                            </td>
                        </tr>
                        <td>
                            <div class="fieldviewcaption">
                                Técnico Responsável 2
                            </div>
                            <asp:Label ID="Label2" runat="server" Text='<%# Eval("SUP_NOME_SOLUCAO") %>'></asp:Label>
                        </td>
                        <tr>
                            <td>
                                <div style='<%# Eval("PEN_DATAHORASOLUCAO") is DBNull ? "visibility: hidden": "" %>'>
                                    <div class="fieldviewcaption">
                                        Solução
                                    </div>
                                    <asp:Label ID="PEN_DATAHORASOLUCAO" runat="server" Text='<%# Eval("PEN_DATAHORASOLUCAO", "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label><br />
                                    <asp:Label ID="PEN_SOLUCAO" runat="server" Text='<%# Eval("PEN_SOLUCAO") %>'></asp:Label>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ItemTemplate>
            </asp:FormView>
            <asp:SqlDataSource ID="sqlClientes" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
                SelectCommand="SELECT PEN_IND, PEN_SOLICITANTE, PEN_DATAHORA, PEN_DATAHORASOLUCAO, SUP_NOME, (SELECT SUP_NOME FROM AssepontoSuporte WHERE SUP_IND = PEN_RESPONSAVEL2) AS SUP_NOME_SOLUCAO, 
                dbo.fn_texttohtmltext(PEN_PROBLEMA) AS PEN_PROBLEMA, dbo.fn_texttohtmltext(PEN_SOLUCAO) AS PEN_SOLUCAO FROM [AssepontoPendencias] LEFT JOIN AssepontoSuporte ON SUP_IND = PEN_RESPONSAVEL1 WHERE ([PEN_IND] = @PEN_IND)">
                <SelectParameters>
                    <asp:QueryStringParameter Name="PEN_IND" QueryStringField="ind" Type="Int32" />
                </SelectParameters>
            </asp:SqlDataSource>
        </div>
    </div>
</asp:Content>
