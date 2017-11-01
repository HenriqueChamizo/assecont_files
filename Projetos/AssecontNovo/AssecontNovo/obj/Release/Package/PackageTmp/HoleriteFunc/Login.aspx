<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="AssecontNovo.HoleriteFunc.Login" %>

<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width" />
    <title>Holerite - Login</title>
    <script src="../Jquery/jquery-3.2.1.js"></script>
    <link href="../bootstrap/css/bootstrap.css" rel="stylesheet" />
    <script src="../bootstrap/js/bootstrap.js"></script>

    <!-- Latest compiled and minified CSS -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" integrity="sha384-BVYiiSIFeK1dGmJRAkycuHAHRg32OmUcww7on3RYdg4Va+PmSTsz/K68vbdEjh4u" crossorigin="anonymous">

    <!-- Optional theme -->
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap-theme.min.css" integrity="sha384-rHyoN1iRsVXV4nD0JutlnGaslCJuC7uwjduW9SVrLvRYooPp2bWYgmgJQIXwl/Sp" crossorigin="anonymous">
    
    <!-- Latest compiled and minified JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js" integrity="sha384-Tc5IQib027qvyjSMfHjOMaLkfuWVxZxUPnCJA7l2mCWNIpG9mGCD8wGNIcPD7Txa" crossorigin="anonymous"></script>

    <link href="http://maxcdn.bootstrapcdn.com/font-awesome/4.1.0/css/font-awesome.min.css" rel="stylesheet" />
</head>
<body>
    <div class="container">
        <div class="row">
            <div class="col-sm-12" style="padding-top: 5px;padding-bottom: 5px;">
                <div class="row">
                    <div class="col-sm-6" style="text-align:center">
                        <img src="../Imagens/logos/Logo.png" style="width: 100%; max-width:310px;float:none;margin:20px auto" />
                    </div>
                    <div class="col-sm-6" style="text-align:center">
                        <img src="../Imagens/logos/holeriteOnline.png" style="width: 100%; max-width:400px;float:none;margin:20px auto" />
                    </div>
                </div>
            </div>
            <div class="col-sm-12">
                <div id="login-overlay">
                    <div class="modal-content">
                        <%--<div class="modal-header">
                            <%--<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">Close</span></button>--
                            <h4 class="modal-title" id="myModalLabel">Holherite Eletrônico</h4>
                        </div>--%>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-4">
                                    <div class="well">
                                        <form id="loginForm" method="post" runat="server" novalidate="novalidate">
                                            <div class="form-group">
                                                <label for="txtCpf" class="control-label">CPF (Somente números)</label>
                                                <%--<input type="text" class="form-control" id="cpf" name="cpf" value="" required="" title="Por favor, digite o cpf" placeholder="000.000.000-00" />--%>
                                                <asp:TextBox ID="txtCpf" runat="server" MaxLength="12" CssClass="form-control" required="required" title="Por favor, digite o cpf" placeholder="000.000.000-00"></asp:TextBox>
                                                <span class="help-block"></span>
                                            </div>
                                            <div class="form-group">
                                                <label for="txtRegistro" class="control-label">Registro</label>
                                                <asp:TextBox ID="txtRegistro" runat="server" TextMode="Password" MaxLength="6" CssClass="form-control" required="required" title="Por Favor, digite o registro"></asp:TextBox>
                                                <%--<input type="password" class="form-control" id="registro" name="registro" value="" required="" title="Por Favor, digite o registro" />--%>
                                                <span class="help-block"></span>
                                            </div>
                                            <div class="form-group">
                                                <label for="txtPassword" class="control-label">Senha</label>
                                                <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" required="required" title="Por Favor, digite a senha"></asp:TextBox>
                                                <%--<input type="password" class="form-control" id="registro" name="registro" value="" required="" title="Por Favor, digite o registro" />--%>
                                                <span class="help-block"></span>
                                            </div>
                                            <asp:Label ID="lblError" runat="server" ForeColor="Red" Text="CPF, registro ou senha, estão incorretos ou não preenchidos!" OnLoad="lblError_Load"></asp:Label>
                                            <div style="margin-bottom:15px">
                                                <asp:LinkButton ID="btnEsqueceuSenha" runat="server" CssClass="btn-link" OnClick="btnEsqueceuSenha_Click">Esqueci a Senha!</asp:LinkButton>
                                            </div>
                                            <asp:Button ID="btnEntrar" runat="server" CssClass="btn btn-success btn-block" Text="Entrar" OnClick="btnEntrar_Click" />
                                            <%--<button type="submit" class="btn btn-success btn-block">Entrar</button>--%>
                                        </form>
                                    </div>
                                </div>
                                <div class="col-sm-8">
                                    <p class="lead">Bem <span class="text-success">vindo !</span></p>
                                    <ul class="list-unstyled" style="line-height: 2">
                                        <li><span class="fa fa-check text-success"></span> Consulte aqui informações sobre sua vida funcional. Este serviço permite acesso aos demonstrativos de Salários, adiantamentos, 13º salários e participações de resultados com segurança e de uso restrito.</li>
                                        <li><span class="fa fa-check text-success"></span> Para fazer o login, informe seu CPF e Registro Funcional no campo Número do Registro com 5 dígitos e sua senha no campo correspondente.</li>
                                        <li><span class="fa fa-check text-success"></span> Em caso de dúvida com relação ao acesso, entre em contato com o RH da sua empresa.</li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
