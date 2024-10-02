using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.NetworkInformation;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BLL;
using Services;

namespace UI
{
    public partial class _60_Bitacora : System.Web.UI.Page
    {
        BitacoraBLL _bitacoraService = new BitacoraBLL();
        public List<BitacoraBE> Registros { get; set; } = new List<BitacoraBE>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                CargarRegistros(1, string.Empty, string.Empty, null, null);
            }
           
        }

        protected void btnBuscar_Click(object sender, EventArgs e)
        {
           try
            {
                string usuario = txtUsuario.Text.Trim();
                string criticidad = ddlCriticidad.SelectedValue;
                DateTime? fechaDesde = string.IsNullOrEmpty(txtFechaDesde.Text) ? (DateTime?)null : DateTime.Parse(txtFechaDesde.Text);
                DateTime? fechaHasta = string.IsNullOrEmpty(txtFechaHasta.Text) ? (DateTime?)null : DateTime.Parse(txtFechaHasta.Text);
                if (fechaDesde.HasValue && fechaHasta.HasValue)
                {
                    if (fechaDesde > fechaHasta)
                    {
                        // Mostrar un mensaje de error si la Fecha Desde es mayor que la Fecha Hasta
                        lblErrorMessage.Text = ErrorMessages.ERR026;
                        lblErrorMessage.Visible = true;
                        return;
                    }
                    else
                    {
                        lblErrorMessage.Visible = false;
                    }
                }
                else
                {
                    lblErrorMessage.Visible = false;
                }
                CurrentPage = 1; // Reiniciar a la primera página cuando se aplica un filtro
                CargarRegistros(CurrentPage, usuario, criticidad, fechaDesde, fechaHasta);

            }
            catch (Exception ex)
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.Text = ex.Message;

            }



        }


        protected int CurrentPage
        {
            get
            {
                // Obtener la página actual desde el estado de la vista
                return ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1;
            }
            set
            {
                ViewState["CurrentPage"] = value;
            }
        }

        private const int PageSize = 40; // Tamaño de página (40 registros)




        // Método para cargar registros según la página actual
        protected void CargarRegistros(int pageNumber, string usuario, string criticidad, DateTime? fechaDesde, DateTime? fechaHasta)
        {
            try
            {
                // Lógica para obtener registros de la base de datos
                var allRecords = _bitacoraService.GetBitacora();

                if (!string.IsNullOrEmpty(usuario))
                {
                    allRecords = allRecords.Where(r => r.usuario.Nombre.Contains(usuario)).ToList();
                }

                if (!string.IsNullOrEmpty(criticidad))
                {
                    allRecords = allRecords.Where(r => r.Criticidad.Equals(criticidad, StringComparison.OrdinalIgnoreCase)).ToList();
                }

                if (fechaDesde.HasValue)
                {
                    allRecords = allRecords.Where(r => r.Fecha >= fechaDesde.Value).ToList();
                }

                if (fechaHasta.HasValue)
                {
                    allRecords = allRecords.Where(r => r.Fecha <= fechaHasta.Value).ToList();
                }

                int skip = (pageNumber - 1) * PageSize;
                Registros = allRecords.Skip(skip).Take(PageSize).ToList();

                // Calcular el número total de páginas
                int totalRecords = allRecords.Count;
                int totalPages = (int)Math.Ceiling((double)totalRecords / PageSize);

                // Actualizar los controles de la interfaz
                lblCurrentPage.Text = pageNumber.ToString();
                lblTotalPages.Text = totalPages.ToString();

                // Controlar la visibilidad de los botones
                btnAnterior.Visible = pageNumber > 1;
                btnSiguiente.Visible = pageNumber < totalPages;
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);

            }

        }

        

        // Botón Siguiente
        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            // Obtener los valores de los filtros actuales
            string usuario = txtUsuario.Text.Trim();
            string criticidad = ddlCriticidad.SelectedValue;
            DateTime? fechaDesde = string.IsNullOrEmpty(txtFechaDesde.Text) ? (DateTime?)null : DateTime.Parse(txtFechaDesde.Text);
            DateTime? fechaHasta = string.IsNullOrEmpty(txtFechaHasta.Text) ? (DateTime?)null : DateTime.Parse(txtFechaHasta.Text);

            // Avanzar a la siguiente página y recargar los registros
            CurrentPage++;
            CargarRegistros(CurrentPage, usuario, criticidad, fechaDesde, fechaHasta);
        }

        // Botón Anterior
        protected void btnAnterior_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string criticidad = ddlCriticidad.SelectedValue;
            DateTime? fechaDesde = string.IsNullOrEmpty(txtFechaDesde.Text) ? (DateTime?)null : DateTime.Parse(txtFechaDesde.Text);
            DateTime? fechaHasta = string.IsNullOrEmpty(txtFechaHasta.Text) ? (DateTime?)null : DateTime.Parse(txtFechaHasta.Text);

            // Retroceder a la página anterior y recargar los registros
            CurrentPage--;
            CargarRegistros(CurrentPage, usuario, criticidad, fechaDesde, fechaHasta);
        }

      
       
    }

  
}
    
