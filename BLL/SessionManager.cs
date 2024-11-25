using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.SessionState;

namespace BLL
{
    public class SessionManager
    {
        private HttpSessionState Session => HttpContext.Current?.Session;

        public T Get<T>(string key)
        {
            return (T)Session[key];
        }

        public void Set<T>(string key, T value)
        {
            Session[key] = value;
        }

        public void Remove(string key)
        {
            Session.Remove(key);
        }

        public void AbandonSession()
        {
            Session.Abandon();
        }

        private const string IdiomaKey = "Idioma";

        public string GetIdioma()
        {
            return Get<string>(IdiomaKey) ?? "es"; // Por defecto, "es" (español)
        }

        public void SetIdioma(string idioma)
        {
            Set(IdiomaKey, idioma);
        }

    }
}
