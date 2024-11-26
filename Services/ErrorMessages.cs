using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Services
{
    public static class ErrorMessages
    {
        public const string ERR001 = "[ERR001] No se pudo establecer conexión con la Base de Datos.";
        public const string ERR002 = "[ERR002] Campos obligatorios incompletos.";
        public const string ERR003 = "[ERR003] No se pudo procesar la operación.";
        public const string ERR004 = "[ERR004] El producto a dar de baja debe tener stock en cero.";
        public const string ERR005 = "[ERR005] No hay suficiente stock para realizar el ajuste.";
        public const string ERR006 = "[ERR006] El producto no se publicará ya que no posee stock.";
        public const string ERR007 = "[ERR007] Error al querer descargar el comprobante.";
        public const string ERR008 = "[ERR008] No se pudo obtener Token desde AFIP.";
        public const string ERR009 = "[ERR009] No se pudo obtener los puntos de venta de AFIP.";
        public const string ERR010 = "[ERR010] No se pudo enviar el Mail.";
        public const string ERR011 = "[ERR011] No se pudo editar los datos del negocio.";
        public const string ERR012 = "[ERR012] El usuario y/o contraseña incorrectos.";
        public const string ERR013 = "[ERR013] El usuario se encuentra bloqueado.";
        public const string ERR014 = "[ERR014] Error de integridad en la base de datos.";
        public const string ERR015 = "[ERR015] Las contraseñas nuevas no coinciden.";
        public const string ERR016 = "[ERR016] Contraseña actual inválida.";
        public const string ERR017 = "[ERR017] La contraseña no cumple con los requisitos mínimos.";
        public const string ERR018 = "[ERR018] Usuario ya existente.";
        public const string ERR019 = "[ERR019] El nombre de la Familia ya existe.";
        public const string ERR020 = "[ERR020] No se pudo realizar el Backup.";
        public const string ERR021 = "[ERR021] No se pudo realizar el Restore.";
        public const string ERR022 = "[ERR022] No se pudo recalcular los dígitos verificadores.";
        public const string ERR023 = "[ERR023] No se pudo asignar un punto de venta al comprobante.";
        public const string ERR024 = "[ERR024] El comprobante no se pudo numerar.";
        public const string ERR025 = "[ERR025] No se pudo autorizar la Venta en AFIP.";
        public const string ERR026 = "[ERR026] La fecha Desde no puede ser mayor a la fecha hasta";
        public const string ERR027 = "[ERR027] No se pudo recalcular los digitos verificadores";
    }

}
