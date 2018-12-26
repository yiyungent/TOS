<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="TOS.Web.Account.Register" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <style type="text/css">
        * {
            padding: 0;
            margin: 0;
        }

        table {
            border: 1px solid #a7cadd;
            width: 600px;
            margin: 10px auto;
            border-collapse: collapse;
        }

        td {
            height: 35px;
            border: 1px solid #a7cadd;
        }

        td:first-child {
            width: 200px;
            text-align: right;
            padding-right: 10px;
        }

        td:first-child span {
            color: red;
        }

        input[type=text], input[type=password] {
            width: 180px;
            height: 20px;
            padding-left: 5px;
        }

        #title {
            background-color: #a7cadd;
            height: 50px;
            color: white;
            text-align: left;
            text-indent: 10px;
        }

        table td:last-child {
            padding-left: 10px;
        }

        #btnReg, #btnCancel {
            width: 100px;
            height: 30px;
            background-color: #2693ff;
            border: 1px solid #2693ff;
            color: white;
            text-align: center;
            margin-left: 30px;
            cursor: pointer;
        }
        #btnCancel {
            background-color: #a7cadd;
            border-color: #a7cadd;
        }

        span[id^=re], span[id^=cv], span[id^=rv], span[id^=rfv] {
            color: #2693ff;
            font-weight: 300;
            background: url(../Images/error.png) no-repeat left;
            padding-left: 20px;
        }
    </style>
    <script src="../Scripts/jquery-1.9.1.min.js"></script>
    <script src="https://ssl.captcha.qq.com/TCaptcha.js"></script>
    <script>
        $(function () {
            window.tCaptcha = new TencentCaptcha(
                $("#btnVerify")[0],
                '2058929465',
                function (res) {
                    if (res.ret === 0) {
                        // 腾讯云验证通过
                        // 第一次验证
                        $("#btnVerify").text("验证通过");
                        $("#btnVerify").css("border", "1px solid green")
                            .css("color", "green");
                        // 准备 第二次验证
                        $("input[name='ticket']").val(res.ticket);
                        $("input[name='randstr']").val(res.randstr);
                    }
                }
            );
            // 绑定验证
            $("#btnReg").click(function () {
                if (tCaptcha.getTicket() == null || tCaptcha.getTicket().ticket == "") {
                    // 未验证，则显示验证码
                    tCaptcha.show();
                    return false;
                }
            });
        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <table>
            <tr>
                <td colspan="2" id="title">欢迎注册,请按照要求完成如下注册信息</td>
            </tr>
            <tr>
                <td><span>*</span><label>学号</label></td>
                <td>
                    <asp:TextBox ID="txtStudentNumber" runat="server" placeholder="9位数字，如170010347"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvStudentNumber" runat="server" ErrorMessage="需要输入学号" ControlToValidate="txtStudentNumber" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revStudentNumber" runat="server" ErrorMessage="学号为9位数字" ControlToValidate="txtStudentNumber" Display="Dynamic" ValidationExpression="^\d{9}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td><span>*</span><label>姓名</label></td>
                <td>
                    <asp:TextBox ID="txtStudentName" runat="server"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvStudentName" runat="server" ErrorMessage="姓名必须录入" ControlToValidate="txtStudentName" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <label>性别</label></td>
                <td>
                    <asp:RadioButtonList ID="rblGender" runat="server" RepeatLayout="Flow">
                        <asp:ListItem Text="男" Value="0" Selected="True"></asp:ListItem>
                        <asp:ListItem Text="女" Value="1"></asp:ListItem>
                    </asp:RadioButtonList>
                </td>
            </tr>
            <tr>
                <td><span>*</span><label>班级</label></td>
                <td>
                    <asp:TextBox ID="txtClassName" runat="server" placeholder="7位数字，如1700104"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvClassName" runat="server" ErrorMessage="班级必须录入" ControlToValidate="txtClassName" Display="Dynamic"></asp:RequiredFieldValidator>
                    <asp:RegularExpressionValidator ID="revClassName" runat="server" ControlToValidate="txtClassName" Display="Dynamic" ErrorMessage="7位数字，如1700104" ValidationExpression="^\d{7}$"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td><span>*</span><label>密码</label></td>
                <td>
                    <asp:TextBox ID="txtPwd" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvPwd" runat="server" ErrorMessage="密码必须录入" ControlToValidate="txtPwd" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td><span>*</span><label>确认密码</label></td>
                <td>
                    <asp:TextBox ID="txtConfirmPwd" runat="server" TextMode="Password"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvConfirmPwd" runat="server" Display="Dynamic" ControlToValidate="txtConfirmPwd" ErrorMessage="确认密码不能为空"></asp:RequiredFieldValidator>
                    <asp:CompareValidator ID="cvPwd" runat="server" ControlToCompare="txtPwd" ControlToValidate="txtConfirmPwd" ErrorMessage="两次输入的密码不一致" Display="Dynamic"></asp:CompareValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <label>身份证号</label></td>
                <td>
                    <asp:TextBox ID="txtIdentification" runat="server"></asp:TextBox>
                    <asp:RegularExpressionValidator ID="revIdentification" runat="server" ControlToValidate="txtIdentification" ValidationExpression="^\d{15,20}|\d{15,18}[X]+$" Display="Dynamic" ErrorMessage="身份证号的格式不正确"></asp:RegularExpressionValidator>
                </td>
            </tr>
            <tr>
                <td>
                    <label>联系方式</label></td>
                <td>
                    <asp:TextBox ID="txtTelephone" runat="server" placeholder="11位手机号码"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="rfvTelephone" runat="server" ErrorMessage="联系方式不能为空" ControlToValidate="txtTelephone" Display="Dynamic"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td><label>验证</label></td>
                <td>
                    <button id="btnVerify" onclick="return false">点击验证</button><br />
                </td>
                <td>
                    <div style="display: none">
                        <input type="hidden" name="ticket" value="" />
                        <input type="hidden" name="randstr" value="" />
                    </div>
                </td>
            </tr>
            <tr>
                <td>提示</td>
                <td><%=Message %></td>
            </tr>
            <tr>
                <td></td>
                <td>
                    <asp:Button runat="server" ID="btnReg" Text=" 注 册 " OnClick="btnReg_Click" />
                    <asp:Button runat="server" ID="btnCancel" Text=" 取 消 " CausesValidation="False" OnClick="btnCancel_Click" />
                </td>
            </tr>
        </table>
    </form>
</body>
</html>
