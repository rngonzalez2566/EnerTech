using BE;
using BLL;
using Services;
using System;
using System.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _11_Login : System.Web.UI.Page, IIdiomaObserver
    {
        UsuarioBLL usuarioBLL = new UsuarioBLL();
        SessionManager _sessionManager = new SessionManager();
        DigitoVerificadorBLL dv = new DigitoVerificadorBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1) Cambiar idioma primero (viene desde Home con ?lang=es|en)
            string idiomaSeleccionado = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idiomaSeleccionado))
            {
                IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
            }
            SetLinksConLang();
            // 2) Si ya está logueado, redirigir (manteniendo lang si viene)
            var usuario = _sessionManager.Get<UsuarioBE>("Usuario");
            if (usuario != null)
            {
                string lang = Request.QueryString["lang"];
                string url = "13-MenuPrincipal.aspx" + (!string.IsNullOrEmpty(lang) ? ("?lang=" + lang) : "");
                Response.Redirect(url);
                return;
            }

            try
            {
                // 3) Registrar observer una vez
                if (!IsPostBack)
                {
                    IdiomaManager.Instance.RegistrarObservador(this);
                }

                // 4) Links internos con lang (sin JS)
                SetLinksConLang();

                // 5) Traducciones generales + placeholders
                AplicarTraducciones(this);
                AplicarPlaceholders();

                // 6) Title traducible (opcional)
                string title = IdiomaManager.Instance.GetTraduccion("login_page_title");
                if (!string.IsNullOrEmpty(title))
                {
                    Page.Title = title;
                }
            }
            catch
            {
                // Login pública: no forzamos redirect
            }
        }

        private void SetLinksConLang()
        {
            string lang = Request.QueryString["lang"];

            // Default si no viene: no agrega nada
            string suf = !string.IsNullOrEmpty(lang) ? ("?lang=" + lang) : "";

            lnkReset.HRef = "12-RestablecerPassword.aspx" + suf;
            lnkRegister.HRef = "21-AltaUsuario.aspx" + suf;
        }

        private void AplicarPlaceholders()
        {
            // Placeholder Email
            string emailPh = IdiomaManager.Instance.GetTraduccion("login_email_placeholder");
            if (!string.IsNullOrEmpty(emailPh))
                txtEmail.Attributes["placeholder"] = emailPh;

            // Placeholder Password
            string passPh = IdiomaManager.Instance.GetTraduccion("login_password_placeholder");
            if (!string.IsNullOrEmpty(passPh))
                txtPassword.Attributes["placeholder"] = passPh;
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            try
            {
                if (dv.VerificarDV())
                {
                    UsuarioBE usuario = usuarioBLL.Login(txtEmail.Text, txtPassword.Text);
                    if (usuario != null)
                    {
                        _sessionManager.Set("Usuario", usuario);

                        string lang = Request.QueryString["lang"];
                        string url = "13-MenuPrincipal.aspx" + (!string.IsNullOrEmpty(lang) ? ("?lang=" + lang) : "");
                        Response.Redirect(url, false);
                    }
                    else
                    {
                        lblMessage.Text = ErrorMessages.ERR012;
                        lblMessage.Visible = true;
                    }
                }
                else
                {
                    var user = ConfigurationManager.AppSettings["usuario"];
                    var password = ConfigurationManager.AppSettings["password"];

                    if (txtEmail.Text == user && txtPassword.Text == password)
                    {
                        UsuarioBE userBE = new UsuarioBE();
                        userBE.Email = txtEmail.Text;

                        _sessionManager.Set("Usuario", userBE);

                        string lang = Request.QueryString["lang"];
                        string url = "13-MenuPrincipal.aspx" + (!string.IsNullOrEmpty(lang) ? ("?lang=" + lang) : "");
                        Response.Redirect(url, false);
                    }
                    else
                    {
                        lblMessage.Text = ErrorMessages.ERR014;
                        lblMessage.Visible = true;
                    }
                }
            }
            catch (Exception ex)
            {
                lblMessage.Text = ex.Message;
                lblMessage.Visible = true;
            }
        }

        // === MISMO MÉTODO QUE USÁS EN TUS PÁGINAS “BUENAS” ===
        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                if (childControl is System.Web.UI.HtmlControls.HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion))
                        anchor.InnerHtml = traduccion;
                }
                else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion))
                        generic.InnerText = traduccion;
                }
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is ITextControl textControl)
                            textControl.Text = traduccion;
                        else if (childControl is IButtonControl buttonControl)
                            buttonControl.Text = traduccion;
                    }
                }

                if (childControl.HasControls())
                    AplicarTraducciones(childControl);
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            SetLinksConLang();
            AplicarTraducciones(this);
            AplicarPlaceholders();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }


    }
}
