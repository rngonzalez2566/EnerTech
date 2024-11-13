using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _50_Backup : System.Web.UI.Page
    {
        BackupBLL _backupService = new BackupBLL();
        public void Page_Load(object sender, EventArgs e)
        {
            try
            {
                //CargarDV();
            }
            catch (Exception)
            {

            }
        }

        protected void btnRecalcularDigitos_Click(object sender, EventArgs e)
        {
            
        }

        protected void btnRestaurarBD_Click(object sender, EventArgs e)
        {
            try
            {
                if (!fileUploadRestore.HasFile)
                {
                    ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showMessageModal('Debe seleccionar un archivo');", true);
                    return;
                }

                string rutaBackup = @"C:\Backup\" + fileUploadRestore.FileName;

                fileUploadRestore.SaveAs(rutaBackup);

                _backupService.RealizarRestore(rutaBackup);
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
                    
                    return;
                }

                _backupService.RealizarBackup(rutaBackup);
                ScriptManager.RegisterStartupScript(this, GetType(), "showModal", "showMessageModal('Se realizo el Bkp con exito');", true);

            }
            catch (Exception)
            {
               
            }
        }

    }
}

