using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Data;
using TOS.Model;
using System.Data.SqlClient;

namespace TOS.DAL
{
    public class StudentDal
    {
        #region 插入学生
        public int insert(StudentModel model)
        {
            // ？？问题记录：
            string sql = "insert into Student(StudentNumber, StudentName, Password, Gender, Identification, Telephone, ClassName, RoleId, IsStop) values(@StudentNumber, @StudentName, @Password, @Gender, @Identification, @Telephone, @ClassName, @RoleId, 0)";
            SqlParameter[] pars = new SqlParameter[]
            {
                new SqlParameter("@StudentNumber", SqlDbType.NVarChar),
                new SqlParameter("@StudentName", SqlDbType.NVarChar),
                new SqlParameter("@Password", SqlDbType.NVarChar),
                new SqlParameter("@Gender", SqlDbType.Bit),
                new SqlParameter("@Identification", SqlDbType.NVarChar),
                new SqlParameter("@Telephone", SqlDbType.NVarChar),
                new SqlParameter("@ClassName", SqlDbType.NVarChar),
                new SqlParameter("@RoleId", SqlDbType.Int)
            };
            pars[0].Value = model.StudentNumber;
            pars[1].Value = model.StudentName;
            pars[2].Value = model.Password;
            pars[3].Value = model.Gender;
            pars[4].Value = model.Identification;
            pars[5].Value = model.Telephone;
            pars[6].Value = model.ClassName;
            pars[7].Value = model.RoleId;
            return MSSQL.noQuery(sql, pars);
        }
        #endregion

        #region 通过学号和密码查找学生
        /// <summary>
        /// 通过学号和密码查找学生
        /// </summary>
        /// <param name="model">含有学号和密码的学生实体</param>
        /// <returns>如果无此用户则返回null，否则返回此人实体信息</returns>
        public StudentModel getByNumberAndPwd(StudentModel model)
        {
            string sql = string.Format("select * from Student where StudentNumber='{0}' and Password='{1}'", model.StudentNumber, model.Password);
            DataTable dt = MSSQL.query(sql);
            StudentModel studentModel = null;
            if (dt.Rows.Count > 0)
            {
                studentModel = DataTableToList(dt)[0];
            }
            return studentModel;
        }
        #endregion

        #region 获取所有记录
        /// <summary>
        /// 获取所有记录
        /// </summary>
        /// <returns></returns>
        public DataTable user_GetAll()
        {
            string sql = "select * from Student";
            return MSSQL.query(sql);
        }
        #endregion

        #region 通过学号和姓名获取学生
        /// <summary>
        /// 通过学号和姓名获取学生
        /// </summary>
        /// <param name="model">含有学号和学生姓名的实体</param>
        /// <returns>符合学号和姓名要求的记录</returns>
        public StudentModel student_GeyByNumberAndName(StudentModel model)
        {
            string sql = "select * from Student where 1=1 ";
            if (!string.IsNullOrEmpty(model.StudentNumber))
            {
                sql += $" and StudentNumber='{model.StudentNumber}'";
            }
            if (!string.IsNullOrEmpty(model.StudentName))
            {
                sql += $" and StudentName like '%{model.StudentName}%'";
            }

            return Utils.dataTable2List<StudentModel>(MSSQL.query(sql))[0];
        }
        #endregion

        #region 查询学生信息列表
        public List<StudentExModel> getList(string studentNumber, string studentName, string className)
        {
            StringBuilder sb = new StringBuilder();
            // 注意：这样联合 SysRole表 查询，会导致无 角色的学生无法查出
            // 注意：N'女' 指定为符合中文，因为在实际部署后发现存在乱码问题，迁移数据时也容易中文变成问好????，这种别名输出居然也会导致???，加上N''即可
            sb.Append("select Id,StudentNumber,StudentName,case when Gender='0' then N'女' else N'男' end Sex,Identification, Telephone,ClassName,RoleName");
            sb.Append(" from Student a");
            sb.Append(" join SysRole b");
            sb.Append(" on a.RoleId = b.RoleId");
            sb.Append(" where a.IsStop = 0");
            if (!string.IsNullOrEmpty(studentNumber))
            {
                sb.AppendFormat(" and a.StudentNumber = '{0}'", studentNumber);
            }
            if (!string.IsNullOrEmpty(studentName))
            {
                sb.AppendFormat(" and a.StudentName like '%{0}%'", studentName);
            }
            if (!string.IsNullOrEmpty(className))
            {
                sb.AppendFormat(" and a.ClassName = '{0}'", className);
            }
            sb.Append(" order by Id desc");
            List<StudentExModel> list = Utils.dataTable2List<StudentExModel>(MSSQL.query(sb.ToString()));
            // 防止无记录时，gridView不显示表头，添加一行空记录以在无数据时显示表头
            if (list.Count == 0) list.Add(new StudentExModel());
            return list;
        }
        #endregion

        #region 通过学生Id获取
        public StudentModel getById(int id)
        {
            string sql = @"SELECT Id
                          , StudentNumber
                          , StudentName
                          , Password
                          , Gender
                          , Identification
                          , Telephone
                          , ClassName
                          , Password
                          , RoleId
                          , IsStop
                     FROM dbo.Student
                     WHERE Id=@Id";
            SqlParameter par = new SqlParameter("Id", SqlDbType.Int);
            par.Value = id;
            DataTable dt = MSSQL.query(sql, par);
            StudentModel model = null;
            if (dt.Rows.Count > 0)
            {
                model = Utils.dataTable2List<StudentModel>(dt)[0];
            }
            return model;
        }
        #endregion

        #region DataTableToList
        private List<StudentModel> DataTableToList(DataTable dt)
        {
            List<StudentModel> list = new List<StudentModel>();
            foreach (DataRow row in dt.Rows)
            {
                StudentModel model = new StudentModel();
                if (row["StudentNumber"] != DBNull.Value && !string.IsNullOrEmpty(row["StudentNumber"].ToString()))
                {
                    model.StudentNumber = row["StudentNumber"].ToString();
                }
                if (row["StudentName"] != DBNull.Value && !string.IsNullOrEmpty(row["StudentName"].ToString()))
                {
                    model.StudentName = row["StudentName"].ToString();
                }
                if (row["Password"] != DBNull.Value && !string.IsNullOrEmpty(row["Password"].ToString()))
                {
                    model.Password = row["Password"].ToString();
                }
                if (row["Gender"] != DBNull.Value && !string.IsNullOrEmpty(row["Gender"].ToString()))
                {
                    model.Gender = Convert.ToBoolean(row["Gender"]);
                }
                if (row["Identification"] != DBNull.Value && !string.IsNullOrEmpty(row["Identification"].ToString()))
                {
                    model.Identification = row["Identification"].ToString();
                }
                if (row["Telephone"] != DBNull.Value && !string.IsNullOrEmpty(row["Telephone"].ToString()))
                {
                    model.Telephone = row["Telephone"].ToString();
                }
                if (row["ClassName"] != DBNull.Value && !string.IsNullOrEmpty(row["ClassName"].ToString()))
                {
                    model.ClassName = row["ClassName"].ToString();
                }

                list.Add(model);
            }
            return list;
        }
        #endregion

        #region 批量删除
        /// <summary>
        /// 批量删除
        /// </summary>
        /// <param name="ids">1,2,4,6</param>
        /// <returns></returns>
        public int batchDel(string ids)
        {
            // where in 参数化
            // 参考 https://www.cnblogs.com/lymi/p/4279978.html
            string sql = "update Student set IsStop = 1 where Id in ";
            string[] idArr = ids.Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries);
            SqlParameter[] pars = new SqlParameter[idArr.Length];
            StringBuilder sb = new StringBuilder("(");
            for (int i = 0; i < idArr.Length; i++)
            {
                // (@id1,@id2,@id3,
                sb.Append("@id" + (i + 1) + ",");
                // 勿忘new 每个参数对象，不能为par直接赋值,因为他们还为 null
                // 这也是对象的区别，也可以直接将一个SqlParameter赋值过去, eg. pars[i] = parObj;
                // 但直接为对象的属性赋值并不会创建对象
                pars[i] = new SqlParameter();
                pars[i].ParameterName = "@id" + (i + 1);
                pars[i].Value = idArr[i];
            }
            // (@id1,@id2,@id3
            sb.Remove(sb.Length - 1, 1);
            // (@id1,@id2,@id3)
            sb.Append(")");
            sql += sb.ToString();
            return MSSQL.noQuery(sql, pars);
        }
        #endregion

        #region 修改学生信息
        public int update(StudentModel model)
        {
            string sql = @"UPDATE dbo.Student
                            SET StudentNumber = @StudentNumber
                                ,StudentName = @StudentName
                                ,Gender = @Gender
                                ,Identification = @Identification
                                ,Telephone = @Telephone
                                ,ClassName = @ClassName
                                ,Password = @Password
                                ,RoleId = @RoleId
                            WHERE Id=@Id";
            SqlParameter[] pars = new SqlParameter[]
            {
                new SqlParameter("@StudentNumber", SqlDbType.NVarChar),
                new SqlParameter("@StudentName", SqlDbType.NVarChar),
                new SqlParameter("@Gender", SqlDbType.Bit),
                new SqlParameter("@Identification", SqlDbType.NVarChar),
                new SqlParameter("@Telephone", SqlDbType.NVarChar),
                new SqlParameter("@ClassName", SqlDbType.NVarChar),
                new SqlParameter("@Password", SqlDbType.NVarChar),
                new SqlParameter("@RoleId", SqlDbType.Int),
                new SqlParameter("@Id", SqlDbType.Int),
            };
            pars[0].Value = model.StudentNumber;
            pars[1].Value = model.StudentName;
            pars[2].Value = model.Gender;
            pars[3].Value = model.Identification;
            pars[4].Value = model.Telephone;
            pars[5].Value = model.ClassName;
            pars[6].Value = model.Password;
            pars[7].Value = model.RoleId;
            pars[8].Value = model.Id;
            return MSSQL.noQuery(sql, pars);
        }
        #endregion

        #region 获取学生信息根据指定Id且Types为1
        //public StudentModel getByIdAndTypes1(int id)
        //{
        //    string sql = @"SELECT Id
        //                          ,StudentNumber
        //                          ,StudentName
        //                          ,Password
        //                          ,Gender
        //                          ,Identification
        //                          ,Telephone
        //                          ,ClassName
        //                          ,s.RoleId
        //                          ,s.IsStop
        //                      FROM dbo.Student s
        //                      INNER JOIN SysRole r
        //                      on s.RoleId = r.RoleId
        //                      WHERE Types=1
        //                      AND s.Id=@Id";
        //    SqlParameter par = new SqlParameter("@Id", SqlDbType.Int);
        //    par.Value = id;
        //    StudentModel model = null;
        //    DataTable dt = MSSQL.query(sql, par);
        //    if (dt.Rows.Count > 0)
        //    {
        //        model = Utils.dataTable2List<StudentModel>(dt)[0];
        //    }
        //    return model;
        //}
        #endregion
    }
}
