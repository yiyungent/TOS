using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TOS.DAL;
using TOS.Model;

namespace TOS.BLL
{
    public class SysFunctionBll
    {
        private SysFunctionDal dal = new SysFunctionDal();

        #region 获取所有
        /// <summary>
        /// 获取所有记录实体
        /// </summary>
        /// <returns></returns>
        public List<SysFunctionModel> getAll()
        {
            return dal.getAll();
        }
        #endregion

        public List<SysFunctionModel> getByRoleId(int roleId)
        {
            return dal.getByRoleId(roleId);
        }
    }
}
