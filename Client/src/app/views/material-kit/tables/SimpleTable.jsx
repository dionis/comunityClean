import {
  Box,
  Icon,
  IconButton,
  Fab,
  styled,
  Table,
  TableBody,
  TableCell,
  TableHead,
  TableRow,
} from "@mui/material";
import { Breadcrumb, SimpleCard } from "app/components";
import SimpleDialogDemo from "../dialog/SimpleDialog";

import { useEffect, useState } from "react";
import { CloseFullscreen } from "@mui/icons-material";
import FormDialog from "../dialog/FormDialog";
import AlertDialogSlide from "../dialog/DialogTransition";

const StyledTable = styled(Table)(({ theme }) => ({
  whiteSpace: "pre",
  "& thead": {
    "& tr": { "& th": { paddingLeft: 0, paddingRight: 0 } },
  },
  "& tbody": {
    "& tr": { "& td": { paddingLeft: 0, textTransform: "capitalize" } },
  },
}));

const SimpleTable = () => {
  const [subscribarList, setSubscribarList] = useState([]);

  useEffect(() => {
    const getList = async () => {
      const response = await fetch(
        "https://srv37158-15190.vps.etecsa.cu/api/v1/requests/user/1",
        {
          method: "GET",
          headers: {
            "Content-Type": "application/json",
          },
        }
      );
      const objeto = await response.json();
      let lista = objeto.map((obj) => {
        return {
          id: obj.id,
          amountGarbage: obj.amountGarbage,
          stat: obj.stat,
          image_url: obj.image_url,
          locations: obj.locations,
        };
      });
      setSubscribarList(lista);
    };
    getList();
  }, []);
  return (
    <Box width="100%" overflow="auto">
      <StyledTable>
        <TableHead>
          <TableRow>
            <TableCell align="center">Id de Solicitud</TableCell>
            <TableCell align="center">Cantidad de Basura</TableCell>
            <TableCell align="center">Estado</TableCell>
            <TableCell align="center">Imágenes</TableCell>
            <TableCell align="center">Dirección</TableCell>
            <TableCell align="center">Editar</TableCell>
            <TableCell align="center">Eliminar</TableCell>
          </TableRow>
        </TableHead>
        <TableBody>
          {subscribarList.map((subscriber, index) => (
            <TableRow key={index}>
              <TableCell align="center">{subscriber.id}</TableCell>
              <TableCell align="center">{subscriber.amountGarbage}</TableCell>
              <TableCell align="center">
                {subscriber.stat ? "Hecha" : "Pendiente"}
              </TableCell>
              <TableCell align="center"><img src={subscriber.image_url}  style={{ width: '50%' }}/></TableCell>
              <TableCell align="center">{subscriber.locations}</TableCell>
              <TableCell align="center">
                <SimpleCard>
                  <FormDialog subscriber={subscriber} />
                </SimpleCard>
              </TableCell>

              <TableCell align="center">
                <SimpleCard
                  align="center"
                  variant="primary"
                  aria-label="Delete"
                  className="button"
                >
                  <AlertDialogSlide subscriber={subscriber} />
                </SimpleCard>
              </TableCell>
            </TableRow>
          ))}
        </TableBody>
      </StyledTable>
    </Box>
  );
};

export default SimpleTable;
