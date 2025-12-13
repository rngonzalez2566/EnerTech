using BLL;
using Services;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _50_Backup : System.Web.UI.Page, IIdiomaObserver
    {
        BackupBLL _backupService = new BackupBLL();

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    // Registrar como observador del idioma (mismo patrón que Carrito)
                    IdiomaManager.Instance.RegistrarObservador(this);

                    // Valor por defecto de ruta (en asp:TextBox va por Text, no por value="")
                    txtRutaBackup.Text = @"C:\Backup";
                }

                // Leer idioma del querystring (?lang=es / ?lang=en)
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // Aplicar traducciones a todos los controles de la página
                AplicarTraducciones(this);

                // (Opcional) título de pestaña traducible
                string titulo = IdiomaManager.Instance.GetTraduccion("backup_admin_title");
                if (!string.IsNullOrEmpty(titulo))
                {
                    Page.Title = titulo;
                }
            }
            catch (Exception ex)
            {
                // Si querés mostrar algo en modal, podés usar el mismo GenericModal
                // ScriptManager.RegisterStartupScript(this, GetType(), "showModal", $"showMessageModal('Error: {ex.Message}');", true);
            }
        }

        protected void btnRecalcularDigitos_Click(object sender, EventArgs e)
        {
            // TODO: tu lógica
        }

        protected void btnRestaurarBD_Click(object sender, EventArgs e)
        {
            try
            {
                if (!fileUploadRestore.HasFile)
                {
                    // Ideal: traducirlo con una key, ej: IdiomaManager.Instance.GetTraduccion("backup_select_file_required")
                    ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showMessageModal('Debe seleccionar un archivo');", true);
                    return;
                }

                string rutaBackup = @"C:\Backup\" + fileUploadRestore.FileName;

                fileUploadRestore.SaveAs(rutaBackup);

                _backupService.RealizarRestore(rutaBackup);

                // Ideal: key traducible, ej: "backup_restore_ok"
                ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showMessageModal('Se realizo el restore con exito');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showModal", $"showMessageModal('Error: {ex.Message}');", true);
            }
        }

        protected void btnGenerarBackup_Click(object sender, EventArgs e)
        {
            try
            {
                string rutaBackup = txtRutaBackup.Text.Trim();

                if (string.IsNullOrEmpty(rutaBackup))
                {
                    // Ideal: key traducible, ej: "backup_path_required"
                    ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showMessageModal('Debe indicar una ruta');", true);
                    return;
                }

                _backupService.RealizarBackup(rutaBackup);

                // Ideal: key traducible, ej: "backup_ok"
                ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showMessageModal('Se realizo el Bkp con exito');", true);
            }
            catch (Exception ex)
            {
                ScriptManager.RegisterStartupScript(this, GetType(), "showModal", $"showMessageModal('Error: {ex.Message}');", true);
            }
        }

        // ===== MISMO MÉTODO QUE TU PÁGINA 120-Carrito =====
        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                // 1) Anchor <a runat="server">
                if (childControl is System.Web.UI.HtmlControls.HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        anchor.InnerHtml = traduccion;
                    }
                }
                // 2) Controles HTML genéricos (span, div, h1, label, etc.)
                else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        generic.InnerText = traduccion;
                    }
                }
                // 3) Controles ASP.NET clásicos (Label, Button, LinkButton, TextBox, etc.)
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is ITextControl textControl)
                        {
                            textControl.Text = traduccion;
                        }
                        else if (childControl is IButtonControl buttonControl)
                        {
                            buttonControl.Text = traduccion;
                        }
                    }
                }

                // Recursivo
                if (childControl.HasControls())
                {
                    AplicarTraducciones(childControl);
                }
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
