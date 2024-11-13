<%@ Control Language="C#" AutoEventWireup="true" CodeBehind="GenericModal.ascx.cs" Inherits="UI.GenericModal" %>
<!-- Bootstrap Modal -->
<div class="modal fade" id="messageModal" tabindex="-1" aria-labelledby="messageModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="messageModalLabel">Mensaje</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body" id="messageModalBody">
                <!-- Aquí se insertará el mensaje dinámico -->
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-bs-dismiss="modal">Aceptar</button>
            </div>
        </div>
    </div>
</div>

<!-- Script para mostrar el modal con mensaje dinámico -->
<script type="text/javascript">
    function showMessageModal(message) {
        // Establecer el mensaje en el cuerpo del modal
        document.getElementById('messageModalBody').innerText = message;

        // Mostrar el modal usando Bootstrap
        var modal = new bootstrap.Modal(document.getElementById('messageModal'));
        modal.show();
    }
</script>