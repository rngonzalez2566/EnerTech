using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _12_RestablecerPassword :BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();

            if (string.IsNullOrEmpty(email))
            {
                // Mostrar un mensaje de error si el campo está vacío
                // Por ejemplo, usando un Label o ScriptManager
                return;
            }

            // Lógica para procesar el restablecimiento de contraseña
            // Ejemplo: Enviar un correo con un enlace de restablecimiento
            //bool success = PasswordResetService.SendResetEmail(email);

            //if (success)
            //{
            //    // Mostrar un mensaje de éxito al usuario
            //    Response.Write("<script>alert('Correo enviado. Por favor revise su bandeja de entrada.');</script>");
            //}
            //else
            //{
            //    // Mostrar un mensaje de error si el correo no pudo enviarse
            //    Response.Write("<script>alert('Error al enviar el correo. Intente nuevamente.');</script>");
            //}
        }
    }
}