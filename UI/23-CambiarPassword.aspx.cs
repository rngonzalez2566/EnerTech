using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _23_CambiarPassword : BasePage
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            string currentPassword = txtCurrentPassword.Text.Trim();
            string newPassword = txtNewPassword.Text.Trim();
            string confirmPassword = txtConfirmPassword.Text.Trim();

            if (string.IsNullOrEmpty(currentPassword) || string.IsNullOrEmpty(newPassword) || string.IsNullOrEmpty(confirmPassword))
            {
                // Mensaje de error si faltan campos
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Por favor, complete todos los campos.');", true);
                return;
            }

            if (newPassword != confirmPassword)
            {
                // Mensaje de error si las contraseñas no coinciden
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('La nueva contraseña y su confirmación no coinciden.');", true);
                return;
            }

            // Aquí iría la lógica para validar la contraseña actual y cambiar la contraseña del usuario
            // Ejemplo: ValidarContraseñaActual(currentPassword) y CambiarContraseña(newPassword)

            bool passwordChanged = true; // Cambiar por el resultado real de la lógica
            if (passwordChanged)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('La contraseña se cambió correctamente.');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "alert", "alert('Error al cambiar la contraseña. Por favor, intente nuevamente.');", true);
            }
        }
    }
}