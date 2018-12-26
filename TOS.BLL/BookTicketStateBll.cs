using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TOS.DAL;

namespace TOS.BLL
{
    public class BookTicketStateBll
    {
        private BookTicketStateDal dal = new BookTicketStateDal();

        #region 作废票
        public bool disableTicket(int bookTicketInfoId)
        {
            return dal.disableTicket(bookTicketInfoId) > 0;
        }
        #endregion
    }
}
