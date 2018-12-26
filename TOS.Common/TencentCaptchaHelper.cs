using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

using System.Configuration;
using System.Net;
using System.IO;
using System.Web.Script.Serialization;

namespace TOS.Common
{
    public class TencentCaptchaHelper
    {
        private string app_id;

        private string app_secret;

        private string verify_url;

        public TencentCaptchaHelper()
        {
            // 默认API
            this.app_id = ConfigurationManager.AppSettings["verify_app_id"];
            this.app_secret = ConfigurationManager.AppSettings["verify_app_secret"];
            this.verify_url = ConfigurationManager.AppSettings["verify_url"];
        }

        public TencentCaptchaHelper(string tid)
        {
            // 指定场景分类API
            this.app_id = ConfigurationManager.AppSettings["verify_app_id_" + tid];
            this.app_secret = ConfigurationManager.AppSettings["verify_app_secret_" + tid];
            this.verify_url = ConfigurationManager.AppSettings["verify_url"];
        }

        public VerifyResult Verify(string ticket, string randStr, string userIP)
        {
            // 效验票据
            string resJsonStr = HttpGet(this.verify_url, $"aid={this.app_id}&AppSecretKey={this.app_secret}&Ticket={ticket}&Randstr={randStr}&UserIP={userIP}");
            JavaScriptSerializer javaScriptSerializer = new JavaScriptSerializer();
            VerifyResJson resJsonObj = javaScriptSerializer.Deserialize<VerifyResJson>(resJsonStr);
            VerifyResult rtnResult = new VerifyResult();
            if (resJsonObj.Response == 1)
            {
                rtnResult.Code = 1;
                rtnResult.Message = "验证通过";
            }
            else
            {
                rtnResult.Code = -1;
                rtnResult.Message = resJsonObj.Err_msg;
            }
            return rtnResult;
        }

        private string HttpGet(string url, string postDataStr)
        {
            string retString = string.Empty;
            try
            {
                HttpWebRequest request = (HttpWebRequest)WebRequest.Create(url + (postDataStr == "" ? "" : "?") + postDataStr);
                request.Method = "GET";
                request.ContentType = "text/html;charset=UTF-8";
                HttpWebResponse response = (HttpWebResponse)request.GetResponse();
                using (Stream responseStream = response.GetResponseStream())
                {
                    using (StreamReader sReader = new StreamReader(responseStream, System.Text.Encoding.UTF8))
                    {
                        retString = sReader.ReadToEnd();
                    }
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
            return retString;
        }
    }

    /// <summary>
    /// 请求远程验证服务器后，返回的json对象
    /// </summary>
    internal class VerifyResJson
    {
        public int Response { get; set; }

        public int Evil_level { get; set; }

        public string Err_msg { get; set; }
    }

    /// <summary>
    /// 请求本验证服务，返回的json对象
    /// </summary>
    public class VerifyResult
    {
        public int Code { get; set; }

        public string Message { get; set; }
    }
}
