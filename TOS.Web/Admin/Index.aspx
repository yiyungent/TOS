<%@ Page Title="" Language="C#" MasterPageFile="~/Master/Main.Master" AutoEventWireup="true" CodeBehind="Index.aspx.cs" Inherits="TOS.Web.Admin.Index" %>

<%@ Import Namespace="TOS.Model" %>

<asp:Content ID="content1" ContentPlaceHolderID="head" runat="server">
    <script>
        $(function () {
            // 使iframe 始终撑开为 主体区域(注意，非内容区域，内容区域自适应高度)高度
            //$("#tab").height($(".body").height() + 50);

            $("#tab").width($(".main").width());
            $("#tab").css("border", "none");
        });
        $(window).resize(function () {
            //$("#tab").height($(".body").height() + 50);

            $("#tab").width($(".main").width());
        });
    </script>
</asp:Content>
<asp:Content ID="content2" ContentPlaceHolderID="content" runat="server">
    <%-- onload=""加载后,iframe高度为其嵌入的内容页面高度 --%>
    <iframe name="tab" id="tab" scrolling="no" onload="this.height=this.contentWindow.document.documentElement.scrollHeight+'px'">></iframe>
</asp:Content>
<asp:Content ID="content3" ContentPlaceHolderID="nav_tree" runat="server">
    <%foreach (SysFunctionModel model in MenuList)
        {%>
    <li class="nav-item"><a href="<%=model.Url %>" target="tab"><%=model.MenuName %></a></li>
    <%} %>
</asp:Content>
<asp:Content ID="content4" ContentPlaceHolderID="layout_left" runat="server">
    <li class="nav-item">欢迎,[<%=UserName %>]</li>
</asp:Content>
<asp:Content ID="content5" ContentPlaceHolderID="layout_right" runat="server">
    <li class="nav-item exit">
        <asp:LinkButton runat="server" ID="lBtnLogout" OnClick="lBtnLogout_Click" CssClass="exit-btn"></asp:LinkButton></li>
</asp:Content>
