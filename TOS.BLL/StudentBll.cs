using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TOS.DAL;
using TOS.Model;
using TOS.Common;
using System.Data;

namespace TOS.BLL
{
    public class StudentBll
    {
        private StudentDal dal = new StudentDal();

        public int add(StudentModel model)
        {
            return dal.insert(model);
        }

        #region 用户登录
        /// <summary>
        /// 用户登录
        /// </summary>
        /// <param name="model">传递有用户名和密码的实体，若存在此用户(登录成功),其实体对象将对带回</param>
        /// <returns>1:登录成功 -1:用户名或密码错误</returns>
        public int student_Login(StudentModel model)
        {
            //StudentModel studentModel = dal.getByNumberAndPwd(model);
            StudentModel userModel = dal.student_GeyByNumberAndName(model);
            int code = -1;
            if (userModel != null)
            {
                // 如果存在此用户，则将其赋值给形参，方便调用者获取此用户详细信息，利用引用类型特点
                // 注意，不能直接这样赋值，这样直接改变了一会形参的指针，不再指向实参，而是指向方法内 studentModel
                //model = studentModel;
                model.StudentName = userModel.StudentName;
                model.Telephone = userModel.Telephone;
                model.Identification = userModel.Identification;
                model.Gender = userModel.Gender;
                // 注意，返回的是加密后的密码
                model.Password = userModel.Password;
                model.ClassName = userModel.ClassName;
                code = 1;
            }
            return code;
        }
        #endregion

        #region 获取所有
        /// <summary>
        /// 获取所有
        /// </summary>
        /// <returns></returns>
        public DataTable user_GetAll()
        {
            return dal.user_GetAll();
        }
        #endregion

        #region 查询学习信息列表
        public List<StudentExModel> getList(string studentNumber, string studentName, string className)
        {
            return dal.getList(studentNumber, studentName, className);
        }
        #endregion

        #region 通过学号和姓名获取用户
        /// <summary>
        /// 通过学号和姓名获取用户
        /// </summary>
        /// <param name="model"></param>
        /// <returns></returns>
        public StudentModel student_GetByNumberAndName(StudentModel model)
        {
            return dal.student_GeyByNumberAndName(model);
        }
        #endregion

        #region 通过学生Id获取
        public StudentModel getById(int id)
        {
            return dal.getById(id);
        }
        #endregion;

        #region 批量删除
        public int batchDel(string ids)
        {
            return dal.batchDel(ids);
        }
        #endregion

        public int edit(StudentModel model)
        {
            return dal.update(model);
        }

        #region 获取学生信息根据指定Id且Types为1
        //public StudentModel getByIdAndTypes1(int id)
        //{
        //    return dal.getByIdAndTypes1(id);
        //}
        #endregion
    }
}
