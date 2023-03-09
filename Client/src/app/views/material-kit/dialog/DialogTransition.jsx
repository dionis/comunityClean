import { Fab, Icon } from "@mui/material";
import Button from "@mui/material/Button";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import DialogContentText from "@mui/material/DialogContentText";
import DialogTitle from "@mui/material/DialogTitle";
import Slide from "@mui/material/Slide";
import { get } from "lodash";
import React from "react";
import CustomizedSnackbars from "../snackbar/CustomizedSnackbar"

const Transition = React.forwardRef(function Transition(props, ref) {
  return <Slide direction="up" ref={ref} {...props} />;
});

export default function AlertDialogSlide(sub) {
  const [open, setOpen] = React.useState(false);

  function handleClickOpen() {
    console.log(sub.subscriber._id);
    setOpen(true);
  }

  function handleClose() {
    setOpen(false);
  }

  const deleteRequest = async (sub) => {
    const id = sub.subscriber._id;

    const response = await fetch(
      "http://localhost:8000/api/v1/requests/" + id,
      {
        method: "DELETE",
        headers: {
          "Content-Type": "application/json",
        },
      }
    );
    const deleted = await response.json();
    console.log(deleted);
    if (deleted.deletedCount === 0) {
      alert("No se ha encontrado la solicitud");
    }
    if (deleted.message) {
      alert(deleted.message);
    }
    window.location.reload();
  };

  return (
    <div>
      <Button color="primary" onClick={handleClickOpen}>
        <Fab>
          <Icon>delete</Icon>
        </Fab>
      </Button>
      <Dialog
        open={open}
        keepMounted
        onClose={handleClose}
        TransitionComponent={Transition}
        aria-labelledby="alert-dialog-slide-title"
        aria-describedby="alert-dialog-slide-description"
      >
        <DialogTitle id="alert-dialog-slide-title">
          ¿Desea eliminar esta solicitud?
        </DialogTitle>

        <DialogContent>
          <DialogContentText id="alert-dialog-slide-description">
            Si elimina esta solicitud no será posible recuperarla.
            ¿Tiene total seguridad de la accion?
          </DialogContentText>
        </DialogContent>

        <DialogActions>
          <Button onClick={handleClose} color="primary">
            Cancelar
          </Button>

          <Button onClick={handleClose} onClickCapture={()=> { deleteRequest(sub)}}color="primary">
            Aceptar
          </Button>
        </DialogActions>
      </Dialog>
    </div>
  );
}


