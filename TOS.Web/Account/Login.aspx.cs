using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using TOS.Model;
using TOS.BLL;
using TOS.Common;
using System.Data;
using System.Configuration;

namespace TOS.Web.Account
{
    public partial class Login : Account.LoginState
    {
        //private StudentBll studentBll = new StudentBll();
        private LoginBll loginBll = new LoginBll();

        private string homeUrl = ConfigurationManager.AppSettings["homeUrl"];

        public string Message { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                if (loginStateCheck())
                {
                    Response.Redirect(homeUrl);
                }
            }
        }

        #region 点击登录
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            VwUserModel model = new VwUserModel();
            string userCode = Request["userCode"];
            string userPwd = Request["userPwd"];
            if (string.IsNullOrEmpty(userCode) || string.IsNullOrEmpty(userPwd))
            {
                this.Message = "用户名或密码不能为空";
                return;
            }
            model.UserCode = userCode;
            model.Password = MD5Helper.MD5Encrypt32(userPwd);
            int code = loginBll.user_Login(model);

            #region MyRegion
            //int code = -1;
            //DataTable dt = loginBll.getByUserCodeAndPwd(userCode, model.Password);
            //int rowCount = dt.Rows.Count;
            //if (rowCount > 0)
            //{
            //    code = 1;
            //    model.UserName = dt.Rows[0]["UserName"].ToString();
            //    model.Gender = Convert.ToBoolean(dt.Rows[0]["Gender"] == DBNull.Value ? true : dt.Rows[0]["Gender"]);
            //    model.IdCard = dt.Rows[0]["IDCard"].ToString();
            //    model.Telephone = dt.Rows[0]["Telephone"].ToString();
            //    model.ClassName = dt.Rows[0]["ClassName"].ToString();
            //} 
            #endregion

            if (code == -1)
            {
                this.Message = "用户名或密码错误";
            }
            else if (code == 1)
            {
                // 登录成功
                Session["User"] = model;
                autoLogin(model);
                Response.Redirect(homeUrl);
            }
        }
        #endregion

        #region 自动登录
        private void autoLogin(VwUserModel model)
        {
            if (!string.IsNullOrEmpty(Request["isAutoLogin"]))
            {
                // 保存7天--账号密码在Cookie
                HttpCookie cookieUserCode = new HttpCookie("UserCode", model.UserCode);
                cookieUserCode.Expires = DateTime.Now.AddDays(7);
                HttpCookie cookieUserPwd = new HttpCookie("UserPwd", model.Password);
                cookieUserPwd.Expires = DateTime.Now.AddDays(7);
                Response.Cookies.Add(cookieUserCode);
                Response.Cookies.Add(cookieUserPwd);
            }
        }
        #endregion

        #region 点击前往注册页面
        protected void btnReg_Click(object sender, EventArgs e)
        {
            Response.Redirect("Register.aspx");
        } 
        #endregion
    }
}