using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public enum Role
    {
        Student = 1,
        Teacher,
        TeacherManager,
        StudentManager
    }

    public class VwUserModel
    {
        private int id;
        private string userCode;
        private string userName;
        private string password;
        private bool gender;
        private string idCard;
        private string telephone;
        private string dept;
        private int roleId;

        public int Id { get => id; set => id = value; }
        public string UserCode { get => userCode; set => userCode = value; }
        public string UserName { get => userName; set => userName = value; }
        public string Password { get => password; set => password = value; }
        public bool Gender { get => gender; set => gender = value; }
        public string IdCard { get => idCard; set => idCard = value; }
        public string Telephone { get => telephone; set => telephone = value; }
        public string Dept { get => dept; set => dept = value; }
        public int RoleId { get => roleId; set => roleId = value; }
    }
}
