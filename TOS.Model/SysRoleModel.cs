using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class SysRoleModel
    {
        private int roleId;
        private string roleName;
        private int isStop;
        private int types;

        public int RoleId { get => roleId; set => roleId = value; }
        public string RoleName { get => roleName; set => roleName = value; }
        public int IsStop { get => isStop; set => isStop = value; }
        public int Types { get => types; set => types = value; }
    }
}
