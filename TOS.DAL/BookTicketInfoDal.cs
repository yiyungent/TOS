using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TOS.Model;
using System.Data;
using System.Data.SqlClient;

namespace TOS.DAL
{
    public class BookTicketInfoDal
    {
        public List<BookTicketInfoExModel> getList(params string[] conditions)
        {
            StringBuilder sb = new StringBuilder();
            sb.Append(@"SELECT bti.Id, TrainNumber, StartStation, EndStation, BookDate, StudentId, Phone, Remark, TicketSate
                          FROM dbo.BookTicketInfo bti
                          INNER JOIN dbo.BookTicketState bts
                          ON bti.Id=bts.BookTicketInfoId
                          WHERE 1=1");
            SqlParameter[] pars = conditionCon(conditions, sb);

            sb.Append(" ORDER BY BookDate DESC, TicketSate ASC");

            DataTable dt = MSSQL.query(sb.ToString(), pars);
            List<BookTicketInfoExModel> list = null;
            if (dt.Rows.Count > 0)
            {
                list = Utils.dataTable2List<BookTicketInfoExModel>(dt);
            }
            return list;
        }

        /// <summary>
        /// 注意:如果无条件则返回SqlParamter[] 为null
        /// </summary>
        /// <param name="conditions"></param>
        /// <param name="sb"></param>
        /// <returns></returns>
        private static SqlParameter[] conditionCon(string[] conditions, StringBuilder sb)
        {
            SqlParameter[] pars = null;
            if (conditions != null && conditions.Length > 0)
            {
                pars = new SqlParameter[conditions.Length];
                string condField = string.Empty, conOper = string.Empty, conValue = string.Empty;
                string[] conArr = new string[3];
                for (int i = 0; i < conditions.Length; i++)
                {
                    conArr = conditions[i].Split(new string[] { "=", "<", ">", "like" }, StringSplitOptions.RemoveEmptyEntries);
                    condField = conArr[0];
                    conValue = conArr[1];
                    conOper = conditions[i].Replace(condField, "").Replace(conValue, "");
                    SqlParameter par = new SqlParameter("@" + condField, conValue);
                    pars[i] = par;
                    sb.AppendFormat(" AND {0}{1}@{0}", condField, conOper);
                }
            }

            return pars;
        }

        #region 获取指定Id并且其订单所属人的Role所属Types为1的订单
        public BookTicketInfoExModel getByIdAndTypes1(int id)
        {
            string sql = @"SELECT bti.Id
                                ,TrainNumber
                                ,StartStation
                                ,EndStation
                                ,BookDate
                                ,StudentId
                                ,Phone
                                ,Remark
	                            ,TicketSate
                            FROM dbo.BookTicketInfo bti
                            INNER JOIN dbo.BookTicketState bts
                            ON bti.Id = bts.BookTicketInfoId
                            INNER JOIN dbo.Student s
                            ON bti.StudentId = s.Id
                            INNER JOIN dbo.SysRole sr
                            ON s.RoleId = sr.RoleId
                            WHERE Types = 1
                            AND bti.Id = @Id";
            SqlParameter par = new SqlParameter("@Id", SqlDbType.Int);
            par.Value = id;
            BookTicketInfoExModel model = null;
            DataTable dt = MSSQL.query(sql, par);
            if (dt.Rows.Count > 0)
            {
                model = Utils.dataTable2List<BookTicketInfoExModel>(dt)[0];
            }
            return model;
        }
        #endregion

        #region 指定Id更新
        public int updateModel(BookTicketInfoModel model)
        {
            string sql = @"UPDATE dbo.BookTicketInfo
                            SET TrainNumber = @TrainNumber
                                ,StartStation = @StartStation
                                ,EndStation = @EndStation
                                ,BookDate = @BookDate
                                ,Phone = @Phone
                                ,Remark = @Remark
                            WHERE Id = @Id";
            SqlParameter[] pars = new SqlParameter[] {
                new SqlParameter("@TrainNumber", SqlDbType.VarChar),
                new SqlParameter("@StartStation", SqlDbType.NVarChar),
                new SqlParameter("@EndStation", SqlDbType.NVarChar),
                new SqlParameter("@BookDate", SqlDbType.DateTime),
                new SqlParameter("@Phone", SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.NVarChar),
                new SqlParameter("@Id", SqlDbType.Int)
            };
            pars[0].Value = model.TrainNumber;
            pars[1].Value = model.StartStation;
            pars[2].Value = model.EndStation;
            pars[3].Value = model.BookDate;
            pars[4].Value = model.Phone;
            pars[5].Value = model.Remark;
            pars[6].Value = model.Id;
            // continuing
            int result = MSSQL.noQuery(sql, pars);
            return result;
        }
        #endregion

        #region 订票
        public int bookTicket(BookTicketInfoModel model, int lastOperatorId)
        {
            string procName = "proc_bookTicket";
            SqlParameter[] pars = new SqlParameter[] {
                new SqlParameter("@TrainNumber", SqlDbType.NVarChar),
                new SqlParameter("@StartStation", SqlDbType.NVarChar),
                new SqlParameter("@EndStation", SqlDbType.NVarChar),
                new SqlParameter("@BookDate", SqlDbType.DateTime),
                new SqlParameter("@StudentId", SqlDbType.Int),
                new SqlParameter("@Phone", SqlDbType.NVarChar),
                new SqlParameter("@Remark", SqlDbType.NText),
                new SqlParameter("@LastOperatorId", SqlDbType.Int)
            };
            pars[0].Value = model.TrainNumber;
            pars[1].Value = model.StartStation;
            pars[2].Value = model.EndStation;
            pars[3].Value = model.BookDate;
            pars[4].Value = model.StudentId;
            pars[5].Value = model.Phone;
            pars[6].Value = model.Remark;
            pars[7].Value = lastOperatorId;
            return MSSQL.ExecProcNonQuery(procName, pars);
        }
        #endregion
    }
}
