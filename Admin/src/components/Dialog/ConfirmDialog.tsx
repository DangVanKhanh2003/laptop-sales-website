import {
    Button,
    Dialog,
    DialogActions,
    DialogContent,
    DialogContentText,
    DialogTitle,
} from '@mui/material';
import React from 'react';

const ConfirmDialog: React.FC<{
    open: boolean;
    handleClose: () => void;
    title: string;
    content: string;
    handleConfirmation: () => void;
}> = ({ open, handleClose, title, content, handleConfirmation }) => {
    return (
        <Dialog open={open} onClose={handleClose}>
            <DialogTitle>{title}</DialogTitle>
            <DialogContent>
                <DialogContentText>{content}</DialogContentText>
            </DialogContent>
            <DialogActions>
                <Button
                    onClick={(e) => {
                        e.preventDefault();
                        handleConfirmation();
                        handleClose();
                    }}
                    autoFocus
                >
                    Xác nhận
                </Button>
                <Button autoFocus onClick={handleClose}>
                    Huỷ
                </Button>
            </DialogActions>
        </Dialog>
    );
};

export default ConfirmDialog;
