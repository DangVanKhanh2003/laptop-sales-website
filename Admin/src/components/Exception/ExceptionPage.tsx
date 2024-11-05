import { Button, Typography } from '@mui/material';
import React from 'react';

const ExceptionPage: React.FC<{ message: string; onRetry?: () => void }> = ({
    message,
    onRetry,
}) => {
    return (
        <div>
            <Typography variant='body1'>{message}</Typography>
            {onRetry !== undefined ? <Button onClick={onRetry}>Thử lại</Button> : <></>}
        </div>
    );
};

export default ExceptionPage;
