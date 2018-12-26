using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TOS.DAL;
using TOS.Model;

namespace TOS.BLL
{
    public class SysRoleBll
    {
        private SysRoleDal dal = new SysRoleDal();

        public List<SysRoleModel> getByTypes(string types)
        {
            return dal.getByTypes(types);
        }
    }
}
