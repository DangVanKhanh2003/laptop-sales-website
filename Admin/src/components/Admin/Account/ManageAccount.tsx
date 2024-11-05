import {
    Button,
    CircularProgress,
    Dialog,
    DialogActions,
    DialogContent,
    DialogTitle,
    Paper,
    TextField,
} from '@mui/material';
import Table from '@mui/material/Table';
import TableBody from '@mui/material/TableBody';
import TableCell from '@mui/material/TableCell';
import TableContainer from '@mui/material/TableContainer';
import TableHead from '@mui/material/TableHead';
import TableRow from '@mui/material/TableRow';
import { useEffect, useState } from 'react';
import ExceptionPage from '../../Exception/ExceptionPage';
import { assert_test } from '../../../utility/common';
import React from 'react';
import BottomSnackbar from '../../Snackbar/BottomSnackbar';
import ConfirmDialog from '../../Dialog/ConfirmDialog';
import Account from '../../../model/Account';

const ManageAccount = () => {
    const [accounts, setAccounts] = useState<Array<Account>>([]);
    const [error, setError] = useState<string | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [openChange, setOpenChange] = useState<boolean>(false);
    const [index, setIndex] = useState<number>(-1);
    const [openSnackbar, setOpenSnackBar] = useState<boolean>(false);
    const [message, setMessage] = useState<string>('');
    const [openDeleteDialog, setDeleteDialog] = useState(false);
    useEffect(() => {
        const url = 'http://dangvankhanhblog.io.vn:7138/api/CustomerAccount/getAllAccount';
        const fetchAccounts = async () => {
            const response = await fetch(url, { method: 'GET' });
            assert_test(response.ok, 'Có lỗi xảy ra trong quá trình lấy tài khoản');
            setAccounts((await response.json()) as Array<Account>);
        };
        fetchAccounts()
            .catch((e) => setError((e as Error).message))
            .finally(() => setIsLoading(false));
    }, []);

    const handleCategoryChange = async () => {
        const url =
            index === -1
                ? 'http://dangvankhanhblog.io.vn:7138/api/CustomerAccount'
                : `http://dangvankhanhblog.io.vn:7138/api/CustomerAccount?id=${accounts[index].customerId}`;
        const method = index === -1 ? 'POST' : 'PUT';
        const response = await fetch(url, {
            method: method,
            headers: { 'Content-Type': 'application/json' },
        });
        assert_test(response.ok, 'Có lỗi xảy ra trong quá trình xử lý tài khoản');

        const updatedAccount = await response.json();

        if (index === -1) {
            setAccounts([...accounts, updatedAccount]);
            setMessage('Thêm tài khoản thành công');
        } else {
            setAccounts(accounts.map((e, idx) => (idx === index ? updatedAccount : e)));
            setMessage('Sửa tài khoản thành công');
        }
        setOpenSnackBar(true);
        setOpenChange(false);
    };

    const handleDeleteCategory = async () => {
        assert_test(index !== -1, 'Không thể xoá tài khoản chưa chọn');
        const url = `http://dangvankhanhblog.io.vn:7138/api/employee/CategoryControler?id=${accounts[index].customerId}`;
        const response = await fetch(url, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' },
        });
        assert_test(response.ok, 'Có lỗi xảy ra trong quá trình xoá tài khoản');
        assert_test(await response.json(), 'Không thể xoá tài khoản vui lòng thử lại');
        setAccounts(accounts.filter((_, i) => i !== index));
        setMessage('Xoá tài khoản thành công');
        setOpenSnackBar(true);
        setOpenChange(false);
    };

    const handleOpenDialog = (idx: number) => {
        setIndex(idx);
        setOpenChange(true);
    };

    if (isLoading) {
        return <CircularProgress color='info' />;
    }
    if (error !== null) {
        return <ExceptionPage message={error} />;
    }

    return (
        <React.Fragment>
            <div style={{ margin: '5px 10px' }}>
                <Button onClick={() => handleOpenDialog(-1)}>Thêm tài khoản</Button>
                <BottomSnackbar
                    message={message}
                    openSnackbar={openSnackbar}
                    setOpenSnackBar={setOpenSnackBar}
                />
                <ConfirmDialog
                    open={openDeleteDialog}
                    handleClose={() => setDeleteDialog(false)}
                    title='Bạn có chắc chắn muốn xoá tài khoản?'
                    content='tài khoản sau khi xoá sẽ không thể khôi phục'
                    handleConfirmation={() => handleDeleteCategory()}
                />
                <Dialog
                    open={openChange}
                    onClose={() => setOpenChange(false)}
                    PaperProps={{
                        component: 'form',
                        onSubmit: (event: React.FormEvent<HTMLFormElement>) => {
                            event.preventDefault();
                            handleCategoryChange();
                        },
                    }}
                >
                    <DialogTitle>
                        {index === -1 ? 'Thêm tài khoản' : 'Cập nhật tài khoản'}
                    </DialogTitle>
                    <DialogContent>
                        <TextField
                            autoFocus
                            required
                            margin='dense'
                            id='email'
                            name='email'
                            label='Tên tài khoản'
                            type='email'
                            value={index !== -1 ? accounts[index].email : ''}
                            fullWidth
                            variant='standard'
                        />
                        <TextField
                            required
                            margin='dense'
                            id='password'
                            name='password'
                            label='Mật khẩu'
                            type='password'
                            fullWidth
                            variant='standard'
                        />
                    </DialogContent>
                    <DialogActions>
                        <Button onClick={() => setOpenChange(false)}>Huỷ</Button>
                        <Button type='submit'>Lưu</Button>
                    </DialogActions>
                </Dialog>
                <TableContainer component={Paper}>
                    <Table sx={{ minWidth: 650 }} aria-label='simple table'>
                        <TableHead>
                            <TableRow>
                                <TableCell align='center'>Số thứ tự</TableCell>
                                <TableCell align='center'>Mã khách hàng</TableCell>
                                <TableCell align='center'>Tên tài khoản</TableCell>
                                <TableCell align='center'>Email</TableCell>
                                <TableCell align='center'>Hành động</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {accounts.map((e, idx) => (
                                <TableRow
                                    key={e.accCustomerId}
                                    sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                                >
                                    <TableCell align='center'>{idx + 1}</TableCell>
                                    <TableCell align='center'>{e.accCustomerId}</TableCell>
                                    <TableCell align='center'>{e.customerId}</TableCell>
                                    <TableCell align='center'>{e.email}</TableCell>
                                    <TableCell align='center'>
                                        <Button
                                            variant='outlined'
                                            color='info'
                                            sx={{ mr: 2 }}
                                            onClick={() => handleOpenDialog(idx)}
                                        >
                                            Sửa
                                        </Button>
                                        <Button
                                            variant='outlined'
                                            color='error'
                                            onClick={() => {
                                                setIndex(idx);
                                                setDeleteDialog(true);
                                            }}
                                        >
                                            Xoá
                                        </Button>
                                    </TableCell>
                                </TableRow>
                            ))}
                        </TableBody>
                    </Table>
                </TableContainer>
            </div>
        </React.Fragment>
    );
};

export default ManageAccount;
