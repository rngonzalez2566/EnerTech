<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="12-RestablecerPassword.aspx.cs" Inherits="UI._12_RestablecerPassword" %>


<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="utf-8" />
    <title>Restablecer Contraseña</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>

<body>


    <!-- CONTENIDO -->
    <div class="container mt-5">
        <div class="row justify-content-center">
            <div class="col-12 col-md-6 col-lg-4">

                <form id="formRestablecerPassword" runat="server">
                    <div class="card shadow-sm">
                        <div class="card-body">

                            <h1 class="form-title text-center mb-4"
                                runat="server"
                                data-translate="reset_password_title">
                                Restablecer Contraseña
                            </h1>

                            <div class="mb-3">
                                <label for="txtEmail"
                                       class="form-label"
                                       runat="server"
                                       data-translate="email">
                                    Correo Electrónico
                                </label>

                                <asp:TextBox ID="txtEmail"
                                             runat="server"
                                             CssClass="form-control"
                                             TextMode="Email"
                                             data-translate-placeholder="reset_password_email_placeholder" />
                            </div>

                            <asp:Button ID="btnResetPassword"
                                        runat="server"
                                        CssClass="btn btn-primary w-100"
                                        data-translate="reset_password_button"
                                        OnClick="btnResetPassword_Click" />
                        </div>
                    </div>
                </form>

            </div>
        </div>
    </div>

    <div class="position-fixed bottom-0 end-0 p-3" style="z-index: 1080">
    <div id="appToast" class="toast align-items-center text-white border-0"
         role="alert" aria-live="assertive" aria-atomic="true">
        <div class="d-flex">
            <div class="toast-body" id="toastMessage">
                <!-- mensaje dinámico -->
            </div>
            <button type="button" class="btn-close btn-close-white me-2 m-auto"
                    data-bs-dismiss="toast"></button>
        </div>
    </div>
</div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    function showToast(message, type) {
        const toastEl = document.getElementById('appToast');
        const toastMsg = document.getElementById('toastMessage');

        toastMsg.innerText = message;

        // tipos: success | danger | warning | info
        toastEl.className = `toast align-items-center text-white bg-${type} border-0`;

        const toast = new bootstrap.Toast(toastEl, { delay: 4000 });
        toast.show();
    }
</script>
</body>
</html>
