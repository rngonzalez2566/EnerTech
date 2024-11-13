using BE.Composite;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _41_CrearFamilias : System.Web.UI.Page
    {
        PermisoBLL _permisoService = new PermisoBLL();
        public List<Patente> Patentes { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            //var clienteLogueado = _sessionManager.Get<Cliente>("Usuario");
            //var idioma = _sessionManager.Get<IIdioma>("Idioma");

            //if (clienteLogueado == null || !PermisoCheck.VerificarPermiso(clienteLogueado.Permisos, Entities.Enums.Permiso.AltaFamilia))
            //    Response.Redirect("Default.aspx");

            try
            {
                Patentes = _permisoService.GetPatentes();
            }
            catch (Exception ex)
            {

            }
        }

        protected void btnCrear_Click(object sender, EventArgs e)
        {

            try
            {
                string nombreFamilia = Request.Form["nombreFamilia"];
                string patentesSeleccionadas = Request.Form["patentesSeleccionadas"];

                string[] patentesIds = patentesSeleccionadas.Split(',');

                if (!string.IsNullOrEmpty(nombreFamilia) && patentesIds.Length > 0)
                {
                    GuardarFamilia(nombreFamilia, patentesIds);


                }

            }
            catch (Exception ex)
            {

            }

        }

        private void GuardarFamilia(string nombreFamilia, string[] patentesIds)
        {
            var familia = new Familia()
            {
                Nombre = nombreFamilia,
            };

            foreach (string id in patentesIds)
            {
                var patente = new Patente()
                {
                    Id = int.Parse(id),
                };

                familia.AgregarHijo(patente);
            }

            int familiaId = _permisoService.GuardarPatenteFamilia(familia, true);

            if (familiaId > 0)
            {
                familia.Id = familiaId;
                _permisoService.GuardarFamiliaCreada(familia);
            }
        }
    }
}