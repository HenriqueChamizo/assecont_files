<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Solicitacao.aspx.cs" Inherits="Asseponto.Suporte.Planos.Solicitacao" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
    <%--<link href="../../bootstrap/css/bootstrap.css" rel="stylesheet" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>
    <script src="../../bootstrap/js/bootstrap.js"></script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <%--<div style="width:100%;float:left">
        <div style="width:50%;float:left">
            <h2>
                <asp:Label ID="lbCliRazao" runat="server" Text="Label"></asp:Label>
                <small>
                    <asp:Label ID="lbCliCnpj" runat="server" Text="Label"></asp:Label>
                </small>
            </h2>
                    
            <h4>
                <asp:Label ID="lbRevRazao" runat="server" Text="Label"></asp:Label>
                <small>
                    <asp:Label ID="lbRevCnpj" runat="server" Text="Label"></asp:Label>
                </small>
            </h4>
        </div>
        <div style="width:25%;float:left">
            <br />
            <div style="width:100%;float:left">
                <strong><asp:Label ID="lbContato" runat="server" Text="Label"></asp:Label></strong>
            </div>
            <div style="width:50%;float:left">
                <asp:Label ID="lbTelefone1" runat="server" Text="Label"></asp:Label><br>
                <asp:Label ID="lbTelefone2" runat="server" Text="Label"></asp:Label><br>
            </div>
            <div style="width:50%;float:left">
                <asp:Label ID="lbEmail1" runat="server" Text="Label"></asp:Label><br>
                <asp:Label ID="lbEmail2" runat="server" Text="Label"></asp:Label><br>
            </div>
        </div>
        <div style="width:25%;float:left">
            <div style="width:100%;float:left">
                <strong><asp:Label ID="lbContatoFin" runat="server" Text="Label"></asp:Label></strong>
            </div>
            <div style="width:50%;float:left">
                <asp:Label ID="lbTelefone1Fin" runat="server" Text="Label"></asp:Label><br>
                <asp:Label ID="lbTelefone2Fin" runat="server" Text="Label"></asp:Label><br>
            </div>
            <div style="width:50%;float:left">
                <asp:Label ID="lbEmail1Fin" runat="server" Text="Label"></asp:Label><br>
                <asp:Label ID="lbEmail2Fin" runat="server" Text="Label"></asp:Label><br>
            </div>
        </div>
    </div>--%>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="CAD_IND" DefaultMode="ReadOnly" DataSourceID="sqlClientes" style="width:100%">
        <ItemTemplate>
            <asp:Panel ID="Panel1" runat="server" EnableViewState="false">
                <table class="formviewtable" style="width: 100%;">
                    <tr>
                        <td>
                            <table class="formviewtableinner" style="width: 100%;">
                                <tr>
                                    <td colspan="1" style="padding-top: 5px;">
                                        <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                            Cliente 
                                        </div>
                                        <div class="fieldviewtext">
                                            <asp:Label ID="Label12" runat="server" Text='<%# Eval("CAD_RAZAOSOCIAL") %>' />
                                        </div>
                                    </td>
                                    <td colspan="1" style="padding-top: 5px;">
                                        <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                            Revenda 
                                        </div>
                                        <div class="fieldviewtext">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Eval("REV_RAZAOSOCIAL") %>' />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="padding-top: 5px;">
                                        <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                            Contatos
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="padding-top: 5px;">
                                        <div class="fieldviewtext">
                                            <table style="width: 100%">
                                                <tr>
                                                    <td colspan="2" style="text-transform: capitalize;">
                                                        <asp:Label ID="lbContato1" runat="server" Text='<%# Eval("CAD_CONTATO") %>' />
                                                    </td>
                                                </tr>
                                                <tr style='<%# String.IsNullOrEmpty(Eval("TELEFONE1").ToString()) ? "display: none;": "padding-top: 5px;" %>'>
                                                    <td style="width: 250px">
                                                        <asp:Label ID="lbTelefone1" runat="server" Text='<%# Eval("TELEFONE1") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="lbEmail1" runat="server" Text='<%# Eval("CAD_EMAIL") %>' />
                                                    </td>
                                                </tr>
                                                <tr style='<%# String.IsNullOrEmpty(Eval("TELEFONE2").ToString()) ? "display: none;": "padding-top: 5px;" %>'>
                                                    <td style="width: 250px">
                                                        <asp:Label ID="Label7" runat="server" Text='<%#  Eval("TELEFONE2") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label8" runat="server" Text='<%# Eval("CAD_EMAIL2") %>' />
                                                    </td>
                                                </tr>
                                                <tr style='<%# String.IsNullOrEmpty(Eval("CELULAR").ToString()) ? "display: none;": "padding-top: 5px;" %>'>
                                                    <td style="width: 250px">
                                                        <asp:Label ID="Label10" runat="server" Text='<%# Eval("CELULAR") %>' />
                                                    </td>
                                                    <td>
                                                        <asp:Label ID="Label11" runat="server" Text='<%# Eval("CAD_EMAIL3") %>' />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style='<%# String.IsNullOrEmpty(Eval("CAD_OBS").ToString()) ? "display: none;": "padding-top: 5px;" %>'>
                                        <div class="fieldviewcaption" style="border-bottom: 2px solid #98BEDC;">
                                            Observações
                                        </div>
                                        <div class="fieldviewtext">
                                            <asp:Label ID="Label3" runat="server" Text='<%# "<b>" + Eval("CAD_OBS") %>' MultiLine='1' />
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="3" style="padding-top: 8px;">
                                        <wr:Alerta runat="server" ImageUrl="~/Images/48x48/WarningRed.png" Text="Cliente Bloqueado" revenda='<%# Eval("CNPJ_CPF_REVENDA") %>' cnpj_cpf='<%# Eval("CNPJ_CPF_CLIENTE").ToString()  %>' />
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </asp:Panel>
        </ItemTemplate>
    </asp:FormView>

    <asp:SqlDataSource ID="sqlClientes" runat="server" ConnectionString='<%$ ConnectionStrings:AppConnectionString %>'
        SelectCommand="select CAD_IND,
                            CAD_RAZAOSOCIAL,
                            dbo.fn_cliente_cnpj_cpf(CAD_IND) as CNPJ_CPF_CLIENTE,
                            case when CAD_TELEFONE1_DDD is null 
			                    then case when CAD_TELEFONE1 is null or ltrim(rtrim(CAD_TELEFONE1)) = ''
					                        then '' 
					                        else ltrim(rtrim(CAD_TELEFONE1)) 
				                        end 
			                    else case when CAD_TELEFONE1 is null or ltrim(rtrim(CAD_TELEFONE1)) = ''
					                        then '' 
					                        else '(' + ltrim(rtrim(CAD_TELEFONE1_DDD)) + ') ' + ltrim(rtrim(CAD_TELEFONE1)) 
				                        end 
                            end as TELEFONE1,
                            case when CAD_TELEFONE2_DDD is null 
			                    then case when CAD_TELEFONE2 is null or ltrim(rtrim(CAD_TELEFONE2)) = ''
					                        then '' 
					                        else ltrim(rtrim(CAD_TELEFONE2)) 
				                        end 
			                    else case when CAD_TELEFONE2 is null or ltrim(rtrim(CAD_TELEFONE2)) = ''
					                        then '' 
					                        else '(' + ltrim(rtrim(CAD_TELEFONE2_DDD)) + ') ' + ltrim(rtrim(CAD_TELEFONE2)) 
				                        end 
	                        end as TELEFONE2,
	                        case when CAD_CELULAR_DDD is null 
			                    then case when CAD_CELULAR_DDD is null or ltrim(rtrim(CAD_CELULAR_DDD)) = ''
					                        then '' 
					                        else ltrim(rtrim(CAD_CELULAR)) 
				                        end 
			                    else case when CAD_CELULAR_DDD is null or ltrim(rtrim(CAD_CELULAR_DDD)) = ''
					                        then '' 
					                        else '(' + ltrim(rtrim(CAD_CELULAR_DDD)) + ') ' + ltrim(rtrim(CAD_CELULAR)) 
				                        end 
	                        end as CELULAR, 
	                        case when CAD_FINANCEIRO_TELEFONE1_DDD is null 
			                    then case when CAD_FINANCEIRO_TELEFONE1 is null or ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1)) = ''
					                        then '' 
					                        else ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1)) 
				                        end 
			                    else case when CAD_FINANCEIRO_TELEFONE1 is null or ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1)) = ''
					                        then '' 
					                        else '(' + ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1_DDD)) + ') ' + ltrim(rtrim(CAD_FINANCEIRO_TELEFONE1)) 
				                        end 
                            end as TELEFONEFINACEIRO,
	                        case when CAD_FINANCEIRO_TELEFONE2_DDD is null 
			                    then case when CAD_FINANCEIRO_TELEFONE2 is null or ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2)) = ''
					                        then '' 
					                        else ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2)) 
				                        end 
			                    else case when CAD_FINANCEIRO_TELEFONE2 is null or ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2)) = ''
					                        then '' 
					                        else '(' + ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2_DDD)) + ') ' + ltrim(rtrim(CAD_FINANCEIRO_TELEFONE2)) 
				                        end 
                            end as TELEFONEFINACEIRO2,
	                        case when CAD_FINANCEIRO_CELULAR_DDD is null 
			                    then case when CAD_FINANCEIRO_CELULAR is null or ltrim(rtrim(CAD_FINANCEIRO_CELULAR)) = ''
					                        then '' 
					                        else ltrim(rtrim(CAD_FINANCEIRO_CELULAR)) 
				                        end 
			                    else case when CAD_FINANCEIRO_CELULAR is null or ltrim(rtrim(CAD_FINANCEIRO_CELULAR)) = ''
					                        then '' 
					                        else '(' + ltrim(rtrim(CAD_FINANCEIRO_CELULAR_DDD)) + ') ' + ltrim(rtrim(CAD_FINANCEIRO_CELULAR)) 
				                        end 
                            end as CELULARFINACEIRO,
                            ltrim(rtrim(CAD_EMAIL)) as CAD_EMAIL, 
	                        ltrim(rtrim(CAD_EMAIL2)) as CAD_EMAIL2, 
	                        ltrim(rtrim(CAD_EMAIL3)) as CAD_EMAIL3, 	 
                            ltrim(rtrim(CAD_FINANCEIRO_EMAIL)) as CAD_FINANCEIRO_EMAIL, 
	                        ltrim(rtrim(CAD_FINANCEIRO_EMAIL2)) as CAD_FINANCEIRO_EMAIL2, 
	                        ltrim(rtrim(CAD_FINANCEIRO_EMAIL3)) as CAD_FINANCEIRO_EMAIL3, 
                            CAD_CONTATO,
                            CAD_FINANCEIRO_CONTATO,
                            CAD_OBS, 
	                        REV_IND, 
	                        REV_RAZAOSOCIAL, 
	                        dbo.fn_revenda_cnpj_cpf(REV_IND) as CNPJ_CPF_REVENDA
                    from AssepontoClientes 
                    inner join AssepontoRevendas on CAD_REVENDA = REV_IND 
                    where CAD_IND = @CAD_IND ">
        <SelectParameters>
            <asp:QueryStringParameter Name="CAD_IND" QueryStringField="ind" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <wr:ManutencaoStatus ID="ManutencaoStatus1" runat="server" ViewStateMode="Inherit" EnableViewState="False" />
</asp:Content>
