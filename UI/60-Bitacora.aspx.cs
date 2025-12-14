using BE;
using BE.Enums;
using BLL;
using iText.StyledXmlParser.Jsoup.Nodes;
using Services;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _60_Bitacora : System.Web.UI.Page, IIdiomaObserver
    {
        BitacoraBLL _bitacoraService = new BitacoraBLL();
        public List<BitacoraBE> Registros { get; set; } = new List<BitacoraBE>();

        private const int PageSize = 40;

        protected void Page_Load(object sender, EventArgs e)
        {
            var session = new SessionManager();
            UsuarioBE usuario = session.Get<UsuarioBE>("Usuario");

            if (usuario == null)
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }

            string usuarioEmergencia = ConfigurationManager.AppSettings["usuario"];
            if (
                    usuario.Email != usuarioEmergencia &&
                    !PermisoCheck.VerificarPermiso(usuario.Permisos, BE.Enums.Permiso.VisualizarBitacora)
                )
            {
                Response.Redirect("Default.aspx", false);
                Context.ApplicationInstance.CompleteRequest();
                return;
            }


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
        private (DateTime? desde, DateTime? hastaExclusivo) GetRangoFechas()
        {
            DateTime? fechaDesde = string.IsNullOrEmpty(txtFechaDesde.Text) ? (DateTime?)null : DateTime.Parse(txtFechaDesde.Text);
            DateTime? fechaHasta = string.IsNullOrEmpty(txtFechaHasta.Text) ? (DateTime?)null : DateTime.Parse(txtFechaHasta.Text);

            if (fechaDesde.HasValue && fechaHasta.HasValue && fechaDesde > fechaHasta)
                throw new Exception(ErrorMessages.ERR026);

            // hacemos "hasta" exclusivo para incluir todo el día (00:00 del día siguiente)
            DateTime? hastaExclusivo = null;
            if (fechaHasta.HasValue)
                hastaExclusivo = fechaHasta.Value.Date.AddDays(1);

            return (fechaDesde, hastaExclusivo);
        }

        private List<BitacoraBE> FiltrarBitacora(string usuario, string criticidad, DateTime? desde, DateTime? hastaExclusivo)
        {
            var allRecords = _bitacoraService.GetBitacora();

            if (!string.IsNullOrEmpty(usuario))
                allRecords = allRecords.Where(r => r.usuario.Nombre.Contains(usuario)).ToList();

            if (!string.IsNullOrEmpty(criticidad))
                allRecords = allRecords.Where(r => r.Criticidad.Equals(criticidad, StringComparison.OrdinalIgnoreCase)).ToList();

            if (desde.HasValue)
                allRecords = allRecords.Where(r => r.Fecha >= desde.Value).ToList();

            if (hastaExclusivo.HasValue)
                allRecords = allRecords.Where(r => r.Fecha < hastaExclusivo.Value).ToList();

            return allRecords;
        }

        protected void btnExportJson_Click(object sender, EventArgs e)
        {
            try
            {
                string usuario = txtUsuario.Text.Trim();
                string criticidad = ddlCriticidad.SelectedValue;
                var (desde, hastaExclusivo) = GetRangoFechas();

                var data = FiltrarBitacora(usuario, criticidad, desde, hastaExclusivo);

                string json = Newtonsoft.Json.JsonConvert.SerializeObject(data, Newtonsoft.Json.Formatting.Indented);

                Response.Clear();
                Response.ContentType = "application/json";
                Response.AddHeader("Content-Disposition", "attachment; filename=bitacora.json");
                Response.Write(json);
                Response.End();
            }
            catch (Exception ex)
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.Text = ex.Message;
            }
        }

        protected void btnExportXml_Click(object sender, EventArgs e)
        {
            try
            {
                string usuario = txtUsuario.Text.Trim();
                string criticidad = ddlCriticidad.SelectedValue;
                var (desde, hastaExclusivo) = GetRangoFechas();

                var data = FiltrarBitacora(usuario, criticidad, desde, hastaExclusivo);

                var serializer = new System.Xml.Serialization.XmlSerializer(typeof(List<BitacoraBE>));
                using (var sw = new System.IO.StringWriter())
                {
                    serializer.Serialize(sw, data);
                    string xml = sw.ToString();

                    Response.Clear();
                    Response.ContentType = "application/xml";
                    Response.AddHeader("Content-Disposition", "attachment; filename=bitacora.xml");
                    Response.Write(xml);
                    Response.End();
                }
            }
            catch (Exception ex)
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.Text = ex.Message;
            }
        }

        protected void btnDepurar_Click(object sender, EventArgs e)
        {
            try
            {
                if (!chkConfirmPurge.Checked)
                {
                    lblErrorMessage.Visible = true;
                    lblErrorMessage.Text = "Debes confirmar el borrado.";
                    return;
                }

                string usuario = txtUsuario.Text.Trim();
                string criticidad = ddlCriticidad.SelectedValue;
                var (desde, hastaExclusivo) = GetRangoFechas();

                // 1) Exportar backup (de lo filtrado)
                var data = FiltrarBitacora(usuario, criticidad, desde, hastaExclusivo);
                string json = Newtonsoft.Json.JsonConvert.SerializeObject(data, Newtonsoft.Json.Formatting.Indented);

                // 2) Borrar en DB SOLO por rango de fechas (recomendado)
                // (Si querés que también borre por usuario/criticidad, se puede, pero hoy lo dejamos por fecha)
                _bitacoraService.DepurarBitacora(desde, hastaExclusivo);

                // 3) Recargar grilla
                CurrentPage = 1;
                CargarRegistros(CurrentPage, string.Empty, string.Empty, null, null);

                // 4) Descargar backup
                Response.Clear();
                Response.ContentType = "application/json";
                Response.AddHeader("Content-Disposition", "attachment; filename=bitacora_backup_antes_depurar.json");
                Response.Write(json);
                Response.End();
            }
            catch (Exception ex)
            {
                lblErrorMessage.Visible = true;
                lblErrorMessage.Text = ex.Message;
            }
        }




    }
}
