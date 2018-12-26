using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class StudentModel
    {
        private int id;
        private string studentNumber;
        private string studentName = "无匹配数据";
        private string password;
        private bool gender;
        private string identification;
        private string telephone;
        private string className;
        private int roleId;
        private int isStop;

        public int Id { get => id; set => id = value; }
        public string StudentNumber { get => studentNumber; set => studentNumber = value; }
        public string StudentName { get => studentName; set => studentName = value; }
        public string Password { get => password; set => password = value; }
        public bool Gender { get => gender; set => gender = value; }
        public string Identification { get => identification; set => identification = value; }
        public string Telephone { get => telephone; set => telephone = value; }
        public string ClassName { get => className; set => className = value; }
        public int RoleId { get => roleId; set => roleId = value; }
        public int IsStop { get => isStop; set => isStop = value; }
    }
}
