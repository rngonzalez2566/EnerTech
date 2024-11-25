using BE;
using BLL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace UI
{
    public partial class BasePage : System.Web.UI.Page, IIdiomaObserver
    {
        protected override void OnLoad(EventArgs e)
        {
            base.OnLoad(e);

            if (!IsPostBack)
            {
                // Registrar como observador
                IdiomaManager.Instance.RegistrarObservador(this);

                // Aplicar traducciones
                AplicarTraducciones(this);
            }
        }

        public void UpdateIdioma(string nuevoIdioma)
        {
            // Aplicar traducciones cuando el idioma cambie
            AplicarTraducciones(this);
        }

        protected override void OnUnload(EventArgs e)
        {
            base.OnUnload(e);

            // Eliminar la página del registro de observadores
            IdiomaManager.Instance.EliminarObservador(this);
        }

        protected void AplicarTraducciones(Control control)
        {
            // Recorrer todos los controles del formulario
            foreach (Control childControl in control.Controls)
            {
                // Verificar si el control tiene el atributo "data-translate"
                if (childControl is WebControl webControl && webControl.Attributes["data-translate"] != null)
                {
                    string clave = webControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    // Lógica adicional para claves dinámicas como "lblUsuarioEmail"
                    if (clave == "lblUsuarioEmail" && Session["Usuario"] != null)
                    {
                        var usuario = Session["Usuario"] as UsuarioBE;
                        if (usuario != null)
                        {
                            // Reemplazar {0} en la traducción con el correo del usuario
                            traduccion = string.Format(traduccion, usuario.Email);
                        }
                    }

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        if (childControl is ITextControl textControl)
                        {
                            textControl.Text = traduccion; // Para controles ASP.NET que tienen propiedad Text
                        }
                        else if (childControl is HtmlGenericControl genericControl)
                        {
                            genericControl.InnerText = traduccion; // Para controles HTML genéricos
                        }
                    }
                }
                else if (childControl is HtmlGenericControl genericControl && genericControl.Attributes["data-translate"] != null)
                {
                    string clave = genericControl.Attributes["data-translate"];
                    string traduccion = IdiomaManager.Instance.GetTraduccion(clave);

                    if (!string.IsNullOrEmpty(traduccion))
                    {
                        genericControl.InnerText = traduccion; // Actualizar contenido para HTML genéricos
                    }
                }

                // Recursivamente aplicar traducciones a los controles hijos
                if (childControl.HasControls())
                {
                    AplicarTraducciones(childControl);
                }
            }
        }




        private string ProcesarHtmlConDataTranslate(string html)
        {
            // Buscar todas las claves `data-translate="clave"` en el HTML y reemplazarlas con traducciones
            string pattern = @"data-translate\s*=\s*""([^""]+)""";
            return System.Text.RegularExpressions.Regex.Replace(html, pattern, match =>
            {
                string translateKey = match.Groups[1].Value; // Capturar la clave de traducción
                string traduccion = IdiomaManager.Instance.GetTraduccion(translateKey);
                return traduccion ?? match.Value; // Si no hay traducción, devolver la clave original
            });
        }

    }
}