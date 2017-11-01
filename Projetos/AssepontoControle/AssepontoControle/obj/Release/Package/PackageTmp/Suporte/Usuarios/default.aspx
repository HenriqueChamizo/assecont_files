<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="default.aspx.cs" Inherits="Asseponto.Suporte.Usuarios._default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:content id="Content2" contentplaceholderid="contentplaceMenuEsquerdo" runat="server">
    <div id="sitemenuesquerdo">
        <telerik:RadMenu ID="RadMenu1" runat="server" Flow="Vertical" Skin="Wr" EnableEmbeddedSkins="false"
            Width="100%" OnItemClick="RadMenu1_ItemClick">
            <Items>
                <telerik:RadMenuItem runat="server" Text="Novo Usuário" NavigateUrl="~/Suporte/Usuarios/AddUsuario.aspx" />
                <telerik:RadMenuItem runat="server" Text="Ativos" Value="1" />
                <telerik:RadMenuItem runat="server" Text="Inativos" Value="0" />
            </Items>
        </telerik:RadMenu>
    </div>
</asp:content>
<asp:content id="Content3" contentplaceholderid="contentplaceConteudo" runat="server">
    <div id="sitecorpobox">
        <div id="sitecorpoboxinner" style="margin-left: 10px">
            <telerik:RadFormDecorator ID="QsfFromDecorator" runat="server" DecoratedControls="All" EnableRoundedCorners="false" />
            <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server">
                <AjaxSettings>
                    <telerik:AjaxSetting AjaxControlID="RadGrid1">
                        <UpdatedControls>
                            <telerik:AjaxUpdatedControl ControlID="RadGrid1" LoadingPanelID="RadAjaxLoadingPanel1" />
                        </UpdatedControls>
                    </telerik:AjaxSetting>
                </AjaxSettings>
            </telerik:RadAjaxManager>
            <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" />
            <br />
            <telerik:RadGrid ID="RadGrid2" runat="server" AllowPaging="True" DataSourceID="SqlDataUsuarios"
                CellSpacing="0" GridLines="None" PageSize="30" EditItemStyle-HorizontalAlign="Justify"
                GroupingSettings-CaseSensitive="false" AllowSorting="true" SortingSettings-EnableSkinSortStyles="false"
                Skin="flv" AllowAutomaticUpdates="true" EnableEmbeddedSkins="false">

                <MasterTableView DataSourceID="SqlDataUsuarios" AutoGenerateColumns="false"
                    DataKeyNames="SUP_IND" AllowAutomaticUpdates="true">

                    <Columns>
                        <telerik:GridEditCommandColumn ButtonType="ImageButton" HeaderText="Editar" EditImageUrl="~/Skins/Grid/Edit.gif">
                            <HeaderStyle Width="50px" />
                        </telerik:GridEditCommandColumn>

                        <telerik:GridTemplateColumn DataField="SUP_IND" HeaderText="Usuário(a)" EditFormHeaderTextFormat=" " SortExpression="SUP_IND" UniqueName="SUP_IND">
                            <ItemTemplate>
                                <asp:Label ID="lbNome" runat="server" Font-size="14pt" ForeColor="#1A4C83" Text='<%# Eval("SUP_NOME") %>'></asp:Label>
                                <br />
                                <asp:Label ID="lbLogin" runat="server" Text='<%# "login<b> " +  Eval("SUP_LOGIN") + "</b>" %>'></asp:Label>
                                <br />
                                <asp:Label ID="lbUltimoAcesso" runat="server" Text='<%# "Ultimo acesso em " +  Eval("SUP_ULTIMO_ACESSO" , "{0:dd/MM/yyyy HH:mm}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                Nova Senha
                                <asp:TextBox ID="txtAcesso" MaxLength="10" runat="server" Text='<%# Bind("SUP_PWD") %>'></asp:TextBox>
                                Max. 10 Digitos
                            </EditItemTemplate>
                            <HeaderStyle Width="350px" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="SUP_TELEFONE" HeaderText="Dados" EditFormHeaderTextFormat=" " SortExpression="SUP_TELEFONE" UniqueName="SUP_TELEFONE">
                            <ItemTemplate>
                                <asp:Label ID="Label4" runat="server" Text='<%# !string.IsNullOrEmpty(Eval("SUP_TELEFONE").ToString()) ? "11 " +  Eval("SUP_TELEFONE") : "" %>'></asp:Label>
                                <br />
                                <asp:Label ID="Label6" runat="server" Text='<%# !string.IsNullOrEmpty(Eval("SUP_EMAIL").ToString()) ?  Eval("SUP_EMAIL") : "" %>'></asp:Label>
                                 <br />
                                <asp:Label ID="Label5" runat="server" Text='<%# !string.IsNullOrEmpty(Eval("SUP_SKYPE").ToString()) ? "Skype " + Eval("SUP_SKYPE") : "" %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                Telefone
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("SUP_TELEFONE") %>'></asp:TextBox>
                                <br />
                                Skype
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("SUP_SKYPE") %>'></asp:TextBox>
                                <br />
                                E-mail 
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("SUP_EMAIL") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <HeaderStyle Width="350px" />
                        </telerik:GridTemplateColumn>

                        <%--  <telerik:GridTemplateColumn DataField="SUP_PWD" HeaderText=" " EditFormHeaderTextFormat="Nova Senha" SortExpression="SUP_PWD" UniqueName="SUP_PWD">
                            <ItemTemplate>
                               <asp:Label ID="lbAcesso" runat="server" Text='<%# Eval("SUP_PWD") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                            </EditItemTemplate>
                            <HeaderStyle Width="100px" />
                        </telerik:GridTemplateColumn>--%>

                        <telerik:GridTemplateColumn DataField="SUP_PERFIL" HeaderText="Perfil" SortExpression="SUP_PERFIL" UniqueName="SUP_PERFIL">
                            <ItemTemplate>
                                <asp:Label ID="lbperfil" runat="server" Text='<%# ((Asseponto.Classes.Types.Perfil)Convert.ToInt32(Eval("SUP_PERFIL"))) %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="comboboxPerfil" runat="server" DataValueField="SUP_PERFIL" Skin="flv"
                                    EnableEmbeddedSkins="false" EmptyMessage="Selecione" OnLoad="comboboxPerfil_Load" SelectedValue='<%# Bind("SUP_PERFIL") %>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="SUP_SETOR" HeaderText="Setor" SortExpression="SUP_SETOR" UniqueName="SUP_SETOR">
                            <ItemTemplate>
                                <asp:Label ID="lbSetor" runat="server" Text='<%# ((Asseponto.Classes.Types.Setor)Convert.ToInt32(Eval("SUP_SETOR"))) %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <telerik:RadComboBox ID="comboboxSetor" runat="server" DataValueField="SUP_SETOR" Skin="flv"
                                    EnableEmbeddedSkins="false" EmptyMessage="Selecione" OnLoad="comboboxSetor_Load" SelectedValue='<%# Bind("SUP_SETOR") %>' />
                            </EditItemTemplate>
                            <HeaderStyle Width="80px" />
                           <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>

                        <telerik:GridTemplateColumn DataField="SUP_ATIVO" AllowFiltering="false" HeaderText="Ativo" SortExpression="SUP_ATIVO" UniqueName="SUP_ATIVO">
                            <ItemTemplate>
                                <asp:CheckBox ID="chkTest" runat="server" AutoPostBack="true" Checked='<%#Bind("SUP_ATIVO") %>' OnCheckedChanged="chkTest_CheckedChanged" />
                            </ItemTemplate>
                            <HeaderStyle Width="80px" />
                            <ItemStyle HorizontalAlign="Center" />
                        </telerik:GridTemplateColumn>
                    </Columns>
                    <EditFormSettings>
                        <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"
                            CancelImageUrl="~/Skins/Grid/Cancel.gif" CancelText="Cancelar" EditImageUrl="~/Skins/Grid/Edit.gif"
                            EditText="Editar" ItemStyle-CssClass="sitebutton blue" UpdateText="Salvar">
                        </EditColumn>
                    </EditFormSettings>
                </MasterTableView>
            </telerik:RadGrid>
        </div>
    </div>
    <asp:SqlDataSource ID="SqlDataUsuarios" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
        SelectCommand="SELECT SUP_IND, SUP_NOME, SUP_EMAIL, SUP_PWD, SUP_SKYPE, SUP_LOGIN, SUP_TELEFONE, SUP_PERFIL, SUP_ATIVO, SUP_SETOR, SUP_ULTIMO_ACESSO FROM AssepontoSuporte 
                       WHERE SUP_PERFIL &gt; 0 AND (SUP_ATIVO = @ativo) AND (SUP_IND = @ind OR 100 = @ind)
                       ORDER BY SUP_NOME ASC"

        UpdateCommand="UPDATE AssepontoSuporte SET SUP_SETOR = @SUP_SETOR, SUP_PERFIL = @SUP_PERFIL, SUP_TELEFONE = @SUP_TELEFONE, SUP_EMAIL = @SUP_EMAIL, SUP_SKYPE = @SUP_SKYPE, SUP_PWD = @SUP_PWD WHERE SUP_IND = @SUP_IND">
        <SelectParameters>
            <asp:QueryStringParameter Name="ativo" DefaultValue="1" QueryStringField="ativo" />
            <asp:QueryStringParameter Name="ind" DefaultValue="100" QueryStringField="ind" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="SUP_IND" Type="Int32" />
            <asp:Parameter Name="SUP_PERFIL" Type="Int32" />
            <asp:Parameter Name="SUP_SETOR" Type="Int32" />
            <asp:Parameter Name="SUP_PWD" Type="String" />
            <asp:Parameter Name="SUP_SKYPE" Type="String" />
            <asp:Parameter Name="SUP_TELEFONE" Type="String" />
            <asp:Parameter Name="SUP_EMAIL" Type="String" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:content>
