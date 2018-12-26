using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using TOS.Model;
using System.Data.SqlClient;

namespace TOS.DAL
{
    public class SysFunctionDal
    {
        #region DataTableToList
        /// <summary>
        /// DataTable To List<SysFunctionModel>
        /// </summary>
        /// <param name="dt"></param>
        /// <returns></returns>
        private List<SysFunctionModel> dataTableToList(DataTable dt)
        {
            List<SysFunctionModel> list = new List<SysFunctionModel>();
            foreach (DataRow row in dt.Rows)
            {
                SysFunctionModel model = new SysFunctionModel();
                if (row["Id"] != DBNull.Value && !string.IsNullOrEmpty(row["Id"].ToString()))
                {
                    model.Id = Convert.ToInt32(row["Id"]);
                }
                if (row["MenuName"] != DBNull.Value && !string.IsNullOrEmpty(row["MenuName"].ToString()))
                {
                    model.MenuName = row["MenuName"].ToString();
                }
                if (row["Url"] != DBNull.Value && !string.IsNullOrEmpty(row["Url"].ToString()))
                {
                    model.Url = row["Url"].ToString();
                }
                if (row["IsStop"] != DBNull.Value && !string.IsNullOrEmpty(row["IsStop"].ToString()))
                {
                    model.IsStop = Convert.ToInt32(row["IsStop"]);
                }
                if (row["SortNo"] != DBNull.Value && !string.IsNullOrEmpty(row["SortNo"].ToString()))
                {
                    model.SortNo = Convert.ToInt32(row["SortNo"]);
                }
                list.Add(model);
            }
            return list;
        }
        #endregion

        #region 获取所有记录
        /// <summary>
        /// 获取所有记录实体
        /// </summary>
        /// <returns></returns>
        public List<SysFunctionModel> getAll()
        {
            string sql = "select Id,MenuName,Url,SortNo from SysFunction where IsStop=0 order by SortNo";
            DataTable dt = MSSQL.query(sql);
            List<SysFunctionModel> list = null;
            if (dt.Rows.Count > 0)
            {
                //list = dataTableToList(dt);
                list = Utils.dataTable2List<SysFunctionModel>(dt);
            }
            return list;
        }
        #endregion

        public List<SysFunctionModel> getByRoleId(int roleId)
        {
            string sql = @"select Id,MenuName,Url,SortNo 
            from SysFunction f
            join SysRoleFunction rf on f.Id = rf.FuncId
            where IsStop = 0 and RoleId = @RoleId
            order by SortNo";
            SqlParameter par = new SqlParameter("@RoleId", SqlDbType.Int);
            par.Value = roleId;
            DataTable dt = MSSQL.query(sql, par);
            if (dt.Rows.Count > 0)
                return Utils.dataTable2List<SysFunctionModel>(dt);
            else
                return null;
        }
    }
}
