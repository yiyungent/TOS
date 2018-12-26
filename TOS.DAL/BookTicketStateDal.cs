using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data.SqlClient;

namespace TOS.DAL
{
    public class BookTicketStateDal
    {
        #region 作废票
        public int disableTicket(int bookTicketInfoId)
        {
            string sql = "update BookTicketState set TicketSate = 0 where BookTicketInfoId = @BookTicketInfoId";
            SqlParameter par = new SqlParameter("@BookTicketInfoId", System.Data.SqlDbType.Int);
            par.Value = bookTicketInfoId;
            return MSSQL.noQuery(sql, par);
        } 
        #endregion
    }
}
