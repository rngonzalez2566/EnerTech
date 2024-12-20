﻿using BE.Composite;
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
           
            try
            {
                Patentes = _permisoService.GetPatentes();
            }
            catch (Exception)
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
            catch (Exception)
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
                    id_componente = int.Parse(id),
                };

                familia.AgregarHijo(patente);
            }

            int familiaId = _permisoService.GuardarPatenteFamilia(familia, true);

            if (familiaId > 0)
            {
                familia.id_componente = familiaId;
                _permisoService.GuardarFamiliaCreada(familia);
            }
        }
    }
}