using BE;
using BE.Composite;
using BE.Enums;
using BE.Factory;
using BE.Permisos;
using DAL;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace BLL
{
    
    public class PermisoBLL
    {
        PermisoDAL _permisoService = new PermisoDAL();
        SessionManager _sessionManager = new SessionManager();
        public void GuardarFamiliaCreada(Familia familia)
        {
            using (TransactionScope scope = new TransactionScope())
            {
                _permisoService.GuardarFamiliaCreada(familia);

                var UsuarioBELogueado = _sessionManager.Get<UsuarioBE>("Usuario");
                //_bitacoraService.AltaBitacora($"{UsuarioBELogueado.RazonSocial} ({UsuarioBELogueado.Id}) guardó la familia {familia.Id}", Criticidad.Alta, UsuarioBELogueado);

                //_digitoVerificadorService.RecalcularDigitosPermisoDTO(this);
                //_digitoVerificadorService.RecalcularDigitosFamiliaPatente(this);

                scope.Complete();
            }
        }

        public int GuardarPatenteFamilia(Componente componente, bool familia)
        {
            using (TransactionScope scope = new TransactionScope())
            {
                int id = _permisoService.GuardarPatenteFamilia(componente, familia);

                var UsuarioBELogueado = _sessionManager.Get<UsuarioBE>("Usuario");
                //_bitacoraService.AltaBitacora($"{UsuarioBELogueado.RazonSocial} ({UsuarioBELogueado.Id}) guardó la patente/familia {id}", Criticidad.Alta, UsuarioBELogueado);

                //_digitoVerificadorService.RecalcularDigitosPermisoDTO(this);
                //_digitoVerificadorService.RecalcularDigitosFamiliaPatente(this);

                scope.Complete();

                return id;
            }
        }

        public void GuardarPermiso(UsuarioBE UsuarioBE)
        {
            using (TransactionScope scope = new TransactionScope())
            {
                _permisoService.BorrarPermisoUsuario(UsuarioBE);

                if (UsuarioBE.Permisos.Count > 0)
                {
                    foreach (Componente item in UsuarioBE.Permisos)
                    {
                        Componente permiso = item.Id > 0 ? item : PermisoFactory.CrearPermiso(item.Permiso, item.Id);

                        UsuarioPermisoBE usuarioPermisosDVH = new UsuarioPermisoBE
                        {
                            UsuarioId = UsuarioBE.Id,
                            PermisoId = permiso.Id
                        };

                        //string DVH = DigitoVerificador.GenerarDVH(usuarioPermisosDVH);
                        //_permisoService.GuardarPermiso(UsuarioBE, permiso, DVH);
                        _permisoService.GuardarPermiso(UsuarioBE, permiso, "1");
                    }
                }

                var UsuarioBELogueado = _sessionManager.Get<UsuarioBE>("Usuario");
                //_bitacoraService.AltaBitacora($"{UsuarioBELogueado.RazonSocial} ({UsuarioBELogueado.Id}) cambió los permisos de: {UsuarioBE.RazonSocial} ({UsuarioBE.Id})",
                //    Criticidad.Alta,
                //    UsuarioBELogueado
                //);

                //_digitoVerificadorService.ActualizarDVV("UsuarioPermiso");

                scope.Complete();
            }
        }

        public List<Componente> TraerFamiliaPatentes(int familiaId)
        {
            List<Componente> componentes = _permisoService.TraerFamiliaPatentes(familiaId);
            return componentes;
        }

        public Componente GetFamiliaArbol(int familiaId, Componente componenteOriginal, Componente componenteAgregar)
        {
            Componente comp = _permisoService.GetFamiliaArbol(familiaId, componenteOriginal, componenteAgregar);
            return comp;
        }

        public Componente GetUsuarioArbol(int usuarioId, Componente componenteOriginal, Componente componenteAgregar)
        {
            Componente comp = _permisoService.GetUsuarioArbol(usuarioId, componenteOriginal, componenteAgregar);
            return comp;
        }

        public List<Familia> GetFamilias()
        {
            List<Familia> familias = _permisoService.GetFamilias();
            return familias;
        }

        public List<Patente> GetPatentes()
        {
            List<Patente> patentes = _permisoService.GetPatentes();
            return patentes;
        }

        public Array TraerPermisos()
        {
            return Enum.GetValues(typeof(Permiso));
        }

        public List<Familia> GetFamiliasValidacion(int familiaId)
        {
            List<Familia> familias = _permisoService.GetFamiliasValidacion(familiaId);
            return familias;
        }

        public bool ExisteComponente(Componente componente, int Id)
        {
            bool existeComponente = false;

            if (componente.Id.Equals(Id))
                existeComponente = true;

            else
            {
                foreach (var item in componente.Hijos)
                {
                    existeComponente = ExisteComponente(item, Id);
                    if (existeComponente) return true;
                }
            }

            return existeComponente;
        }

        public void GetComponenteUsuario(UsuarioBE UsuarioBE)
        {
            _permisoService.GetComponenteUsuario(UsuarioBE);
        }

        public void GetComponenteFamilia(Familia familia)
        {
            familia.VaciarHijos();
            foreach (Componente item in TraerFamiliaPatentes(familia.Id))
            {
                familia.AgregarHijo(item);
            }
        }

        public List<UsuarioPermisoBE> GetUsuariosPermisos()
        {
            List<UsuarioPermisoBE> usuariosPermisos = _permisoService.GetUsuariosPermisos();
            return usuariosPermisos;
        }

        public List<PermisoBE> GetPermisoBE()
        {
            List<PermisoBE> permisos = _permisoService.GetPermisosBE();
            return permisos;
        }

        public List<FamiliaPatenteBE> GetFamiliaPatenteBE()
        {
            List<FamiliaPatenteBE> familiaPatente = _permisoService.GetFamiliaPatenteBE();
            return familiaPatente;
        }
    }
}
