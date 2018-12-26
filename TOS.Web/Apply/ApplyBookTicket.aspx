<%@ Page Language="C#" MasterPageFile="~/Master/FormInfo.Master" AutoEventWireup="true" CodeBehind="ApplyBookTicket.aspx.cs" Inherits="TOS.Web.Apply.ApplyBookTicket" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            stateDataFormat();
            defaultBookDate();
        });
        function stateDataFormat() {
            var $stateVal = $("input[id$='txtState']");
            switch ($stateVal.val()) {
                case "0":
                    $stateVal.val("作废");
                    break;
                case "1":
                    $stateVal.val("申请");
                    break;
                case "2":
                    $stateVal.val("确认订票");
                    break;
                case "3":
                    $stateVal.val("到票登记");
                    break;
                case "4":
                    $stateVal.val("领票");
                    break;
                default:
                    $stateVal.val("未知状态");
            }
        }

        function defaultBookDate() {
            var date = new Date();
            $(".js_bookDate").val(date.getFullYear() + "-" + (date.getMonth() + 1) + "-" + date.getDate());
        }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="content" runat="server">
    <asp:Panel ID="pShow" runat="server">
        <div class="header-banner">
            <div class="w">
                <h2>申请订票</h2>
            </div>
        </div>
        <div class="panel">
            <div class="w">
                <table width="100%" border="1">
                    <tr>
                        <td><i class="star">*</i>车次</td>
                        <td>
                            <asp:TextBox ID="txtTrainNumber" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvTrainNumber" runat="server" ControlToValidate="txtTrainNumber" ErrorMessage="车次不能为空" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="star">*</i>起点站</td>
                        <td>
                            <asp:TextBox ID="txtStartStation" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="revStartStation" runat="server" ControlToValidate="txtStartStation" ErrorMessage="起点站不能为空" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="star">*</i>终点站</td>
                        <td>
                            <asp:TextBox ID="txtEndStation" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvEndStation" runat="server" ControlToValidate="txtEndStation" ErrorMessage="终点站不能为空" Display="Dynamic"></asp:RequiredFieldValidator>
                        </td>
                    </tr>
                    <tr>
                        <td><i class="star">*</i>预定日期</td>
                        <td>
                            <asp:TextBox ID="txtBookDate" TextMode="Date" CssClass="js_bookDate" runat="server"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revBookDate" runat="server" ControlToValidate="txtBookDate" ValidationExpression="^\d{4}-\d{2}-\d{2}$" ErrorMessage="日期格式不正确" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>常用联系方式</td>
                        <td>
                            <asp:TextBox ID="txtPhone" runat="server" placeholder="11位手机号码"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="revPhone" runat="server" ControlToValidate="txtPhone" ErrorMessage="联系方式格式不正确" ValidationExpression="^[0]?\d{2,3}[- ]?\d{7,8}$|(?:^1[3456789]|^9[28])\d{9}$" Display="Dynamic"></asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td>状态</td>
                        <td>
                            <asp:TextBox ID="txtState" runat="server" Text="1" disabled></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td>备注</td>
                        <td>
                            <asp:TextBox ID="txtRemark" runat="server" Rows="4" Columns="50" TextMode="MultiLine"></asp:TextBox>
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
