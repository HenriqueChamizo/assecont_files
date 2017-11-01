<%@ Page Title="" Language="C#" MasterPageFile="~/MasterPages/Assecont.Master" AutoEventWireup="true" CodeBehind="Agenda.aspx.cs" Inherits="Asseponto.Suporte.Implantacoes.Agenda1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="contentplaceHead" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="contentplaceMenuEsquerdo" runat="server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="contentplaceConteudo" runat="server">
    <asp:Panel ID="Panel2" runat="server">
        <div style="height: 30px;float: right;margin-top: -35px;">
            <%--<asp:DropDownList ID="ddwStatus" Visible="true" runat="server" Height="27px"></asp:DropDownList>--%>
            <b><asp:Label ID="Label2" runat="server" Text="Filtro: "></asp:Label></b>
            <asp:DropDownList ID="ddwStatusTipo" Visible="false" runat="server" Height="27px">
                <asp:ListItem Value="0" Text="Primeiro Contato"></asp:ListItem>
            </asp:DropDownList>
            <asp:LinkButton ID="btnStatus" runat="server" OnClick="btnStatus_Click">
                <img src="../../Images/24x24/Filtro_hcc.png" style="margin-left: 10px; top: -4px" />
            </asp:LinkButton>
            <%--<asp:CheckBoxList ID="ckbStatusTipo" runat="server"></asp:CheckBoxList>--%>
            <%--<asp:Button ID="btnStatus" runat="server" Text="Filtrar" OnClick="btnStatus_Click" />--%>
        </div>
        <telerik:radgrid id="RadGrid1" runat="server" allowpaging="True" datasourceid="SqlAgendaCliente"
            cellspacing="0" gridlines="None" pagesize="50" edititemstyle-horizontalalign="Justify"
            groupingsettings-casesensitive="false" allowsorting="true" allowautomaticupdates="true"
            sortingsettings-enableskinsortstyles="false" skin="flv" enableembeddedskins="false">


            <MasterTableView DataSourceID="SqlAgendaCliente" AutoGenerateColumns="false" 
                DataKeyNames="AGE_IND" ItemStyle-Height="30px" AlternatingItemStyle-Height="30px"
                AllowAutomaticUpdates="true">

                <NoRecordsTemplate>
                    <div>
                        Nenhum Agendamento encontrado.
                    </div>
                </NoRecordsTemplate>

                <Columns>
                    <telerik:GridTemplateColumn DataField="AGE_DATA" HeaderText="Data" SortExpression="AGE_DATA" UniqueName="AGE_DATA">
                        <ItemTemplate>
                             <p>
                                 <asp:HyperLink ID="HyperEmpresa" runat="server" Font-Size="13pt" ForeColor="#005782" Enabled='<%# Convert.ToInt16(Eval("IM_INDp")) != 0 ? false : true %>' Visible='<%# Convert.ToInt32(Eval("TIPO")) >= 0 %>'
                                      NavigateUrl='<%# string.Format("~/suporte/implantacoes/Implantacao.aspx?ind={0}", Eval("AGE_IMPLANTACAO")) %>' Text='<%# Eval("RAZAOSOCIAL") %>'></asp:HyperLink>
                                <br />
                                <asp:Label ID="lbAgenda" runat="server" Font-Size="14pt" Text='<%# Eval("AGE_DATA" , "{0:dd/MM/yyyy}") %>'></asp:Label>
                                 <span style="font-size: 14pt;"> as </span>
                                <asp:Label ID="Label1" runat="server" Font-Size="14pt" Text='<%# Eval("AGE_DATA" , "{0:HH:mm}") %>'></asp:Label>
                            </p>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="AGE_DATA"
                        HeaderText="Histórico" SortExpression="AGE_DATA" UniqueName="AGE_DATA">
                        <ItemTemplate>
                            <p>
                                <asp:Label ID="lbAgendadoEm" runat="server" Text='<%# "Agendado em " + Eval(" AGE_AGENDADO_EM", "{0:dd/MM/yyyy HH:mm}")%>'></asp:Label>
                                <asp:Label ID="lbAgendadoPor" runat="server" Text='<%# " por " + Eval("AGENDADOPOR")%>'></asp:Label>
                            </p>
                            <p style='<%# !string.IsNullOrEmpty(Eval("AGE_FINALIZADO_EM").ToString()) ? "" : "display: none;" %>'>
                                <asp:Label ID="lbFinalizadoEm" runat="server" Text='<%# "Finalizado em " + Eval("AGE_FINALIZADO_EM", "{0:dd/MM/yyyy HH:mm}")%>'></asp:Label>
                                <asp:Label ID="lbFinalizadoPor" runat="server" Text='<%# " por " + Eval("FINALIZADOPOR")%>'></asp:Label>
                            </p>
                            <p>
                                <asp:Label ID="lbText" runat="server" Visible='<%# !string.IsNullOrEmpty(Eval("AGE_OBSERVACAO").ToString()) %>' Text='<%# "Observação : " + Eval("AGE_OBSERVACAO") %>'></asp:Label>
                            </p>
                        </ItemTemplate>
                        <HeaderStyle Width="250px" />
                    </telerik:GridTemplateColumn>

                    <telerik:GridTemplateColumn DataField="STAT_NOME"
                        HeaderText="Status" SortExpression="STAT_NOME" UniqueName="STAT_NOME">
                        <ItemTemplate>
                            <p>
                                <b><asp:Label ID="lbStatus" runat="server" Text='<%# Eval("STAT_NOME") + (Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) == 5 || 
                                   Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) == 9 ? ": " : "") %>'></asp:Label></b>
                                <asp:Label ID="lbStatusTipo" runat="server" Visible='<%# (Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) == 5 || 
                                   Convert.ToInt32(Eval("IM_ANDAMENTO").ToString()) == 9 ? true : false) %>' Text='<%# Eval("TIPO_STAT_NOME")%>'></asp:Label>
                            </p>
                        </ItemTemplate>
                        <HeaderStyle Width="150px" />
                    </telerik:GridTemplateColumn>
                </Columns>

                <EditFormSettings>
                    <EditColumn UniqueName="EditCommandColumn1" FilterControlAltText="Filter EditCommandColumn1 column"
                        CancelImageUrl="~/Skins/Grid/Cancel.gif" CancelText="Cancelar" EditImageUrl="~/Skins/Grid/Edit.gif"
                        EditText="Editar" UpdateText="Salvar">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
        </telerik:radgrid>

        <asp:SqlDataSource ID="SqlAgendaCliente" runat="server" OnSelecting="SqlAgendaCliente_Selecting" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT @TIPO AS TIPO, @IM_IND as IM_INDp, AGE_IND, AGE_DATA, AGE_AGENDADO_EM, AGE_FINALIZADO_EM, AGE_OBSERVACAO, AGE_IMPLANTACAO, 
                            CAD_RAZAOSOCIAL AS RAZAOSOCIAL, AGE.SUP_NOME AS AGENDADOPOR, FIN.SUP_NOME AS FINALIZADOPOR, 
                            STAT_NOME, TIPO_STAT_NOME, IM_ANDAMENTO
                            FROM AssepontoImplantacoesAgenda                       
                            INNER JOIN AssepontoImplantacoes ON AGE_IMPLANTACAO = IM_IND
                            LEFT JOIN AssepontoImplantacoesStatus ON STAT_IND = IM_ANDAMENTO
                            LEFT JOIN AssepontoImplantacoesStatusTipo ON TIPO_STAT_IND = IM_ANDAMENTO_TIPO
                            INNER JOIN AssepontoClientes ON IM_CLIENTE = CAD_IND
                            LEFT JOIN AssepontoSuporte AGE ON AGE.SUP_IND = AGE_AGENDADO_POR
                            LEFT JOIN AssepontoSuporte FIN ON FIN.SUP_IND = AGE_FINALIZADO_POR 
                            WHERE (@IM_IND != 0 AND @IM_IND = AGE_IMPLANTACAO) OR
                            ((@IM_IND = 0 OR @IM_IND IS NULL) AND 
	                            (
		                            (@DATA = 0 AND 
	 		                            (
				                            ((@FINALIZADO = 0 AND AGE_FINALIZADO_POR IS NULL) AND
					                            ((@TIPO = 0 AND @STATUS = @TIPO) OR
					                            (@TIPO = 1 AND IM_ANDAMENTO = @STATUS) OR
					                            (@TIPO = 2 AND IM_ANDAMENTO = @STATUS AND IM_ANDAMENTO_TIPO = @STATUS_TIPO))
				                            ) OR
				                            ((@FINALIZADO = 1 AND AGE_FINALIZADO_POR IS NOT NULL) AND
					                            ((@TIPO = 0 AND @STATUS = @TIPO) OR
					                            (@TIPO = 1 AND IM_ANDAMENTO = @STATUS) OR
					                            (@TIPO = 2 AND IM_ANDAMENTO = @STATUS AND IM_ANDAMENTO_TIPO = @STATUS_TIPO))
				                            )
			                            )
		                            ) OR 
		                            (
			                            (@DATA = 1 AND @DATAVALUE = CONVERT(DATE, AGE_DATA)) AND 
				                            (
					                            ((@FINALIZADO = 0 AND AGE_FINALIZADO_POR IS NULL) AND
						                            ((@TIPO = 0 AND @STATUS = @TIPO) OR
						                            (@TIPO = 1 AND IM_ANDAMENTO = @STATUS) OR
						                            (@TIPO = 2 AND IM_ANDAMENTO = @STATUS AND IM_ANDAMENTO_TIPO = @STATUS_TIPO))
					                            ) OR
					                            ((@FINALIZADO = 1 AND AGE_FINALIZADO_POR IS NOT NULL) AND
						                            ((@TIPO = 0 AND @STATUS = @TIPO) OR
						                            (@TIPO = 1 AND IM_ANDAMENTO = @STATUS) OR
						                            (@TIPO = 2 AND IM_ANDAMENTO = @STATUS AND IM_ANDAMENTO_TIPO = @STATUS_TIPO))
					                            )
				                            )
		                            ) OR 
		                            (
			                            (@DATA = 2 AND @DATAVALUE &lt;= CONVERT(DATE, AGE_DATA)) AND 
				                            (
					                            ((@FINALIZADO = 0 AND AGE_FINALIZADO_POR IS NULL) AND
						                            ((@TIPO = 0 AND @STATUS = @TIPO) OR
						                            (@TIPO = 1 AND IM_ANDAMENTO = @STATUS) OR
						                            (@TIPO = 2 AND IM_ANDAMENTO = @STATUS AND IM_ANDAMENTO_TIPO = @STATUS_TIPO))
					                            ) OR
					                            ((@FINALIZADO = 1 AND AGE_FINALIZADO_POR IS NOT NULL) AND
						                            ((@TIPO = 0 AND @STATUS = @TIPO) OR
						                            (@TIPO = 1 AND IM_ANDAMENTO = @STATUS) OR
						                            (@TIPO = 2 AND IM_ANDAMENTO = @STATUS AND IM_ANDAMENTO_TIPO = @STATUS_TIPO))
					                            )
				                            )
		                            )
	                            )
                            )">
            <SelectParameters>
                <asp:QueryStringParameter Name="IM_IND" Type="Int32" QueryStringField="ind" DefaultValue="0" />
                <asp:QueryStringParameter Name="DATA" Type="Int32" QueryStringField="data" DefaultValue="0" />
                <asp:QueryStringParameter Name="FINALIZADO" Type="Int32" QueryStringField="finalizado" DefaultValue="0" />
                <asp:QueryStringParameter Name="TIPO" Type="Int32" QueryStringField="tipo" DefaultValue="0" />
                <asp:QueryStringParameter Name="STATUS" Type="Int32" QueryStringField="status" DefaultValue="0" />
                <asp:QueryStringParameter Name="STATUS_TIPO" Type="Int32" QueryStringField="statTipo" DefaultValue="0" />
                <asp:QueryStringParameter Name="DATAVALUE" Type="DateTime" QueryStringField="datavalue" DefaultValue="" />
            </SelectParameters>
        </asp:SqlDataSource>
        <%--<asp:SqlDataSource ID="SqlAgendaCliente" runat="server" ConnectionString="<%$ ConnectionStrings:AppConnectionString %>"
            SelectCommand="SELECT @TIPO AS TIPO, AGE_IND, AGE_DATA, AGE_AGENDADO_EM, AGE_FINALIZADO_EM, AGE_OBSERVACAO, AGE_IMPLANTACAO,
                            (SELECT CAD_RAZAOSOCIAL FROM AssepontoClientes WHERE CAD_IND = IM_CLIENTE) AS RAZAOSOCIAL,
                            (SELECT SUP_NOME FROM AssepontoSuporte WHERE AGE_AGENDADO_POR = SUP_IND) AS AGENDADOPOR,
                            (SELECT SUP_NOME FROM AssepontoSuporte WHERE AGE_FINALIZADO_POR = SUP_IND) AS FINALIZADOPOR, 
                            STAT_NOME, TIPO_STAT_NOME, IM_ANDAMENTO
                            FROM AssepontoImplantacoesAgenda                       
                            INNER JOIN AssepontoImplantacoes ON AGE_IMPLANTACAO = IM_IND
                            INNER JOIN AssepontoImplantacoesStatus ON STAT_IND = IM_ANDAMENTO
                            INNER JOIN AssepontoImplantacoesStatusTipo on TIPO_STAT_IND = IM_ANDAMENTO_TIPO
                            WHERE (@TIPO = 0 AND @IM_IND = IM_IND) OR
                            (@TIPO = 1 AND CONVERT(DATE, AGE_DATA) &lt;= CONVERT(DATE, GETDATE()) AND AGE_FINALIZADO_POR IS NULL) OR 
                            (@TIPO = 2 AND AGE_FINALIZADO_POR IS NULL) OR
	                        (@TIPO = 3 AND AGE_FINALIZADO_POR IS NULL AND IM_ANDAMENTO = 9 AND (IM_ANDAMENTO_TIPO = @STATUS_TIPO OR @STATUS_TIPO = 0)) OR
	                        (@TIPO = 4 AND AGE_FINALIZADO_POR IS NULL AND IM_ANDAMENTO = 9 AND (IM_ANDAMENTO_TIPO = @STATUS_TIPO OR @STATUS_TIPO = 0) AND 
                            CONVERT(DATE, AGE_DATA) &lt;= CONVERT(DATE, GETDATE()) AND AGE_FINALIZADO_POR IS NULL) OR
                            (@TIPO = 5 AND @STATUS_TIPO = 0 AND IM_ANDAMENTO = 6 AND 
                            CONVERT(DATE, AGE_DATA) &lt;= CONVERT(DATE, GETDATE()) AND AGE_FINALIZADO_POR IS NULL)
                            ORDER BY AGE_DATA DESC">
            <SelectParameters>
                <asp:QueryStringParameter Name="IM_IND" Type="Int32" QueryStringField="ind" DefaultValue="0" />
                <asp:QueryStringParameter Name="TIPO" Type="Int32" QueryStringField="tipo" DefaultValue="0" />
                <asp:QueryStringParameter Name="STATUS" Type="Int32" QueryStringField="status" DefaultValue="0" />
                <asp:QueryStringParameter Name="STATUS_TIPO" Type="Int32" QueryStringField="statTipo" DefaultValue="0" />
            </SelectParameters>
        </asp:SqlDataSource>--%>
    </asp:Panel>
</asp:Content>
