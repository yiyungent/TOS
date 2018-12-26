using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using TOS.Model;
using TOS.BLL;
using TOS.Common;

namespace TOS.Web.Account
{
    public partial class Register : System.Web.UI.Page
    {
        public string Message { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnReg_Click(object sender, EventArgs e)
        {
            #region 二次验证
            string ticket = Request.Form["ticket"];
            string randstr = Request.Form["randstr"];
            TencentCaptchaHelper captcha = new TencentCaptchaHelper("1");
            VerifyResult verifyResult = captcha.Verify(ticket, randstr, Request.UserHostAddress);
            if (verifyResult.Code != 1)
            {
                this.Message = "验证已经过期, 或未通过验证,请重新验证<br>详细错误: " + verifyResult.Message;
                return;
            }
            #endregion
            #region 注册
            StudentModel model = new StudentModel();
            model.StudentNumber = this.txtStudentNumber.Text.Trim();
            model.StudentName = this.txtStudentName.Text.Trim();
            model.Telephone = this.txtTelephone.Text.Trim();
            model.Password = MD5Helper.MD5Encrypt32(this.txtPwd.Text.Trim());
            model.Identification = this.txtIdentification.Text.Trim();
            model.ClassName = this.txtClassName.Text.Trim();
            model.Gender = this.rblGender.SelectedValue == "1" ? true : false;
            model.RoleId = 1;
            StudentBll bll = new StudentBll();
            int result = bll.add(model);
            if (result > 0)
            {
                // ?????存在 BUG，这里拿不到Id
                Session["User"] = new VwUserModel() { Id = 0, UserName = model.StudentName, Password = model.Password, UserCode = model.StudentNumber, Gender = model.Gender, IdCard = model.Identification, RoleId = model.RoleId, Telephone = model.Telephone };
                Response.Redirect("/Account/Login.aspx");
            }
            #endregion
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("/Account/Login.aspx");
        }
    }
}