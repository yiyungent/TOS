using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using TOS.Model;
using System.Data.SqlClient;

namespace TOS.DAL
{
    public class LoginDal
    {
        public VwUserModel getByUserCodeAndPwd(string userCode, string password)
        {
            //string sql = $@"SELECT Id
            //            , UserCode
            //            , UserName
            //            , Password
            //            , Gender
            //            , IDCard
            //            , Telephone
            //            , Dept
            //            , RoleId
            //            FROM vw_userInfo where UserCode='{userCode}' AND Password='{password}'";
            string sql = @"SELECT Id
                        , UserCode
                        , UserName
                        , Password
                        , Gender
                        , IDCard
                        , Telephone
                        , Dept
                        , RoleId
                        FROM vw_userInfo where UserCode=@UserCode AND Password=@Password";
            // 注意，不要再给参数加 引号 ''，因为最后程序会为参数值加''
            // 错误: UserCode='@UserCode'
            #region 参数化后执行SQL
            //exec sp_executesql N'SELECT Id
            //            , UserCode
            //            , UserName
            //            , Password
            //            , Gender
            //            , IDCard
            //            , Telephone
            //            , Dept
            //            , RoleId
            //            FROM vw_userInfo where UserCode = @UserCode AND Password = @Password',N'@UserCode nvarchar(50),@Password nvarchar(50)',@UserCode=N'170010347',@Password=N'21232f297a57a5a743894a0e4a801fc3'
            #endregion
            SqlParameter[] pars = new SqlParameter[]
            {
                new SqlParameter("@UserCode", SqlDbType.NVarChar, 50),
                new SqlParameter("@Password", SqlDbType.NVarChar, 50)
            };
            pars[0].Value = userCode;
            pars[1].Value = password;
            DataTable dt = MSSQL.query(sql, pars);
            VwUserModel model = null;
            if (dt.Rows.Count > 0)
            {
                model = Utils.dataTable2List<VwUserModel>(dt)[0];
            }
            return model;
        }
    }
}
