using System;
using System.Web.UI;

namespace UI.controls
{
    public partial class ValidarCrearFamilia : UserControl
    {
        public string NombreFamilia
        {
            get { return txtNombreFamilia.Text.Trim(); }
        }

        public void Limpiar()
        {
            txtNombreFamilia.Text = string.Empty;
        }
    }
}
