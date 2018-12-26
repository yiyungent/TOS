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
    public partial class ApplyBookTicket : Account.LoginState
    {
        private BookTicketInfoBll bookTicketInfoBll = new BookTicketInfoBll();

        private BookTicketInfoExModel model = null;

        public string Message { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (loginStateCheck())
            {
                //if (((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.StudentManager))
                if (((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.Student)|| ((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.StudentManager))
                {
                    if (!IsPostBack)
                    {
                        string type = Request["type"];
                        if (type == "edit")
                        {
                            // 编辑 订票信息
                            if (int.TryParse(Request["id"], out int id))
                            {
                                // 载入该订票信息
                                loadBookTicketInfo(id);
                            }
                        }
                    }
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "roleErrorJs", "alert('权限不足')", true);
                    this.pShow.Visible = false;
                    this.pError.Visible = true;
                }
            }
        }

        private void loadBookTicketInfo(int id)
        {
            this.model = this.bookTicketInfoBll.getByIdAndTypes1(id);
            if (model != null)
            {
                this.txtTrainNumber.Text = this.model.TrainNumber;
                this.txtStartStation.Text = this.model.StartStation;
                this.txtEndStation.Text = this.model.EndStation;
                this.txtBookDate.Text = this.model.BookDate.ToString("yyyy-MM-dd");
                this.txtPhone.Text = this.model.Phone;
                this.txtRemark.Text = this.model.Remark;
                this.txtState.Text = this.model.TicketSate.ToString();
            }
            else
            {
                this.Message = "不存在此普通学生及学生管理员";
            }
        }

        #region 点击撤销
        protected void btnCancel_Click(object sender, EventArgs e)
        {
            Response.Redirect("BookTicketList.aspx");
        }
        #endregion

        #region 点击保存
        protected void btnSave_Click(object sender, EventArgs e)
        {
            this.model = new BookTicketInfoExModel();
            this.model.TrainNumber = this.txtTrainNumber.Text.Trim();
            this.model.StartStation = this.txtStartStation.Text.Trim();
            this.model.EndStation = this.txtEndStation.Text.Trim();
            if (DateTime.TryParse(this.txtBookDate.Text.Trim(), out DateTime bookDate))
            {
                this.model.BookDate = bookDate;
            }
            else
            {
                this.Message = "预定日期格式不正确";
                return;
            }
            this.model.Phone = this.txtPhone.Text.Trim();
            this.model.Remark = this.txtRemark.Text.Trim();

            if (Request["type"] == "add")
            {
                // 新增
                // 获取当前登录账户
                VwUserModel vwUserModel = (VwUserModel)Session["User"];
                // 当前登录学生的票，所以该页面只允许普通学生或学生管理员登录
                model.StudentId = vwUserModel.Id;
                // 最后的操作人这里也算作 该申请学生
                if (bookTicketInfoBll.bookTicket(model, vwUserModel.Id))
                {
                    this.Message = "订票成功";
                    initControl();
                }
                else
                {
                    this.Message = "订票失败";
                }
            }
            else if (Request["type"] == "edit")
            {
                // 编辑
                this.model.Id = Convert.ToInt32(Request["id"]);
                if (bookTicketInfoBll.editModel(model) > 0)
                {
                    Response.Redirect("BookTicketList.aspx");
                }
                else
                {
                    this.Message = "修改失败，请稍后再试";
                }
            }
        }
        #endregion

        public void initControl()
        {
            this.txtTrainNumber.Text = "";
            this.txtStartStation.Text = "";
            this.txtEndStation.Text = "";
            this.txtBookDate.Text = "";
            this.txtPhone.Text = "";
            this.txtRemark.Text = "";
        }
    }
}