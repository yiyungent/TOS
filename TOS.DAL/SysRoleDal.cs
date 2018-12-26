using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TOS.Model;
using System.Data.SqlClient;
using System.Data;

namespace TOS.DAL
{
    public class SysRoleDal
    {

        /// <summary>
        /// 根据类型获取相关角色
        /// </summary>
        /// <param name="types"></param>
        /// <returns></returns>
        public List<SysRoleModel> getByTypes(string types)
        {
            string sql = "select RoleId, RoleName, IsStop, Types from SysRole where Types=@Types";
            SqlParameter par = new SqlParameter("@Types", SqlDbType.Int);
            par.Value = types;
            DataTable dt = MSSQL.query(sql, par);
            List<SysRoleModel> list = null;
            if (dt.Rows.Count > 0)
            {
                list = Utils.dataTable2List<SysRoleModel>(dt);
            }
            return list;
        }
    }
}
