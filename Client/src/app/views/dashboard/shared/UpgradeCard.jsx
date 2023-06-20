import { Button, Card, styled,Grid } from '@mui/material';
import { convertHexToRGB } from 'app/utils/utils';

const CardRoot = styled(Card)(({ theme }) => ({
  marginBottom: '24px',
  padding: '24px !important',
  [theme.breakpoints.down('sm')]: { paddingLeft: '16px !important' },
}));

const StyledCard = styled(Card)(({ theme }) => ({
  boxShadow: 'none',
  textAlign: 'center',
  position: 'relative',
  padding: '24px !important',
  background: `rgb(${convertHexToRGB(theme.palette.primary.main)}, 0.15) !important`,
  [theme.breakpoints.down('sm')]: { padding: '16px !important' },
}));

const Paragraph = styled('p')(({ theme }) => ({
  margin: 0,
  paddingTop: '24px',
  paddingBottom: '24px',
  color: theme.palette.text.secondary,
}));

const UpgradeCard = () => {
  return (
    <Grid container spacing={3} sx={{ mb: 3 }}>
      <Grid item xs={12} md={4}>
    <CardRoot>
      <StyledCard elevation={0}>
        <img src="/assets/car.png" style={{ width: '100px', height : '100px' }} alt="upgrade" />

        <Paragraph>
        Solicita la recogida de basura en tu hogar con un solo clic
        </Paragraph>

        <Button
          size="large"
          color="primary"
          variant="contained"
          sx={{ textTransform: 'uppercase' }}
        ><a href='/material/form'>

          Solicitar
        </a>
        </Button>
      </StyledCard>
    </CardRoot>
    </Grid>
    <Grid item xs={12} md={4}>
    <CardRoot>
      <StyledCard elevation={0}>
      <img src="/assets/trees.png" style={{ width: '100px', height : '120px' }} alt="upgrade" />

        <Paragraph>
        Solicita la poda de árboles en tu hogar con un solo clic
        </Paragraph>

        <Button
          size="large"
          color="primary"
          variant="contained"
          sx={{ textTransform: 'uppercase' }}
        >
          Solicitar
        </Button>
      </StyledCard>
    </CardRoot>
    </Grid>
    <Grid item xs={12} md={4}>
    <CardRoot>
      <StyledCard elevation={0}>
      <img src="/assets/pluss.png" style={{ width: '110px', height : '120px' }} alt="upgrade" />
      <Paragraph>
        Agregar nuevos servicios a la plataforma.
        </Paragraph>

        <Button
          size="large"
          color="primary"
          variant="contained"
          sx={{ textTransform: 'uppercase' }}
        >
          Agregar
        </Button>
      </StyledCard>
    </CardRoot>
    </Grid>
    </Grid>
  );
};

export default UpgradeCard;
