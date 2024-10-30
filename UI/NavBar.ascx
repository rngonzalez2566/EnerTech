<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="NavBar.ascx.cs" Inherits="UI.NavBar" %>

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
            padding: 10px 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        /* Contenedor de los enlaces centrado */
        .nav-center {
            display: flex;
            flex-grow: 1;
            justify-content: center;
            align-items: center;
        }

        .nav-links {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 30px; /* Espaciado entre los enlaces */
        }

        nav a {
            color: white;
            text-decoration: none;
            font-size: 18px;
            transition: color 0.3s;
        }

        nav a:hover {
            color: #aed581;
        }

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
            right: 0;
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

           nav a:hover, .dropdown-link:hover {
            color: #aed581;
        }
          .dropdown-link {
        color: #00796b !important; /* Color del texto */
        background: none;
        border: none;
        cursor: pointer;
        text-align: left;
        padding: 12px 16px;
        display: block;
        width: 100%;
        font-size: 16px;
        text-decoration: none;
    }

    .dropdown-link:hover {
        background-color: #f1f1f1;
        text-decoration: none;
    }

            .dropdown-content a:hover, .dropdown-content .dropdown-link:hover {
            background-color: #f1f1f1;
        }

        .dropdown:hover .dropdown-content {
            display: block;
        }

        /* Contenedor del icono de perfil */
        .profile-container {
            display: flex;
            justify-content: flex-end;
            align-items: center;
        }

        .profile-icon {
            cursor: pointer;
            position: relative;
        }

        .profile-icon img {
            width: 40px;
            height: 40px;
            border-radius: 50%;
        }

        /* Menú desplegable para perfil */
        .profile-dropdown {
            display: none;
            position: absolute;
            background-color: #ffffff;
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.1);
            right: 0;
            top: 60px;
            min-width: 150px;
            border-radius: 5px;
            overflow: hidden;
            z-index: 100;
        }

        .profile-dropdown a {
            padding: 12px 16px;
            display: block;
            color: #00796b;
            text-decoration: none;
        }

        .profile-dropdown a:hover {
            background-color: #f1f1f1;
        }

        .profile-dropdown.show {
            display: block;
        }

        /* Ajuste del contenido principal */
        .content {
            text-align: center;
            margin: 30px auto;
            width: 60%;
        }

        h1 {
            color: #00796b;
        }

        .user-info {
            text-align: center;
            margin: 30px auto;
        }

        .user-image {
            border: 2px solid #00796b;
            padding: 10px;
            display: inline-block;
            width: 200px;
            height: 200px;
            overflow: hidden;
            position: relative;
        }

        .user-image img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            border-radius: 0;
        }
    </style>
    <script>
        function toggleProfileMenu() {
            var profileMenu = document.getElementById("profileMenu");
            profileMenu.classList.toggle("show");
        }
    </script>


    
    <nav id="navigationBar"  runat="server">
   
    </nav>


