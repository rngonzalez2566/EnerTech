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
    public partial class _42_ModificarFamilias : System.Web.UI.Page
    {

        PermisoBLL _permisoService = new PermisoBLL();
        public Familia Familia { get; set; }
        public IList<Componente> Patentes { get; set; }
        public IList<Patente> PatentesExistentes { get; set; }
        private int _familiaId { get; set; }
        protected void Page_Load(object sender, EventArgs e)
        {
            

            try
            {
                _familiaId = int.Parse(Request.QueryString["id"]);
                CargarFamiliasPatentes();
            }
            catch (Exception)
            {  
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
           

            try
            {
                string nombreFamilia = Request.Form["nombreFamilia"];
                string patentesSeleccionadas = Request.Form["patentesSeleccionadas"];

                string[] patentesIds = patentesSeleccionadas.Split(',');

                if (!string.IsNullOrEmpty(nombreFamilia) && patentesIds.Length > 0)
                {
                    GuardarFamilia(nombreFamilia, patentesIds);
                    CargarFamiliasPatentes();

                    
                }
                else
                {
                   
                }
            }
            catch (Exception)
            {
               
            }
        }

        private void GuardarFamilia(string nombreFamilia, string[] patentesIds)
        {
            var familia = new Familia()
            {
                id_componente = _familiaId,
                Nombre = nombreFamilia,
            };

            foreach (string id in patentesIds)
            {
                var patente = new Patente()
                {
                    id_componente = int.Parse(id),
                };

                familia.AgregarHijo(patente);
            }

            _permisoService.GuardarFamiliaCreada(familia);
        }

        private void CargarFamiliasPatentes()
        {
            Familia = _permisoService.GetFamilias().FirstOrDefault(x => x.id_componente == _familiaId);
            Patentes = _permisoService.TraerFamiliaPatentes(_familiaId);

            PatentesExistentes = _permisoService.GetPatentes();
            PatentesExistentes = PatentesExistentes.Where(p => !Patentes.Any(pa => pa.id_componente == p.id_componente)).ToList();
        }
    }
}
