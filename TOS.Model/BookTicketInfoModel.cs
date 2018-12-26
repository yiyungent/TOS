using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class BookTicketInfoModel
    {
        private int id;
        private string trainNumber;
        private string startStation;
        private string endStation;
        private DateTime bookDate;
        private int studentId;
        private string phone;
        private string remark;

        public int Id { get => id; set => id = value; }

        /// <summary>
        /// 车次
        /// </summary>
        public string TrainNumber { get => trainNumber; set => trainNumber = value; }

        /// <summary>
        /// 起点站
        /// </summary>
        public string StartStation { get => startStation; set => startStation = value; }

        /// <summary>
        /// 终点站
        /// </summary>
        public string EndStation { get => endStation; set => endStation = value; }

        /// <summary>
        /// 预定时间
        /// </summary>
        public DateTime BookDate { get => bookDate; set => bookDate = value; }

        /// <summary>
        /// 学生ID
        /// </summary>
        public int StudentId { get => studentId; set => studentId = value; }

        /// <summary>
        /// 联系方式
        /// </summary>
        //[Expression]
        public string Phone { get => phone; set => phone = value; }

        /// <summary>
        /// 备注
        /// </summary>
        public string Remark { get => remark; set => remark = value; }
    }
}
