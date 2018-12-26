<%@ Page Language="C#" MasterPageFile="~/Master/TableList.Master" AutoEventWireup="true" CodeBehind="BookTicketList.aspx.cs" Inherits="TOS.Web.Apply.BookTicketList" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        #gvTicketInfo > tbody > tr:first-child {
            background-color: #2693ff;
            color: #fff;
        }
    </style>
    <script>
        $(function () {
            stateJudge();
            stateDataFormat();
        });

        // 状态项
        // 4.	编辑和作废的链接只在状态为确认订票前显示，否则隐藏。
        function stateJudge() {
            $.each($(".item-state"), function (i, item) {
                if (parseInt(item.innerText) >= 2) {
                    console.log("索引为:" + i + " 的操作列 隐藏");
                    $(".item-oper").eq(i).html("");
                }
            });
        }

        // 状态项数据格式化
        // 5.	状态值说明：0-作废 1-申请 2-确认订票 3-到票登记 4-领票
        function stateDataFormat() {
            $.each($(".item-state"), function (i, item) {
                switch (item.innerText) {
                    case "0":
                        item.innerText = "作废";
                        break;
                    case "1":
                        item.innerText = "申请";
                        break;
                    case "2":
                        item.innerText = "确认订票";
                        break;
                    case "3":
                        item.innerText = "到票登记";
                        break;
                    case "4":
                        item.innerText = "领票";
                        break;
                    default:
                        item.innerText = "未知状态";
                }
            });
        }

        // 确认验证作废
        function confirmDisable() {
            return confirm("确定要作废吗?");
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
                <label>状态</label>
                <asp:DropDownList ID="ddlState" runat="server">
                    <asp:ListItem Value="-1">全部</asp:ListItem>
                    <asp:ListItem Value="0">作废</asp:ListItem>
                    <asp:ListItem Value="1">申请</asp:ListItem>
                    <asp:ListItem Value="2">确认订票</asp:ListItem>
                    <asp:ListItem Value="3">到票登记</asp:ListItem>
                    <asp:ListItem Value="4">领票</asp:ListItem>
                </asp:DropDownList>
                <div class="btnGroup">
                    <asp:LinkButton ID="lbQuery" runat="server" Text="查询" OnClick="lbQuery_Click"></asp:LinkButton>
                    <asp:LinkButton ID="lbApply" runat="server" Text="申请" href="ApplyBookTicket.aspx?type=add"></asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="control w">
            <asp:GridView ID="gvTicketInfo" runat="server" AllowPaging="True" PageSize="10" Width="962px" EnableViewState="false" DataKeyNames="Id" AutoGenerateColumns="False" ShowHeaderWhenEmpty="true" EmptyDataText="没有找到任何记录">
                <Columns>
                    <%-- 主键 --%>
                    <asp:BoundField DataField="Id" HeaderText="Id" Visible="false" />
                    <%-- 序号列：仅用作展示计数 --%>
                    <asp:TemplateField HeaderText="序号">
                        <ItemTemplate>
                            <%#Container.DataItemIndex+1 %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <%-- 其它各普通列 --%>
                    <asp:BoundField DataField="TrainNumber" HeaderText="车次">
                        <HeaderStyle Height="30px" />
                        <ItemStyle Height="30px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="StartStation" HeaderText="起点站"></asp:BoundField>
                    <asp:BoundField DataField="EndStation" HeaderText="终点站"></asp:BoundField>
                    <asp:BoundField DataField="BookDate" DataFormatString="{0:yyyy-MM-dd}" HeaderText="预定日期"></asp:BoundField>
                    <asp:BoundField DataField="Phone" HeaderText="备用联系方式"></asp:BoundField>
                    <asp:BoundField DataField="Remark" HeaderText="备注"></asp:BoundField>
                    <asp:BoundField ItemStyle-CssClass="item-state" DataField="TicketSate" HeaderText="状态"></asp:BoundField>
                    <%-- 操作列 --%>
                    <asp:TemplateField HeaderText="操作">
                        <ItemStyle HorizontalAlign="Center" CssClass="item-oper" />
                        <ItemTemplate>
                            <a href="ApplyBookTicket.aspx?type=edit&id=<%#Eval("Id") %>">编辑</a>&nbsp;
                               <asp:LinkButton ID="lbDisable" runat="server" Text="作废" OnClientClick="return confirmDisable();" OnClick="lbDisable_Click" idtag='<%#Eval("Id") %>'></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle CssClass="pager" />
            </asp:GridView>
        </div>
    </asp:Panel>
    <asp:Panel ID="pError" runat="server" CssClass="error w" Visible="false">
        <span>你没有权限访问本页面</span>
    </asp:Panel>
</asp:Content>

