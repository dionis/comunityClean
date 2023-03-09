import { Box } from "@mui/material";
import Button from "@mui/material/Button";
import Dialog from "@mui/material/Dialog";
import DialogActions from "@mui/material/DialogActions";
import DialogContent from "@mui/material/DialogContent";
import DialogContentText from "@mui/material/DialogContentText";
import DialogTitle from "@mui/material/DialogTitle";
import TextField from "@mui/material/TextField";
import React from "react";
import { Icon, Fab } from "@mui/material";
import { useEffect, useState } from "react";

export default function FormDialog(properties) {
  const [open, setOpen] = React.useState(false);
  const [state, setState] = useState({});

  let { amountGarbage, locations } = state;

  async function updateRequest() {
    const payload = {
      amountGarbage: state.amountGarbage,
      locations: state.locations
    }
    const response = await fetch(
      "http://localhost:8000/api/v1/requests/"+properties.subscriber._id,
      {
        method: "PUT",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payload)
      }
    );
    const objeto = await response.json();
    handleClose()
    window.location.reload()
  }

  function handleClickOpen() {
    state.amountGarbage = properties.subscriber.amountGarbage;
    state.locations = properties.subscriber.locations;
    setOpen(true);
  }

  function handleClose() {
    setOpen(false);
  }

  const handleChange = (event) => {
    event.persist();
    setState({ ...state, [event.target.name]: event.target.value });
  };
  return (
    <Box>
      <Button color="primary" onClick={handleClickOpen}>
        <Fab align="right" color="primary" aria-label="Edit" className="button">
          <Icon>edit_icon</Icon>
        </Fab>
      </Button>

      <Dialog
        open={open}
        onClose={handleClose}
        aria-labelledby="form-dialog-title"
      >
        <DialogTitle id="form-dialog-title">Editar Solicitud</DialogTitle>
        <DialogContent>
          <DialogContentText>
            Cambie solo los formularios que estime convenientes, los demás puede
            dejarlos por defecto
          </DialogContentText>
          <TextField
            autoFocus
            margin="dense"
            id="amountGarbage"
            name="amountGarbage"
            label="Cantidad de Basura"
            type="number"
            onChange={handleChange}
            value={amountGarbage}
            fullWidth
          />
          <TextField
            margin="dense"
            id="location"
            name="locations"
            label="Dirección"
            onChange={handleChange}
            value={locations}
            type="text"
            fullWidth
          />
        </DialogContent>
        <DialogActions>
          <Button variant="outlined" color="primary" onClick={handleClose}>
            Cancel
          </Button>
          <Button
            variant="outlined"
            onClick={updateRequest}
            color="primary"
          >
            Aceptar
          </Button>
        </DialogActions>
      </Dialog>
    </Box>
  );
}
