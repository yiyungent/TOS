using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace TOS.Model
{
    public class SysFunctionModel
    {
        private int id;
        private string menuName;
        private string url;
        private int isStop;
        private int sortNo;

        /// <summary>
        /// 主键
        /// </summary>
        public int Id { get => id; set => id = value; }

        /// <summary>
        /// 菜单功能名
        /// </summary>
        public string MenuName { get => menuName; set => menuName = value; }

        /// <summary>
        /// url地址
        /// </summary>
        public string Url { get => url; set => url = value; }

        /// <summary>
        /// 类型
        /// </summary>
        public int IsStop { get => isStop; set => isStop = value; }

        /// <summary>
        /// 排序码
        /// </summary>
        public int SortNo { get => sortNo; set => sortNo = value; }
    }
}
