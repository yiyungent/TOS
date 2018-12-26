using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using TOS.Model;
using TOS.DAL;

namespace TOS.BLL
{
    public class LoginBll
    {
        public VwUserModel getByUserCodeAndPwd(string userCode, string password)
        {
            return new DAL.LoginDal().getByUserCodeAndPwd(userCode, password);
        }

        #region 用户登录
        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="model">传递有用户名和密码的实体，若存在此用户(登录成功),其实体对象将对带回</param>
        /// <returns>1:登录成功 -1:用户名或密码错误</returns>
        public int user_Login(VwUserModel model)
        {
            LoginDal dal = new LoginDal();
            VwUserModel userModel = dal.getByUserCodeAndPwd(model.UserCode, model.Password);
            int code = -1;
            if (userModel != null)
            {
                // 如果存在此用户，则将其赋值给形参，方便调用者获取此用户详细信息，利用引用类型特点
                // 注意，不能直接这样赋值，这样直接改变了一会形参的指针，不再指向实参，而是指向方法内 studentModel
                //model = studentModel;
                model.Id = userModel.Id;
                model.UserName = userModel.UserName;
                model.Telephone = userModel.Telephone;
                model.IdCard = userModel.IdCard;
                model.Gender = userModel.Gender;
                // 注意，返回的是加密后的密码
                model.Password = userModel.Password;
                model.Dept = userModel.Dept;
                model.RoleId = userModel.RoleId;
                // 标记存在此用户，密码
                code = 1;
            }
            return code;
        }
        #endregion
    }
}
