using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class BookTicketInfoExModel : BookTicketInfoModel
    {
        private int ticketSate;

        public int TicketSate { get => ticketSate; set => ticketSate = value; }
    }
}
