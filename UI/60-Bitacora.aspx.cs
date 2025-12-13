using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;
using BE;
using BLL;
using Services;

namespace UI
{
    public partial class _60_Bitacora : System.Web.UI.Page, IIdiomaObserver
    {
        BitacoraBLL _bitacoraService = new BitacoraBLL();
        public List<BitacoraBE> Registros { get; set; } = new List<BitacoraBE>();

        private const int PageSize = 40;

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                if (!IsPostBack)
                {
                    // Registrar como observador del idioma
                    IdiomaManager.Instance.RegistrarObservador(this);

                    CargarCriticidadDropDown();
                    CargarRegistros(1, string.Empty, string.Empty, null, null);
                }

                // Leer idioma del querystring (?lang=es / ?lang=en)
                string idiomaSeleccionado = Request.QueryString["lang"];
                if (!string.IsNullOrEmpty(idiomaSeleccionado))
                {
                    IdiomaManager.Instance.CambiarIdioma(idiomaSeleccionado);
                }

                // Aplicar traducciones a todos los controles de la página
                AplicarTraducciones(this);

                // Traducir placeholders y ListItems (porque no son WebControls del árbol)
                AplicarTraduccionesAdicionales();
            }
            catch (Exception ex)
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.Text = ex.Message;
            }
        }

        private void CargarCriticidadDropDown()
        {
            ddlCriticidad.Items.Clear();

            var itSelect = new ListItem { Value = "", Text = "Seleccionar" };
            itSelect.Attributes["data-translate"] = "select";
            ddlCriticidad.Items.Add(itSelect);

            var itBaja = new ListItem { Value = "Baja", Text = "Baja" };
            itBaja.Attributes["data-translate"] = "criticidad_low";
            ddlCriticidad.Items.Add(itBaja);

            var itMedia = new ListItem { Value = "Media", Text = "Media" };
            itMedia.Attributes["data-translate"] = "criticidad_medium";
            ddlCriticidad.Items.Add(itMedia);

            var itAlta = new ListItem { Value = "Alta", Text = "Alta" };
            itAlta.Attributes["data-translate"] = "criticidad_high";
            ddlCriticidad.Items.Add(itAlta);
        }

        private void AplicarTraduccionesAdicionales()
        {
            // Placeholder usuario
            // (en tu JSON no existe "bitacora_user_placeholder" todavía, lo agregamos abajo)
            var ph = IdiomaManager.Instance.GetTraduccion("bitacora_user_placeholder");
            if (!string.IsNullOrEmpty(ph))
                txtUsuario.Attributes["placeholder"] = ph;

            // Traducir items del dropdown por data-translate
            foreach (ListItem it in ddlCriticidad.Items)
            {
                var key = it.Attributes["data-translate"];
                if (!string.IsNullOrEmpty(key))
                {
                    var tr = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(tr))
                        it.Text = tr;
                }
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

                if (fechaDesde.HasValue && fechaHasta.HasValue && fechaDesde > fechaHasta)
                {
                    lblErrorMessage.Text = ErrorMessages.ERR026; // si querés, lo pasamos a key
                    lblErrorMessage.Visible = true;
                    return;
                }

                lblErrorMessage.Visible = false;

                CurrentPage = 1;
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
            get => ViewState["CurrentPage"] != null ? (int)ViewState["CurrentPage"] : 1;
            set => ViewState["CurrentPage"] = value;
        }

        protected void CargarRegistros(int pageNumber, string usuario, string criticidad, DateTime? fechaDesde, DateTime? fechaHasta)
        {
            var allRecords = _bitacoraService.GetBitacora();

            if (!string.IsNullOrEmpty(usuario))
                allRecords = allRecords.Where(r => r.usuario.Nombre.Contains(usuario)).ToList();

            if (!string.IsNullOrEmpty(criticidad))
                allRecords = allRecords.Where(r => r.Criticidad.Equals(criticidad, StringComparison.OrdinalIgnoreCase)).ToList();

            if (fechaDesde.HasValue)
                allRecords = allRecords.Where(r => r.Fecha >= fechaDesde.Value).ToList();

            if (fechaHasta.HasValue)
            {
                var fechaHastaInclusiva = fechaHasta.Value.AddDays(1).Date;
                allRecords = allRecords.Where(r => r.Fecha < fechaHastaInclusiva).ToList();
            }

            int skip = (pageNumber - 1) * PageSize;
            Registros = allRecords.Skip(skip).Take(PageSize).ToList();

            int totalRecords = allRecords.Count;
            int totalPages = (int)Math.Ceiling((double)totalRecords / PageSize);

            lblCurrentPage.Text = pageNumber.ToString();
            lblTotalPages.Text = totalPages.ToString();

            btnAnterior.Visible = pageNumber > 1;
            btnSiguiente.Visible = pageNumber < totalPages;
        }

        protected void btnSiguiente_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string criticidad = ddlCriticidad.SelectedValue;
            DateTime? fechaDesde = string.IsNullOrEmpty(txtFechaDesde.Text) ? (DateTime?)null : DateTime.Parse(txtFechaDesde.Text);
            DateTime? fechaHasta = string.IsNullOrEmpty(txtFechaHasta.Text) ? (DateTime?)null : DateTime.Parse(txtFechaHasta.Text);

            CurrentPage++;
            CargarRegistros(CurrentPage, usuario, criticidad, fechaDesde, fechaHasta);
        }

        protected void btnAnterior_Click(object sender, EventArgs e)
        {
            string usuario = txtUsuario.Text.Trim();
            string criticidad = ddlCriticidad.SelectedValue;
            DateTime? fechaDesde = string.IsNullOrEmpty(txtFechaDesde.Text) ? (DateTime?)null : DateTime.Parse(txtFechaDesde.Text);
            DateTime? fechaHasta = string.IsNullOrEmpty(txtFechaHasta.Text) ? (DateTime?)null : DateTime.Parse(txtFechaHasta.Text);

            CurrentPage--;
            CargarRegistros(CurrentPage, usuario, criticidad, fechaDesde, fechaHasta);
        }

        // MISMO AplicarTraducciones QUE YA USAS (copialo igual desde 120-Carrito)
        protected void AplicarTraducciones(Control control)
        {
            foreach (Control childControl in control.Controls)
            {
                if (childControl is System.Web.UI.HtmlControls.HtmlAnchor anchor &&
                    anchor.Attributes["data-translate"] != null)
                {
                    string clave = anchor.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion)) anchor.InnerHtml = traduccion;
                }
                else if (childControl is System.Web.UI.HtmlControls.HtmlGenericControl generic &&
                         generic.Attributes["data-translate"] != null)
                {
                    string clave = generic.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion)) generic.InnerText = traduccion;
                }
                else if (childControl is WebControl webControl &&
                         webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);
                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is ITextControl textControl) textControl.Text = traduccion;
                        else if (childControl is IButtonControl buttonControl) buttonControl.Text = traduccion;
                    }
                }

                if (childControl.HasControls())
                    AplicarTraducciones(childControl);
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
            AplicarTraduccionesAdicionales();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
