import { IconButton, Snackbar } from '@mui/material';
import React from 'react';
import CloseIcon from '@mui/icons-material/Close';

const BottomSnackbar: React.FC<{
    openSnackbar: boolean;
    setOpenSnackBar: (value: boolean) => void;
    message: string;
}> = ({ openSnackbar, setOpenSnackBar, message }) => {
    return (
        <Snackbar
            open={openSnackbar}
            autoHideDuration={6000}
            onClose={() => setOpenSnackBar(false)}
            message={message}
            action={
                <React.Fragment>
                    <IconButton
                        size='small'
                        aria-label='close'
                        color='inherit'
                        onClick={() => setOpenSnackBar(false)}
                    >
                        <CloseIcon fontSize='small' />
                    </IconButton>
                </React.Fragment>
            }
        />
    );
};

export default BottomSnackbar;
