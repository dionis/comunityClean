//import { DatePicker } from "@mui/lab";
//import AdapterDateFns from "@mui/lab/AdapterDateFns";
//import LocalizationProvider from "@mui/lab/LocalizationProvider";
import {
  Button,
  Checkbox,
  FormControlLabel,
  Grid,
  Icon,
  Input,
  styled,
} from "@mui/material";
import { Span } from "app/components/Typography";
import { useEffect, useState } from "react";
import { TextValidator, ValidatorForm } from "react-material-ui-form-validator";
import AlertDialog from "../../dialog/SimpleAlerts";
// import UseAuth from "app/hooks/useAuth";
import CustomizedSnackbars from "../../snackbar/CustomizedSnackbar";

const TextField = styled(TextValidator)(() => ({
  width: "100%",
  marginBottom: "16px",
}));

const SimpleForm = () => {
  const [state, setState] = useState({ date: new Date() });
  const [Image, setImage] = useState();

  useEffect(() => {
    ValidatorForm.addValidationRule("isPasswordMatch", (value) => {
      if (value !== state.password) return false;

      return true;
    });
    return () => ValidatorForm.removeValidationRule("isPasswordMatch");
  }, [state.password]);

  const handleSubmit = async () => {
    try {
      // const { logout, logUser } = UseAuth();
      const payload = {
        user: "63dd26c9684b6d1d7b3e0c51",
        amountGarbage: state.amountGarbage,
        stat: false,
        image_url: "https://google.com",
        locations: state.adress,
      };
      const response = await fetch("http://localhost:8000/api/v1/requests", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(payload),
      });
      const rawRes = await response.json();
      const res = `Registro exitoso de solicitud de recogida en ${rawRes.locations} de ${rawRes.amountGarbage} metros cubicos de basura`;
      alert(res)
      // return <CustomizedSnackbars res={res}/>
    } catch (e) {
      console.log("Error" + e);
    }
  };


  const changeImage = (e) => {
    setImage(e.target.files[0]);
    console.log(Image);
  };

  const handleChange = (event) => {
    event.persist();
    setState({ ...state, [event.target.name]: event.target.value });
  };

  //const handleDateChange = (date) => setState({ ...state, date });

  const {
    username,
    amountGarbage,
    adress,
    imageUrl = "https://google.com",
  } = state;

  return (
    <div>
      <ValidatorForm onSubmit={handleSubmit} onError={() => null}>
        <Grid container spacing={6}>
          <Grid item lg={6} md={6} sm={12} xs={12} sx={{ mt: 2 }}>
            <TextField
              type="text"
              name="adress"
              label="Address"
              onChange={handleChange}
              value={adress || ""}
              validators={["required"]}
              errorMessages={["This field is required"]}
            />

            <TextField
              type="number"
              name="amountGarbage"
              label="Quantity in cubic meters"
              value={amountGarbage || ""}
              onChange={handleChange}
              validators={["required"]}
              errorMessages={[
                "This field is required",
                "amountGarbage is not valid",
              ]}
            />
          </Grid>

          <Grid item lg={6} md={6} sm={12} xs={12} sx={{ mt: 2 }}>
            <Input type="file" mane="image" onChange={changeImage} multiple />

            <FormControlLabel
              control={<Checkbox />}
              label="I have read and agree to the terms of service."
            />
          </Grid>
        </Grid>

        <Button color="primary" variant="contained" type="submit">
          <Icon>send</Icon>
          <Span sx={{ pl: 1, textTransform: "capitalize" }}>Submit</Span>
        </Button>
      </ValidatorForm>
    </div>
  );
};

export default SimpleForm;
