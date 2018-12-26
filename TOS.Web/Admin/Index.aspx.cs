using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using TOS.Model;
using TOS.BLL;

namespace TOS.Web.Admin
{
    public partial class Index : Account.LoginState
    {
        private SysFunctionBll sysFuncBll = new SysFunctionBll();

        public List<SysFunctionModel> MenuList;

        public string UserName { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (!loginStateCheck())
                {
                    Response.Redirect("/Account/Login.aspx");
                }
                VwUserModel vwUserModel = ((VwUserModel)Session["User"]);
                this.UserName = vwUserModel.UserName;
                this.MenuList = this.sysFuncBll.getByRoleId(vwUserModel.RoleId);
            }
        }

        #region 点击退出登录状态
        protected void lBtnLogout_Click(object sender, EventArgs e)
        {
            Session["User"] = null;
            if (Request.Cookies["UserCode"] != null)
            {
                Response.Cookies["UserCode"].Expires = DateTime.Now.AddDays(-1);
            }
            if (Request.Cookies["UserPwd"] != null)
            {
                Response.Cookies["UserPwd"].Expires = DateTime.Now.AddDays(-1);
            }
            Response.Redirect("/Account/Login.aspx");
        }
        #endregion
    }
}