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
import Compressor from 'compressorjs';


const TextField = styled(TextValidator)(() => ({
  width: "100%",
  marginBottom: "16px",
}));



const SimpleForm = () => {
  const [state, setState] = useState({ date: new Date() });
  const [Image, setImage] = useState();
  const  [imageUl, setImageUl] = useState('');

  async function uploadImage(event) {
    const file = event.target.files[0];
  
    // Comprimir la imagen antes de subirla
    new Compressor(file, {
      quality: 0.2, // Calidad de compresión de la imagen, del 0 al 1
      async success(result) {
        const formData = new FormData();
        formData.append('image', result, result.name);
  
        // Subir la imagen a la API utilizando fetch
        const response = await fetch('https://srv37158-15190.vps.etecsa.cu/upload', {
          method: 'POST',
          body: formData
        });
  
        if (response.ok) {
          const data = await response.json();
          setImageUl(data['fileUrl'])
          console.log('Imagen subida correctamente:', data['fileUrl']);
        } else {
          console.error('Error al subir la imagen:', response.statusText);
        }
      },
      error(error) {
        console.error('Error al comprimir la imagen:', error.message);
      },
    });
  }


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
      console.log(imageUl)
      if (!imageUl) {
        alert('Por favor suba una Imagen..')
      }else{
        const payload = {
          userId: 1,
          amountGarbage: parseInt(state.amountGarbage),
          stat: false,
          image_url: "https://srv37158-15190.vps.etecsa.cu"+imageUl,
          locations: state.adress,
        };
        const response = await fetch("https://srv37158-15190.vps.etecsa.cu/api/v1/requests", {
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
      }
      
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
    imageUrl = "https://us.123rf.com/450wm/hemul75/hemul752208/hemul75220800028/191483798-relleno-sanitario-basura-residuos-ecolog%C3%ADa-3d-rendering.jpg?ver=6",
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
            <Input required='true' type="file" mane="image" onChange={uploadImage} multiple />

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
