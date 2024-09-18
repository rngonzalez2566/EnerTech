<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="13-MenuPrincipal.aspx.cs" Inherits="UI._13_MenuPrincipal" %>



<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Menú Principal</title>
    <style>
        body {
            margin: 0;
            padding: 0;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background-color: #f4f4f4;
        }

        /* Barra de navegación */
        nav {
            background-color: #00796b;
            color: white;
            padding: 20px;
            text-align: center;
            position: relative;
        }

        nav a {
            color: white;
            text-decoration: none;
            margin: 0 15px;
            font-size: 18px;
            transition: color 0.3s;
        }

        nav a:hover {
            color: #aed581;
        }

        /* Menú desplegable */
        .dropdown {
            display: inline-block;
            position: relative;
        }

        .dropdown-content {
            display: none;
            position: absolute;
            background-color: #f9f9f9;
            min-width: 200px;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
            z-index: 1;
        }

        .dropdown-content a {
            color: #00796b;
            padding: 12px 16px;
            text-decoration: none;
            display: block;
            text-align: left;
        }

        .dropdown-content a:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* Contenido principal */
        .content {
            padding: 20px;
            text-align: center;
        }

        h1 {
            color: #00796b;
        }
    </style>
</head>
<body>
    <!-- Barra de navegación con submenús -->
    <nav>
        <div class="dropdown">
            <a href="20-Usuarios.aspx">Usuarios</a>
            <div class="dropdown-content">
                <a href="21-AltaUsuario.aspx">Alta Usuario</a>
                <a href="22-ModificacionUsuario.aspx">Modificación Usuario</a>
                <a href="23-CambiarContraseña.aspx">Cambiar Contraseña</a>
                <a href="24-BajaUsuario.aspx">Baja Usuario</a>
            </div>
        </div>
        <div class="dropdown">
            <a href="30-Permisos.aspx">Permisos</a>
            <div class="dropdown-content">
                <a href="31-AsignarPermiso.aspx">Asignar Permiso</a>
                <a href="32-AsignarPermisoFamilia.aspx">Asignar Permiso a Familia</a>
            </div>
        </div>
        <div class="dropdown">
            <a href="40-Familias.aspx">Familias</a>
            <div class="dropdown-content">
                <a href="41-CrearFamilias.aspx">Crear Familias</a>
                <a href="42-ModificarFamilias.aspx">Modificar Familias</a>
            </div>
        </div>
        <a href="50-Backup.aspx">Backup</a>
        <a href="60-Bitacora.aspx">Bitácora</a>
    </nav>

    <!-- Contenido principal -->
    <div class="content">
        <h1>Menú Principal</h1>
        <p>Bienvenido al sistema de administración. Selecciona una de las opciones en la barra de navegación para gestionar el sistema.</p>
    </div>
</body>
</html>
