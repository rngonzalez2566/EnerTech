using BE.Composite;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class _42_ModificarFamilias : System.Web.UI.Page, IIdiomaObserver
    {
        private readonly PermisoBLL _permisoService = new PermisoBLL();

        public Familia Familia { get; set; }
        public IList<Componente> Patentes { get; set; }
        public IList<Patente> PatentesExistentes { get; set; }

        private int _familiaId;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1) Cambiar idioma si viene en querystring ANTES de traducir
            string idioma = Request.QueryString["lang"];
            if (!string.IsNullOrEmpty(idioma))
                IdiomaManager.Instance.CambiarIdioma(idioma);

            if (!IsPostBack)
            {
                IdiomaManager.Instance.RegistrarObservador(this);

                // Cargar datos
                _familiaId = int.Parse(Request.QueryString["id"]);
                CargarFamiliasPatentes();

                // Traducir controles (texto + botones)
                AplicarTraducciones(this);

                // Si querés traducir placeholders (inputs HTML)
                TraducirPlaceholders();

                // Si tenés GridView, acá sería el lugar de traducir headers (en esta página no hay GridView)
            }
            else
            {
                // En postback: el usuario pudo cambiar idioma desde navbar (observador)
                AplicarTraducciones(this);
                TraducirPlaceholders();
            }
        }

        protected void btnGuardar_Click(object sender, EventArgs e)
        {
            try
            {
                string nombreFamilia = Request.Form["nombreFamilia"];
                string patentesSeleccionadas = Request.Form["patentesSeleccionadas"];

                string[] patentesIds = (patentesSeleccionadas ?? "")
                    .Split(new[] { ',' }, StringSplitOptions.RemoveEmptyEntries);

                if (!string.IsNullOrEmpty(nombreFamilia) && patentesIds.Length > 0)
                {
                    GuardarFamilia(nombreFamilia, patentesIds);
                    CargarFamiliasPatentes();

                    // Re-traducir luego de databind/render
                    AplicarTraducciones(this);
                    TraducirPlaceholders();
                }
            }
            catch
            {
                // opcional: mostrar mensaje traducible
            }
        }

        private void GuardarFamilia(string nombreFamilia, string[] patentesIds)
        {
            var familia = new Familia()
            {
                id_componente = _familiaId,
                Nombre = nombreFamilia
            };

            foreach (string id in patentesIds)
            {
                var patente = new Patente()
                {
                    id_componente = int.Parse(id)
                };
                familia.AgregarHijo(patente);
            }

            _permisoService.GuardarFamiliaCreada(familia);
        }

        private void CargarFamiliasPatentes()
        {
            Familia = _permisoService.GetFamilias().FirstOrDefault(x => x.id_componente == _familiaId);
            Patentes = _permisoService.TraerFamiliaPatentes(_familiaId);

            PatentesExistentes = _permisoService.GetPatentes()
                .Where(p => !Patentes.Any(pa => pa.id_componente == p.id_componente))
                .ToList();
        }

        // ---------------------------
        // Traducciones
        // ---------------------------
        private void AplicarTraducciones(Control control)
        {
            foreach (Control child in control.Controls)
            {
                // HTML genérico: h2, h5, span, label, etc (siempre que tenga runat="server")
                if (child is HtmlGenericControl html && html.Attributes["data-translate"] != null)
                {
                    string key = html.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);
                    if (!string.IsNullOrEmpty(translated))
                        html.InnerText = translated;
                }
                // WebControls: asp:Button, asp:Label, DropDownList, etc
                else if (child is WebControl web && web.Attributes["data-translate"] != null)
                {
                    string key = web.Attributes["data-translate"];
                    string translated = IdiomaManager.Instance.GetTraduccion(key);

                    if (!string.IsNullOrEmpty(translated))
                    {
                        // Botones ASP
                        if (child is IButtonControl btn)
                            btn.Text = translated;

                        // Labels ASP
                        if (child is Label lbl)
                            lbl.Text = translated;

                        // TextBox ASP (si usaras)
                        if (child is TextBox tb && tb.Attributes["placeholder"] != null)
                            tb.Attributes["placeholder"] = translated;
                    }
                }

                if (child.HasControls())
                    AplicarTraducciones(child);
            }
        }

        /// <summary>
        /// Traduce placeholders de inputs HTML (no ASP) como: <input ... placeholder="...">
        /// En tu aspx el input nombreFamilia es HTML puro, por eso esto es útil.
        /// </summary>
        private void TraducirPlaceholders()
        {
            // Busca el input por ID (HTML input, no server control) y setea placeholder desde recursos si querés
            // Ejemplo: placeholder para nombre de familia
            var ph = IdiomaManager.Instance.GetTraduccion("family_name_placeholder");
            if (!string.IsNullOrEmpty(ph))
            {
                // "nombreFamilia" es el id del input HTML (no runat=server)
                // Lo seteamos con un script o convirtiéndolo a HtmlInputText runat=server si querés 100% server-side.
                // Opción rápida: nada (si no necesitás placeholder traducible).
                // Si querés hacerlo server-side, cambiá el input a:
                // <input runat="server" id="nombreFamilia" ... />
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            AplicarTraducciones(this);
            TraducirPlaceholders();
        }

        protected void Page_Unload(object sender, EventArgs e)
        {
            IdiomaManager.Instance.EliminarObservador(this);
        }
    }
}
