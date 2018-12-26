using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Configuration;
using System.Data;
using System.Data.SqlClient;

namespace TOS.DAL
{
    public class MSSQL
    {
        /// <summary>
        /// 连接字符串
        /// </summary>
        private static string conStr = ConfigurationManager.ConnectionStrings["conStr"].ConnectionString;

        #region 查询
        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="sql">查询SQL</param>
        /// <returns>DataTable</returns>
        public static DataTable query(string sql)
        {
            using (SqlConnection con = new SqlConnection(conStr))
            {
                SqlDataAdapter sda = new SqlDataAdapter(sql, con);
                DataTable dt = new DataTable();
                sda.Fill(dt);
                return dt;
            }
        }

        public static DataTable query(string sql, params SqlParameter[] pars)
        {
            using (SqlDataAdapter adapter = new SqlDataAdapter(sql, conStr))
            {
                adapter.SelectCommand.CommandType = CommandType.Text;
                DataTable dt = new DataTable();
                adapter.SelectCommand.CommandText = sql;
                if (pars != null)
                {
                    adapter.SelectCommand.Parameters.AddRange(pars);
                }
                adapter.Fill(dt);
                return dt;
            }
        }
        #endregion

        #region 非查询
        /// <summary>
        /// 非查询
        /// </summary>
        /// <param name="sql">非查询SQL</param>
        /// <returns>受影响的条数</returns>
        public static int noQuery(string sql)
        {
            int result = -1;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand com = new SqlCommand(sql, con);
                result = com.ExecuteNonQuery();
                return result;
            }
        }

        public static int noQuery(string sql, params SqlParameter[] pars)
        {
            int result = -1;
            using (SqlConnection con = new SqlConnection(conStr))
            {
                con.Open();
                SqlCommand com = new SqlCommand(sql, con);
                com.Parameters.AddRange(pars);
                result = com.ExecuteNonQuery();
                return result;
            }
        }
        #endregion

        #region 执行存储过程-非查询
        public static int ExecProcNonQuery(string procName, params SqlParameter[] pars)
        {
            using (SqlConnection conn = new SqlConnection(conStr))
            {
                conn.Open();
                SqlCommand cmd = conn.CreateCommand();
                cmd.CommandType = CommandType.StoredProcedure;
                cmd.CommandText = procName;
                cmd.Parameters.AddRange(pars);
                return cmd.ExecuteNonQuery();
            }
        }
        #endregion
    }
}
