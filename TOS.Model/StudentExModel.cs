using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class StudentExModel : StudentModel
    {
        private string sex;

        public string Sex { get => sex; set => sex = value; }

        private string roleName;

        public string RoleName { get => roleName; set => roleName = value; }

        //private int id;

        //public int Id { get => id; set => id = value; }

    }
}
