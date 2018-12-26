<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="TOS.Web.Account.Login" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>登录</title>
    <link href="../css/login.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="login-form">
        <div class="top-left"></div><div class="top-right"></div><div class="top2-left"></div><div class="top2-right"></div><div class="center-left"></div><div class="center-c">
            <div class="center-login">
            <span>用户名 </span><input type="text" name="usercode" />
            <span>密  码 </span><input type="password" name="userpwd" />
                <div class="auto-login">
                    <label for="autoLogin">记住我</label>
                    <input type="checkbox" name="isAutoLogin" id="autoLogin"/>
                </div>
            <div class="tips"><%=Message %></div>
            <asp:Button ID="btnLogin" runat="server" CssClass="login" OnClick="btnLogin_Click" />
            <asp:Button ID="btnReg" runat="server" CssClass="reg" OnClick="btnReg_Click" />
            </div>
        </div><div class="center-right"></div>
        <div class="bottom">The MIT License (MIT)</div>
    </form>
</body>
</html>
