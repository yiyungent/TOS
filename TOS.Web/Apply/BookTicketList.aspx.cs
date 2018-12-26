using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using TOS.Model;
using TOS.BLL;

namespace TOS.Web.Apply
{
    public partial class BookTicketList : Account.LoginState
    {
        private BookTicketInfoBll bookTicketInfoBll = new BookTicketInfoBll();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.loginStateCheck())
            {
                if (((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.TeacherManager) || ((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.StudentManager))
                {
                    dataBind();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "roleErrorJs", "<script>alert('当前页面需要教师管理员角色')</script>");
                    this.pShow.Visible = false;
                    this.pError.Visible = true;
                }
            }
            else
            {
                Response.Redirect("/Account/Login.aspx");
            }
        }

        private void dataBind(params string[] conditions)
        {
            if (this.ddlState.SelectedValue == "-1")
            {
                conditions = null;
            }
            this.gvTicketInfo.DataSource = bookTicketInfoBll.getList(conditions);
            this.gvTicketInfo.DataBind();
        }

        #region 点击查询
        protected void lbQuery_Click(object sender, EventArgs e)
        {
            string stateCon = "TicketSate=" + this.ddlState.SelectedValue;
            dataBind(stateCon);
        }
        #endregion

        #region 作废
        protected void lbDisable_Click(object sender, EventArgs e)
        {
            LinkButton lb = sender as LinkButton;
            int id = int.Parse(lb.Attributes["idtag"]);
            BookTicketStateBll bookTicketStateBll = new BookTicketStateBll();
            if (bookTicketStateBll.disableTicket(id))
            {
                dataBind();
            }
        }
        #endregion
    }
}