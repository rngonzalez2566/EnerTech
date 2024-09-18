using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
     public static class DateHandler
    {
        private static readonly TimeZoneInfo ArgentinaTimeZone = TimeZoneInfo.FindSystemTimeZoneById("Argentina Standard Time");

        public static DateTime Now()
        {
            return TimeZoneInfo.ConvertTime(DateTime.Now, ArgentinaTimeZone);
        }
    }
}
