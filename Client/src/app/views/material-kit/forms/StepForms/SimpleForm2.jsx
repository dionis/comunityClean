import React from "react";
import { useState } from "react";
import { Grid, Input, styled } from "@mui/material";
import { TextValidator, ValidatorForm } from "react-material-ui-form-validator";

const TextField = styled(TextValidator)(() => ({
  width: "100%",
  marginBottom: "16px",
}));

const SimpleForm = () => {
  const [selectedFile, setSelectedFile] = useState(null);

  const handleSubmit = (event) => {
    
    console.log("submitted");
    console.log(event);
  };

  return (
    <div>
      <ValidatorForm onSubmit={handleSubmit} onError={() => null}>
        <Grid container spacing={6}>
          <Grid item lg={6} md={6} sm={12} xs={12} sx={{ mt: 2 }}>
            <Input
              accept="image//*"
              type="file"
              multiple
              name="file"
              onChange={(e) => setSelectedFile(e.target.files[0])}
            />
          </Grid>

          <Grid item lg={6} md={6} sm={12} xs={12} sx={{ mt: 2 }}></Grid>
        </Grid>
      </ValidatorForm>
    </div>
  );
};

export default SimpleForm;
