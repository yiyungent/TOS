using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using TOS.Model;
using TOS.DAL;

namespace TOS.BLL
{
    public class BookTicketInfoBll
    {
        private BookTicketInfoDal dal = new BookTicketInfoDal();

        public List<BookTicketInfoExModel> getList(params string[] conditions)
        {
            #region 在服务端实现无记录时仍然显示表格并给出提示
            //List<BookTicketInfoExModel> list = dal.getList(conditions);
            //if (list == null)
            //{
            //    list = new List<BookTicketInfoExModel>();
            //    list.Add(new BookTicketInfoExModel() { Remark = "未查询到数据" });
            //}
            //return list; 
            #endregion
            return dal.getList(conditions);
        }

        #region 获取指定Id并且其订单所属人的Role所属Types为1的订单
        public BookTicketInfoExModel getByIdAndTypes1(int id)
        {
            return dal.getByIdAndTypes1(id);
        }
        #endregion

        #region 指定Id更新
        public int editModel(BookTicketInfoModel model)
        {
            return dal.updateModel(model);
        }
        #endregion

        #region 订票
        public bool bookTicket(BookTicketInfoModel model, int lastOperatorId)
        {
            int count = dal.bookTicket(model, lastOperatorId);
            bool isSuccess = true;
            if (count < 2)
            {
                isSuccess = false;
            }
            return isSuccess;
        }
        #endregion
    }
}
