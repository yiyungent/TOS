using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using TOS.Model;
using TOS.BLL;
using TOS.Common;

namespace TOS.Web.Admin
{
    public partial class StudentInfo : Account.LoginState
    {
        private int id;

        public string Message { get; set; }

        private StudentBll bll = new StudentBll();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (loginStateCheck())
            {
                if (((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.StudentManager)|| ((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.Student)|| ((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.TeacherManager))
                {
                    if (!IsPostBack)
                    {
                        string type = Request["type"];
                        if (type == "edit")
                        {
                            // 编辑
                            string idStr = Request["id"] != null ? Request["id"] : "";
                            if (int.TryParse(idStr, out this.id))
                            {
                                // id正确
                                setControlValue();

                            }
                            else
                            {
                                // id格式不正确
                                this.Message = "一个不正确的学生Id";
                            }
                        }
                        else if (type == "add")
                        {
                            // 新增
                            init();
                            this.txtStudentNumber.Attributes["placeholder"] = "学号为纯数字";
                        }
                        else
                        {
                            this.Message = "未知操作";
                        }
                        roleDataBind();
                    }
                }
                else
                {
                    //ClientScript.RegisterStartupScript(); // 注册在 body 最后面
                    //ClientScript.RegisterClientScriptBlock(); // 注册在 body 最前面

                    ClientScript.RegisterStartupScript(this.GetType(), "roleErrorJs", "alert('权限不足')", true);
                    this.pShow.Visible = false;
                    this.pError.Visible = true;
                }
            }
            else
            {
                Response.Redirect("/Account/Login.aspx");
            }
        }

        #region 加载输入框等控件的值
        private void setControlValue()
        {
            StudentModel model = bll.getById(this.id);
            if (model == null)
            {
                this.Message = "查无此学生，请检查学生Id是否正确";
                return;
            }
            this.txtStudentNumber.Text = model.StudentNumber;
            this.txtStudentName.Text = model.StudentName;
            this.txtClassName.Text = model.ClassName;
            this.txtIDCard.Text = model.Identification;
            this.txtPhone.Text = model.Telephone;
            this.rblGender.SelectedValue = model.Gender ? "1" : "0";
            this.ddlRole.SelectedValue = model.RoleId.ToString();
            // 注意:asp.net 出于安全性，无法直接在服务端为TextBox:Password赋值
            //this.txtPassword.Text = "*******";
            this.txtPassword.Attributes["value"] = "*******";
        }
        #endregion

        private void roleDataBind()
        {
            this.ddlRole.DataSource = new SysRoleBll().getByTypes("1");
            this.ddlRole.DataTextField = "RoleName";
            this.ddlRole.DataValueField = "RoleId";
            this.ddlRole.DataBind();
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {
            goList();
        }

        private void goList()
        {
            Response.Redirect("/Admin/StudentList.aspx");
        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            StudentModel model = new StudentModel();
            model.StudentNumber = this.txtStudentNumber.Text;
            model.StudentName = this.txtStudentName.Text;
            model.Gender = this.rblGender.SelectedValue == "1" ? true : false;
            model.ClassName = this.txtClassName.Text;
            model.Identification = this.txtIDCard.Text;
            model.Telephone = this.txtPhone.Text;
            model.RoleId = Convert.ToInt32(this.ddlRole.SelectedValue);
            model.IsStop = 0;
            if (Request["type"] == "edit")
            {
                // 编辑
                model.Id = int.Parse(Request["id"].ToString());
                if (this.txtPassword.Text != "*******")
                {
                    // 密码被修改
                    model.Password = Common.MD5Helper.MD5Encrypt32(this.txtPassword.Text);
                }
                else
                {
                    // 未修改则为以前密码
                    model.Password = bll.getById(model.Id).Password;
                }
                int result = bll.edit(model);
                if (result > 0)
                {
                    goList();
                }
                else
                {
                    this.Message = "修改失败";
                }
            }
            else if (Request["type"] == "add")
            {
                // 新增
                model.Password = Common.MD5Helper.MD5Encrypt32(this.txtPassword.Text);
                int result = bll.add(model);
                if (result > 0)
                {
                    init();
                    this.Message = "添加学生成功";
                }
                else
                {
                    this.Message = "新增学生信息失败，请稍后再试";
                }
            }
        }

        private void init()
        {
            this.txtStudentNumber.Text = "";
            this.txtStudentName.Text = "";
            this.txtClassName.Text = "";
            this.txtIDCard.Text = "";
            this.txtPhone.Text = "";
            this.rblGender.SelectedIndex = 0;
            this.ddlRole.SelectedIndex = 0;
        }
    }
}