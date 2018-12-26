using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using TOS.BLL;
using TOS.Model;

namespace TOS.Web.Account
{
    public class LoginState : System.Web.UI.Page
    {
        #region 登录状态检查
        protected bool loginStateCheck()
        {
            bool isLogin = true;
            if (Session["User"] == null)
            {
                if (Request.Cookies["UserCode"] != null && Request.Cookies["UserPwd"] != null)
                { // 是否记住了登录信息
                    LoginBll loginBll = new LoginBll();
                    VwUserModel userModel = new VwUserModel()
                    {
                        UserCode = Request.Cookies["UserCode"].Value,
                        Password = Request.Cookies["UserPwd"].Value
                    };
                    int code = loginBll.user_Login(userModel);
                    if (code == -1)
                    {
                        Response.Cookies["UserCode"].Expires = DateTime.Now.AddDays(-1);
                        Response.Cookies["UserPwd"].Expires = DateTime.Now.AddDays(-1);
                        //Response.Redirect("/Account/Login.aspx");
                        isLogin = false;
                    }
                    else if (code == 1)
                    {
                        Session["User"] = userModel;
                    }
                }
                else
                {
                    // 未记住登录信息
                    //Response.Redirect("/Account/Login.aspx");
                    isLogin = false;
                }
            }
            return isLogin;
        }
        #endregion
    }
}