using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

using TOS.BLL;
using TOS.Model;
using System.Text;


namespace TOS.Web.Admin
{
    public partial class StudentList : Account.LoginState
    {
        private StudentBll bll = new StudentBll();

        public List<StudentExModel> List;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (this.loginStateCheck())
            {
                if (((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.StudentManager)|| ((VwUserModel)Session["User"]).RoleId == Convert.ToInt32(Role.TeacherManager))
                {
                    dataBind();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "roleErrorJs", "<script>alert('当前页面需要学生管理员角色')</script>");
                    this.pShow.Visible = false;
                    this.pError.Visible = true;
                }
            }
            else
            {
                Response.Redirect("/Account/Login.aspx");
            }
        }

        #region 数据绑定
        private void dataBind()
        {
            // 注意：由于是 html 控件，非TextBox,使用的是 Value属性来获取输入值
            string studentNumber = this.txtStudentNumber.Value.Trim();
            string studentName = this.txtStudentName.Value.Trim();
            string className = this.txtClassName.Value.Trim();
            // 获取数据
            this.List = bll.getList(studentNumber, studentName, className);
            this.gvStudent.DataSource = List;
            // 设置主键列
            this.gvStudent.DataKeyNames = new string[] { "Id" };
            // 记住一定要绑定数据
            this.gvStudent.DataBind();
        }
        #endregion

        #region 换页
        protected void gvStudent_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            this.gvStudent.PageIndex = e.NewPageIndex;
            // 换页为重新查询数据，所以要重新绑定
            this.gvStudent.DataBind();
        }
        #endregion

        #region 点击查询
        protected void lbQuery_Click(object sender, EventArgs e)
        {
            dataBind();
        }
        #endregion

        #region 删除单行
        /// <summary>
        /// 设置 LinkButton 的CommandName="Delete"后，点击它时会自动触发GridView的RowDeleting事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void gvStudent_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // 获取引起这个事件(e)（即点击删除的此行）行的Key为Id的值，即Id序号
            string id = e.Keys["Id"].ToString();
            if (bll.batchDel(id) > 0)
            {
                // 第四个参数指示追加 script标签，这样第三个参数就无需<script></script>
                // 奇怪，没弹出提示???????????
                //ClientScript.RegisterStartupScript(this.GetType(), "delSuccessJs", $"alert('成功删除Id为{id}'的记录)", true);
                // 还是没弹出?????
                ClientScript.RegisterStartupScript(this.GetType(),"delSuccessJs",$"<script>alert('成功删除Id为{id}'的记录)</script>");
            }
            else
            {
                ClientScript.RegisterStartupScript(this.GetType(), "delFailJs", "<script>alert('删除失败，请稍后再试')</script>");
            }
            dataBind();
        }
        #endregion

        #region 批量删除
        protected void lbBatchDel_Click(object sender, EventArgs e)
        {
            StringBuilder ids = new StringBuilder();
            // 遍历每行，并找到每行的第一个单元格且id为 chkitem的控件
            foreach (GridViewRow row in this.gvStudent.Rows
                )
            {
                CheckBox cb = (CheckBox)row.Cells[0].FindControl("chkitem");
                // 若被选中，则将其行的id序号放入
                if (cb.Checked) ids.Append(this.gvStudent.DataKeys[row.RowIndex].Value.ToString() + ",");
            }
            if (ids.Length == 0)
            {
                RegisterStartupScript("tips", "<script>alert('请选择需要删除的记录')</script>");
                return;
            }
            //if (ids.Length > 0)
            // 这样，更好，因为当即使只有一个 ，也会由于在后面会添加"," 而Length>1, eg. "4,"
            // 防止 ","
            if (ids.Length > 1)
            {
                if (bll.batchDel(ids.Remove(ids.Length - 1, 1).ToString()) > 0)
                {
                    // 删除成功
                    ClientScript.RegisterStartupScript(this.GetType(), "batchDelSuccessJs", $"<script>alert('成功删除Id为{ids.ToString()}的记录')</script>");
                    dataBind();
                }
                else
                {
                    ClientScript.RegisterStartupScript(this.GetType(), "batchDelFailJs", "<script>alert('删除失败')</script>");
                }
            }
        }
        #endregion
    }
}