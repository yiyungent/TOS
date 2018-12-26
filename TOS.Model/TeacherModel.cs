using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class TeacherModel
    {
        private int id;
        private string teacherNumber;
        private string teacherName;
        private string password;
        private bool gender;
        private string identification;
        private string telephone;
        private string department;

        public int Id { get => id; set => id = value; }

        /// <summary>
        /// 员工号
        /// </summary>
        public string TeacherNumber { get => teacherNumber; set => teacherNumber = value; }

        /// <summary>
        /// 教师姓名
        /// </summary>
        public string TeacherName { get => teacherName; set => teacherName = value; }

        /// <summary>
        /// 密码
        /// </summary>
        public string Password { get => password; set => password = value; }

        /// <summary>
        /// 性别
        /// </summary>
        public bool Gender { get => gender; set => gender = value; }

        /// <summary>
        /// 身份证号
        /// </summary>
        public string Identification { get => identification; set => identification = value; }

        /// <summary>
        /// 电话号码
        /// </summary>
        public string Telephone { get => telephone; set => telephone = value; }

        /// <summary>
        /// 部门(系部)
        /// </summary>
        public string Department { get => department; set => department = value; }
    }
}
