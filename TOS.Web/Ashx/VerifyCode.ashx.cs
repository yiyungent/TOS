using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using TOS.Common;
using System.Web.SessionState;

namespace TOS.Web.Ashx
{
    /// <summary>
    /// Summary description for VerifyCode
    /// </summary>
    public class VerifyCode : IHttpHandler, IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            string tid = context.Request["tid"];
            string ticket = context.Request["ticket"];
            string randstr = context.Request["randstr"];

            TencentCaptchaHelper captcha = new TencentCaptchaHelper(tid);
            VerifyResult verifyResult = captcha.Verify(ticket, randstr, context.Request.UserHostAddress);
            if (verifyResult.Code == 1)
            {
                // 标记验证通过
                //context.Session["verify_" + tid] = true;
                // 这种方法也有一个弊端，那就是，可通过请求此验证API延长验证码过期时间，注意看下方这句
                context.Session["verify_" + tid + "_time"] = DateTime.Now;
                context.Response.Write("{\"code\": 1, \"message\":\"验证通过\"}");
            }
            else
            {
                // 验证未通过
                //context.Session["verify_" + tid] = false;
                context.Session["verify_" + tid + "_time"] = null;
                context.Response.Write("{\"code\": -1, \"message\":\"验证未通过\"}");
            }
            // 2分钟后过期
            // 难以置信:因为不能单独设置[verify_tid]的过期时间为2分钟，我以为会导致这个用户（会话）下的所有值（即这个Session）都会在2分钟后清除，然而实测 登录状态的Session并未在2分钟后清除
            // 不对，上面的话错了，再次测试，发现，Session被整个清除了，保存在Session的登录状态在2分钟后也挂了
            // 所以这种方法不可取
            //context.Session.Timeout = 2;
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}