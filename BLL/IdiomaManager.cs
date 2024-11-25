using System;
using System.Collections.Generic;
using DAL;

namespace BLL
{
    public class IdiomaManager
    {
        private static IdiomaManager _instance;
        private Dictionary<string, Dictionary<string, string>> _traducciones;
        private string _idiomaActual = "es";
        private List<IIdiomaObserver> _observadores = new List<IIdiomaObserver>();

        public string IdiomaActual
        {
            get { return _idiomaActual; }
        }
        private IdiomaManager()
        {
            // Cargar traducciones desde DAL
            var dal = new TraduccionDAL();
            _traducciones = dal.CargarTraducciones();
        }

        public static IdiomaManager Instance
        {
            get
            {
                if (_instance == null)
                {
                    _instance = new IdiomaManager();
                }
                return _instance;
            }
        }

        public string GetTraduccion(string clave)
        {
            if (_traducciones.TryGetValue(_idiomaActual, out var idiomaTraducciones) && idiomaTraducciones.ContainsKey(clave))
            {
                return idiomaTraducciones[clave];
            }
            return clave; // Devuelve la clave si no encuentra la traducción
        }

        public void CambiarIdioma(string idioma)
        {
            if (_traducciones.ContainsKey(idioma))
            {
                _idiomaActual = idioma;
                NotificarObservadores();
            }
        }

        public void RegistrarObservador(IIdiomaObserver observador)
        {
            if (!_observadores.Contains(observador))
            {
                _observadores.Add(observador);
            }
        }

        public void EliminarObservador(IIdiomaObserver observador)
        {
            if (_observadores.Contains(observador))
            {
                _observadores.Remove(observador);
            }
        }

        private void NotificarObservadores()
        {
            foreach (var observador in _observadores)
            {
                observador.UpdateIdioma(_idiomaActual);
            }
        }
    }
}
