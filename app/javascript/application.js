// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "bootstrap";
import Sortable from "sortablejs";

document.addEventListener("DOMContentLoaded", () => {
  document.querySelectorAll(".sortable-column").forEach(column => {
    new Sortable(column, {
      group: "shared",
      animation: 150,
      onEnd: function (evt) {
        const taskAssignmentId = evt.item.dataset.taskAssignmentId;
        const newColumnId = evt.to.dataset.columnId; 

        if (!taskAssignmentId || !newColumnId) {
          alert("Erro ao obter informações da tarefa ou coluna.");
          return;
        }

        fetch(`/task_assignments/${taskAssignmentId}`, {
          method: "PATCH",
          headers: {
            "Content-Type": "application/json",
            "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]').content,
          },
          body: JSON.stringify({ board_column_id: newColumnId }),
        })
          .then(response => {
            if (!response.ok) {
              alert("Erro ao mover a tarefa.");
            } else {
              window.location.reload();
            }
          })
          .catch(() => {
            alert("Erro ao mover a tarefa.");
          });
      },
    });
  });
});
