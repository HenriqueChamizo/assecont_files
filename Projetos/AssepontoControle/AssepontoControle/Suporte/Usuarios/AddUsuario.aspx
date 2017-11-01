<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="AddUsuario.aspx.cs" Inherits="Asseponto.Suporte.Usuarios.AddUsuario" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <asp:FormView ID="FormView1" runat="server" DefaultMode="Insert" DataSourceID="sqlUsuario" OnDataBound="FormView1_DataBound">
        <EditItemTemplate>
            <p>
                Nome<br />
                <asp:TextBox ID="txtNome" runat="server"  Width="200px" notnull="true" Text='<%# Bind("SUP_NOME") %>'></asp:TextBox>
            </p>
            <p>
                Login<br />
                <asp:TextBox ID="txtLogin" runat="server"  Width="200px" notnull="true" Text='<%# Bind("SUP_LOGIN") %>'></asp:TextBox>
            </p>
            <p>
                Senha<br />
                <asp:TextBox ID="txtSenha" runat="server"  Width="200px" notnull="true" MaxLength="10" Text='<%# Bind("SUP_PWD") %>'></asp:TextBox>
            </p>
            <p>
                Telefone<br />
                <asp:TextBox ID="txtTelefone" runat="server"  Width="200px" Text='<%# Bind("SUP_TELEFONE") %>'></asp:TextBox>
            </p>
            <p>
                Skype<br />
                <asp:TextBox ID="txtSkype" runat="server"  Width="200px" Text='<%# Bind("SUP_SKYPE") %>'></asp:TextBox>
            </p>
            <p>
                E-mail<br />
                <asp:TextBox ID="txtEmail" runat="server" Width="200px" Text='<%# Bind("SUP_EMAIL") %>'></asp:TextBox>
            </p>
            <p>
                Nivel de Acesso<br />
                <telerik:RadComboBox ID="RadNivelAcesso" runat="server"  Width="200px" notnull="true" Skin="flv" EnableEmbeddedSkins="false"
                    EmptyMessage="Selecione" SelectedValue='<%# Bind("SUP_PERFIL") %>' EnableTextSelection="False">
                    <Items>
                        <telerik:RadComboBoxItem Value="1" Text="Gerente" />
                        <telerik:RadComboBoxItem Value="2" Text="Comercial" />
                        <telerik:RadComboBoxItem Value="3" Text="Implantação" />
                        <telerik:RadComboBoxItem Value="4" Text="Suporte" />
                    </Items>
                </telerik:RadComboBox>
            </p>
            <p>
                Setor<br />
                <telerik:RadComboBox ID="RadSetor" runat="server"  Width="200px" notnull="true" Skin="flv" EnableEmbeddedSkins="false"
                    EmptyMessage="Selecione" SelectedValue='<%# Bind("SUP_SETOR") %>' EnableTextSelection="False">
                    <Items>
                        <telerik:RadComboBoxItem Value="0" Text="Nenhum" />
                        <telerik:RadComboBoxItem Value="1" Text="Gerente" />
                        <telerik:RadComboBoxItem Value="2" Text="Comercial" />
                        <telerik:RadComboBoxItem Value="3" Text="Implantação" />
                        <telerik:RadComboBoxItem Value="4" Text="Suporte" />
                    </Items>
                </telerik:RadComboBox>
            </p>
            <p>
                <asp:LinkButton ID="lkBtnAdicionar" runat="server" CssClass="sitebutton blue" CommandArgument="Insert" CommandName="Insert">Adicionar Usuário</asp:LinkButton>
            </p>
        </EditItemTemplate>
    </asp:FormView>
    <asp:SqlDataSource ID="sqlUsuario" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        InsertCommand="INSERT INTO AssepontoSuporte
        (SUP_NOME, SUP_ATIVO, SUP_LOGIN, SUP_PWD, SUP_EMAIL, SUP_PERFIL, SUP_TELEFONE, SUP_SKYPE, SUP_SETOR) VALUES 
        (@SUP_NOME, 1, @SUP_LOGIN, @SUP_PWD, @SUP_EMAIL, @SUP_PERFIL, @SUP_TELEFONE, @SUP_SKYPE, @SUP_SETOR)"
        OnInserted="sqlUsuario_Inserted">

        <InsertParameters>
            <asp:Parameter Name="SUP_NOME" />
            <asp:Parameter Name="SUP_LOGIN" />
            <asp:Parameter Name="SUP_PWD" />
            <asp:Parameter Name="SUP_EMAIL" />
            <asp:Parameter Name="SUP_TELEFONE" />
            <asp:Parameter Name="SUP_SKYPE" />
            <asp:Parameter Name="SUP_PERFIL" />
            <asp:Parameter Name="SUP_SETOR" />
        </InsertParameters>
    </asp:SqlDataSource>
</asp:Content>
