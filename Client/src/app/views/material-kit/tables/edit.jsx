import React from 'react'
import {Button, Dialog,DialogActions, DialogContent, DialogContentText, DialogTitle} from '@mui/material'
export default class FormDialog extends React.Component {
  state = {
    open: false,
  }
  handleClickOpen = () => {
    this.setState({ open: true })
  }
  handleClose = () => {
    this.setState({ open: false })
  }
  render() {
    return (
      <div>
        <Button variant="outlined" color="primary" onClick={this.handleClickOpen}>
          Open form dialog
        </Button>
        <Dialog
          open={this.state.open}
          onClose={this.handleClose}
          aria-labelledby="form-dialog-title"
        >
          <DialogTitle id="form-dialog-title">Subscribe</DialogTitle>
          <DialogContent>
            <DialogContentText>
              To subscribe to this website, please enter your email address here. We will send
              updates occasionally.
            </DialogContentText>
            {/* Aquí iría el form */}
          </DialogContent>
          <DialogActions>
            <Button onClick={this.handleClose} color="primary">
              Cancel
            </Button>
            <Button onClick={this.handleClose} color="primary">
              Subscribe
            </Button>
          </DialogActions>
        </Dialog>
      </div>
    )
  }
}