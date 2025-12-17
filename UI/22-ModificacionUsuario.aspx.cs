using BE;
using BE.Enums;
using BLL;
using Services;
using System;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _22_ModificacionUsuario : System.Web.UI.Page, IIdiomaObserver
    {
        UsuarioBLL _usuarioService = new UsuarioBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            var session = new SessionManager();
            UsuarioBE usuarioSesion = session.Get<UsuarioBE>("Usuario");

            if (usuarioSesion == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            // Ajustá el permiso a tu enum real
            if (!PermisoCheck.VerificarPermiso(usuarioSesion.Permisos, Permiso.AltaUsuario))
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }
            int idUsuario = usuarioSesion.id_usuario;
            try
            {
                if (!IsPostBack)
                {
                    IdiomaManager.Instance.RegistrarObservador(this);

                    hfIdUsuario.Value = idUsuario.ToString();
                   CargarUsuario(idUsuario);
                }

                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                AplicarTraducciones(this);
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error en Modificación de Usuario: " + ex.Message;
                lblMessage.CssClass = "error-message";
            }
        }

        private string TryDecrypt(string value)
        {
            if (string.IsNullOrWhiteSpace(value)) return value;
            try { return Encriptador.Descencriptar(value); }
            catch { return value; } // por si ya viene desencriptado o no aplica
        }

        private void CargarUsuario(int idUsuario)
        {
            UsuarioBE u = _usuarioService.GetUsuarioID(idUsuario);
            if (u == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            txtEmail.Text = TryDecrypt(u.Email);
            txtNombre.Text = TryDecrypt(u.Nombre);
            txtApellido.Text = TryDecrypt(u.Apellido);

          
            txtRazonSocial.Text = u.RazonSocial;

            txtIdentificacion.Text = u.Identificacion.ToString();

            if (!string.IsNullOrWhiteSpace(u.TipoDocumento))
                ddlTipoDocumento.SelectedValue = u.TipoDocumento;

            if (!string.IsNullOrWhiteSpace(u.TipoCliente))
                ddlTipoCliente.SelectedValue = u.TipoCliente;

            if (!string.IsNullOrWhiteSpace(u.Estado))
                ddlEstado.SelectedValue = u.Estado;
        }

        private void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                // ✅ <a runat="server">
                if (childControl is HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    // ✅ si no hay traducción real, NO piso el texto por la key
                    if (!string.IsNullOrWhiteSpace(traduccion) && !string.Equals(traduccion, clave, StringComparison.OrdinalIgnoreCase))
                        anchor.InnerText = traduccion;
                }
                // ✅ <label runat="server"> y otros HtmlGenericControl
                else if (childControl is HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrWhiteSpace(traduccion) && !string.Equals(traduccion, clave, StringComparison.OrdinalIgnoreCase))
                        generic.InnerText = traduccion;
                }
                // ✅ WebControls (Button, Label, RequiredFieldValidator, etc.)
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrWhiteSpace(traduccion) && !string.Equals(traduccion, clave, StringComparison.OrdinalIgnoreCase))
                    {
                        if (childControl is IButtonControl buttonControl)
                            buttonControl.Text = traduccion;
                        else if (childControl is TextBox textBox)
                            textBox.Attributes["placeholder"] = traduccion;
                        else if (childControl is ITextControl textControl)
                            textControl.Text = traduccion;
                    }
                }

                if (childControl.HasControls())
                    AplicarTraducciones(childControl);
            }
        }

        protected void btnGuardarCambios_Click(object sender, EventArgs e)
        {
            try
            {
                lblMessage.Text = "";

                // 1️⃣ Validaciones ASP.NET
                if (!Page.IsValid)
                    return;

                var session = new SessionManager();
                UsuarioBE usuarioSesion = session.Get<UsuarioBE>("Usuario");

                if (usuarioSesion == null)
                {
                    Response.Redirect("Default.aspx", false);
                    Context.ApplicationInstance.CompleteRequest();
                    return;
                }

                // 2️⃣ Parseos seguros
                if (!int.TryParse(txtIdentificacion.Text.Trim(), out int identificacion))
                    throw new Exception("Identificación inválida");

                // 3️⃣ Armo el objeto UsuarioBE con datos editados
                UsuarioBE usuarioEditado = new UsuarioBE
                {
                    id_usuario = usuarioSesion.id_usuario,

                    // 🔓 UI trabaja DESENCRIPTADO
                    Email = txtEmail.Text.Trim(),
                    Nombre = txtNombre.Text.Trim(),
                    Apellido = txtApellido.Text.Trim(),

                    // Según tu modelo, Razón Social NO está encriptada
                    RazonSocial = txtRazonSocial.Text.Trim(),

                    Identificacion = identificacion,
                    TipoDocumento = ddlTipoDocumento.SelectedValue,
                    TipoCliente = ddlTipoCliente.SelectedValue,
                    Estado = ddlEstado.SelectedValue
                };

                // 4️⃣ Delego TODA la lógica a BLL
                _usuarioService.ActualizarUsuario(usuarioEditado);

                // 5️⃣ Actualizo el usuario en sesión (muy importante)
                UsuarioBE usuarioActualizado = _usuarioService.GetUsuarioID(usuarioSesion.id_usuario);
                session.Set("Usuario", usuarioActualizado);

                // 6️⃣ Feedback visual
                lblMessage.CssClass = "text-success mt-3";
                lblMessage.Text = "Los datos se actualizaron correctamente.";

            }
            catch (Exception ex)
            {
                lblMessage.CssClass = "text-danger mt-3";
                lblMessage.Text = ex.Message;
            }
        }


        public void UpdateIdioma(string nuevoIdioma) => AplicarTraducciones(this);

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
