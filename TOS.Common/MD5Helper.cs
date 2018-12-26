using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Security.Cryptography;

namespace TOS.Common
{
    public static class MD5Helper
    {
        #region MD5加密为32位16进制字符串
        public static string MD5Encrypt32(string password)
        {
            MD5 md5 = MD5.Create();
            byte[] buffer = md5.ComputeHash(Encoding.UTF8.GetBytes(password));
            StringBuilder sb = new StringBuilder();
            for (int i = 0; i < buffer.Length; i++)
            {
                // "x2" 转换为 16进制
                sb.Append(buffer[i].ToString("x2"));
            }
            return sb.ToString();
        } 
        #endregion
    }
}
