using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class BookTicketStateModel
    {
        private int id;
        private int ticketSate;
        private int bookTicketInfoId;
        private DateTime sureDate;
        private DateTime arriveDate;
        private DateTime gotDate;
        private int lastOperatorId;

        public int Id { get => id; set => id = value; }

        /// <summary>
        /// 票的状态
        /// </summary>
        public int TicketSate { get => ticketSate; set => ticketSate = value; }

        /// <summary>
        /// 订票信息ID
        /// </summary>
        public int BookTicketInfoId { get => bookTicketInfoId; set => bookTicketInfoId = value; }

        /// <summary>
        /// 确认时间
        /// </summary>
        public DateTime SureDate { get => sureDate; set => sureDate = value; }

        /// <summary>
        /// 到票时间
        /// </summary>
        public DateTime ArriveDate { get => arriveDate; set => arriveDate = value; }

        /// <summary>
        /// 领票时间
        /// </summary>
        public DateTime GotDate { get => gotDate; set => gotDate = value; }

        /// <summary>
        /// 最后操作员Id
        /// </summary>
        public int LastOperatorId { get => lastOperatorId; set => lastOperatorId = value; }
    }
}
