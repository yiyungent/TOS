using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class BookTicketPayModel
    {
        private int id;
        private double prePay;
        private double payMoney;
        private double ticketPrice;
        private int bookTicketInfoId;

        public int Id { get => id; set => id = value; }

        /// <summary>
        /// 预付款,定金
        /// </summary>
        public double PrePay { get => prePay; set => prePay = value; }

        /// <summary>
        /// PayMoney
        /// </summary>
        public double PayMoney { get => payMoney; set => payMoney = value; }

        /// <summary>
        /// TicketPrice
        /// </summary>
        public double TicketPrice { get => ticketPrice; set => ticketPrice = value; }

        /// <summary>
        /// BookTicketInfoId
        /// </summary>
        public int BookTicketInfoId { get => bookTicketInfoId; set => bookTicketInfoId = value; }
    }
}
