<%@ Page Language="C#" MasterPageFile="~/Master/FormInfo.Master" AutoEventWireup="true" CodeBehind="StudentInfo.aspx.cs" Inherits="TOS.Web.Admin.StudentInfo" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ContentPlaceHolderID="content" runat="server">
    <asp:Panel ID="pShow" runat="server">
        <div class="header-banner">
            <div class="w">
                <h2>学生信息</h2>
            </div>
        </div>
        <div class="panel">
            <div class="w">
                <table width="100%" border="1">
                    <tr>
                        <td><i class="star">*</i>学号</td>
                        <td>
                            <asp:TextBox ID="txtStudentNumber" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvStudentNumber" runat="server" ControlToValidate="txtStudentNumber" ErrorMessage="学号不能为空" Display="Dynamic"></asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator ID="revStudentNumber" runat="server" ErrorMessage="学号必须为9位数字" ValidationExpression="^\d{9}$" ControlToValidate="txtStudentNumber" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="star">*</i>姓名</td>
                        <td>
                            <asp:TextBox ID="txtStudentName" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="revStudentName" runat="server" ControlToValidate="txtStudentName" ErrorMessage="姓名不能为空" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>性别</td>
                        <td>
                            <asp:RadioButtonList ID="rblGender" runat="server" RepeatLayout="Flow" RepeatDirection="Horizontal">
                                <asp:ListItem Selected="True" Text="男" Value="1"></asp:ListItem>
                                <asp:ListItem Text="女" Value="0"></asp:ListItem>
                            </asp:RadioButtonList>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="star">*</i>班级</td>
                        <td>
                            <asp:TextBox ID="txtClassName" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revClasssName" runat="server" ControlToValidate="txtClassName" ValidationExpression="^\d{7}$" ErrorMessage="班级必须为7位数字"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>身份证号</td>
                        <td>
                            <asp:TextBox ID="txtIDCard" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revIDCard" runat="server" ControlToValidate="txtIDCard" ErrorMessage="身份证号格式不正确" ValidationExpression="^[1-9]\d{5}(18|19|20)\d{2}((0[1-9])|(1[0-2]))(([0-2][1-9])|10|20|30|31)\d{3}[0-9Xx]$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>联系方式</td>
                        <td>
                            <asp:TextBox ID="txtPhone" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="联系方式格式不正确" ValidationExpression="^[0]?\d{2,3}[- ]?\d{7,8}$|(?:^1[3456789]|^9[28])\d{9}$"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>密码</td>
                        <td>
                            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>角色</td>
                        <td>
                            <%-- autocomplete="off" --%>
                            <%-- 注意:切换选择项后,selected项未变，是因为浏览器缓存，加上此标签即可 --%>
                            <asp:DropDownList ID="ddlRole" runat="server" autocomplete="off"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2"><%=Message %></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="btn-control">
                            <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary" Text=" 保 存 " OnClientClick="if (typeof(Page_ClientValidate) == 'function') { if (Page_ClientValidate() == false) { return false; } };this.disabled=true;" OnClick="btnSave_Click" UseSubmitBehavior="false" />
                            <%-- 注意：设置CausesValidation="false"，否则会触发验证 --%>
                            <asp:Button ID="btnCancel" runat="server" CssClass="btn" Text=" 取 消 " OnClick="btnCancel_Click" CausesValidation="false" />
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </asp:Panel>
    <asp:Panel ID="pError" runat="server" CssClass="error w" Visible="false">
        <span>你没有权限访问本页面</span>
    </asp:Panel>
</asp:Content>
