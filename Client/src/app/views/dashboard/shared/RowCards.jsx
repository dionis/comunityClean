import {
  Avatar,
  Box,
  Card,
  Fab,
  Grid,
  Hidden,
  styled,
  useTheme,
} from '@mui/material';
import { Span } from 'app/components/Typography';
import { format } from 'date-fns';
import { Fragment } from 'react';

const ProjectName = styled(Span)(({ theme }) => ({
  marginLeft: 24,
  fontWeight: '500',
  [theme.breakpoints.down('sm')]: { marginLeft: 4 },
}));

const StarOutline = styled(Fab)(() => ({
  marginLeft: 0,
  boxShadow: 'none',
  background: '#08ad6c !important',
  backgroundColor: 'rgba(9, 182, 109, 1) !important',
}));

const DateRange = styled(Fab)(({ theme }) => ({
  marginLeft: 0,
  boxShadow: 'none',
  color: 'white !important',
  background: `${theme.palette.error.main} !important`,
}));

const StyledAvatar = styled(Avatar)(() => ({
  width: '32px !important',
  height: '32px !important',
}));

const RowCards = () => {
  const { palette } = useTheme();
  const textMuted = palette.text.secondary;

  return [1, 2, 3, 4].map((id) => (
    <Fragment key={id}>
      <Card sx={{ py: 1, px: 2 }} className="project-card">
        <Grid container alignItems="center">
          
          <Grid item md={5} xs={7}>
            <Box display="flex" alignItems="center">
              <ProjectName>Project {id}</ProjectName>
            </Box>
          </Grid>

          <Grid item md={3} xs={4}>
            <Box color={textMuted}>{format(new Date().getTime(), 'MM/dd/yyyy hh:mma')}</Box>
          </Grid>

        </Grid>
      </Card>
      <Box py={1} />
    </Fragment>
  ));
};

export default RowCards;
