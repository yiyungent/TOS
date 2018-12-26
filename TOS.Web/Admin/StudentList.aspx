<%@ Page Language="C#" MasterPageFile="~/Master/TableList.Master" AutoEventWireup="true" CodeBehind="StudentList.aspx.cs" Inherits="TOS.Web.Admin.StudentList" %>

<asp:Content ContentPlaceHolderID="head" runat="server">
    <style>
        #gvStudent > tbody > tr:first-child {
            background-color: #2693ff;
            color: #fff;
        }
    </style>
    <script>
        $(function () {
            $("input[name*=chkall]").click(function () {
                // 注意:prop 有切换效果，而attr没有，所以attr一次设置后就无法切换回来了
                $("input[name*='chkitem']").prop("checked", $("input[name*='chkall']").prop("checked"));
            });
        });
        function confirmDelete() {
            return confirm("确定删除吗？");
        }
    </script>
</asp:Content>
<asp:Content ContentPlaceHolderID="content" runat="server">
    <asp:Panel ID="pShow" runat="server">
        <div class="header-banner">
            <div class="w">
                <h2>学生信息管理</h2>
            </div>
        </div>
        <div class="panel">
            <div class="w">
                <label>学号</label>
                <input type="text" name="studentNumber" value="" runat="server" id="txtStudentNumber" />
                <label>姓名</label>
                <input type="text" name="studentName" value="" runat="server" id="txtStudentName" />
                <label>班级</label>
                <input type="text" name="className" value="" runat="server" id="txtClassName" />
                <div class="btnGroup">
                    <asp:LinkButton ID="lbQuery" runat="server" OnClick="lbQuery_Click">查询</asp:LinkButton>
                    <a href="/Admin/StudentInfo.aspx?type=add" title="新增学生信息">新增</a>
                    <asp:LinkButton ID="lbBatchDel" runat="server" OnClientClick="return confirmDelete();" OnClick="lbBatchDel_Click">批量删除</asp:LinkButton>
                </div>
            </div>
        </div>
        <div class="control w">
            <asp:GridView ID="gvStudent" runat="server" AutoGenerateColumns="False" DataKeyNames="Id" OnPageIndexChanging="gvStudent_PageIndexChanging" AllowPaging="True" EnableViewState="False" PageSize="12" Width="962px" OnRowDeleting="gvStudent_RowDeleting">
                <Columns>
                    <%-- 主键隐藏 --%>
                    <asp:BoundField DataField="Id" HeaderText="Id" Visible="False" />
                    <%-- 全选以及行选checkbox模板列 --%>
                    <asp:TemplateField HeaderStyle-Width="30px" HeaderStyle-HorizontalAlign="Center" ItemStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <asp:CheckBox runat="server" ID="chkall" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:CheckBox runat="server" ID="chkitem" />
                        </ItemTemplate>

                        <HeaderStyle HorizontalAlign="Center" Width="30px"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="序号" HeaderStyle-Width="40px" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%-- 处理序号，递增1 --%>
                            <%# Container.DataItemIndex+1 %>
                        </ItemTemplate>

                        <HeaderStyle Width="40px"></HeaderStyle>

                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                    <asp:BoundField DataField="StudentNumber" HeaderText="学号" HeaderStyle-Width="100px" HeaderStyle-Height="20px" ItemStyle-Height="20px">
                        <HeaderStyle Height="20px" Width="100px"></HeaderStyle>

                        <ItemStyle Height="20px"></ItemStyle>
                    </asp:BoundField>
                    <asp:BoundField DataField="StudentName" HeaderText="姓名">
                        <HeaderStyle Width="80px" />
                        <ItemStyle Width="80px" Wrap="false" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Sex" HeaderText="性别">
                        <HeaderStyle Width="50px" />
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Identification" HeaderText="身份证号">
                        <HeaderStyle Width="200px" />
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="Telephone" HeaderText="联系方式">
                        <HeaderStyle Width="150px" />
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ClassName" HeaderText="班级">
                        <HeaderStyle Width="100px" />
                        <ItemStyle HorizontalAlign="Right" />
                    </asp:BoundField>
                    <asp:BoundField DataField="RoleName" HeaderText="角色">
                        <HeaderStyle Width="80px" />
                    </asp:BoundField>
                    <asp:TemplateField ShowHeader="False" HeaderText="操作" ItemStyle-HorizontalAlign="Center">
                        <ItemTemplate>
                            <%-- 注意:Eval()前有井号#,不是等号= --%>
                            <a href="StudentInfo.aspx?type=edit&id=<%#Eval("Id") %>">编辑</a>
                            &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete" Text="删除" OnClientClick="return confirmDelete();"></asp:LinkButton>
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

