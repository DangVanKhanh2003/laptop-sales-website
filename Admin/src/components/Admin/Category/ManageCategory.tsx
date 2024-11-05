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
import Category from '../../../model/Category';
import ExceptionPage from '../../Exception/ExceptionPage';
import { assert_test } from '../../../utility/common';
import React from 'react';
import BottomSnackbar from '../../Snackbar/BottomSnackbar';
import ConfirmDialog from '../../Dialog/ConfirmDialog';

const ManageCategory = () => {
    const [categories, setCategories] = useState<Array<Category>>([]);
    const [error, setError] = useState<string | null>(null);
    const [isLoading, setIsLoading] = useState<boolean>(true);
    const [openChange, setOpenChange] = useState<boolean>(false);
    const [index, setIndex] = useState<number>(-1);
    const [openSnackbar, setOpenSnackBar] = useState<boolean>(false);
    const [message, setMessage] = useState<string>('');
    const [categoryData, setCategoryData] = useState({ categoryName: '', categoryIcon: '' });
    const [openDeleteDialog, setDeleteDialog] = useState(false);
    useEffect(() => {
        const url =
            'http://dangvankhanhblog.io.vn:7138/api/employee/CategoryControler/getAllCategory';
        const fetchCategories = async () => {
            const response = await fetch(url, { method: 'GET' });
            assert_test(response.ok, 'Có lỗi xảy ra trong quá trình lấy danh mục');
            setCategories((await response.json()) as Array<Category>);
        };
        fetchCategories()
            .catch((e) => setError((e as Error).message))
            .finally(() => setIsLoading(false));
    }, []);

    const handleCategoryChange = async () => {
        const url =
            index === -1
                ? 'http://dangvankhanhblog.io.vn:7138/api/employee/CategoryControler'
                : `http://dangvankhanhblog.io.vn:7138/api/employee/CategoryControler?id=${categories[index].categoryId}`;

        const method = index === -1 ? 'POST' : 'PUT';
        const response = await fetch(url, {
            method: method,
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(categoryData),
        });
        assert_test(response.ok, 'Có lỗi xảy ra trong quá trình xử lý danh mục');

        const updatedCategory = await response.json();

        if (index === -1) {
            setCategories([...categories, updatedCategory]);
            setMessage('Thêm danh mục thành công');
        } else {
            setCategories(categories.map((cat, idx) => (idx === index ? updatedCategory : cat)));
            setMessage('Sửa danh mục thành công');
        }
        setOpenSnackBar(true);
        setOpenChange(false);
        setCategoryData({ categoryName: '', categoryIcon: '' });
    };

    const handleOpenDialog = (idx: number) => {
        setIndex(idx);
        setCategoryData(idx !== -1 ? categories[idx] : { categoryName: '', categoryIcon: '' });
        setOpenChange(true);
    };

    const handleDeleteCategory = async () => {
        assert_test(index !== -1, 'Không thể xoá danh mục chưa chọn');
        const url = `http://dangvankhanhblog.io.vn:7138/api/employee/CategoryControler?id=${categories[index].categoryId}`;
        const response = await fetch(url, {
            method: 'DELETE',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify(categoryData),
        });
        assert_test(response.ok, 'Có lỗi xảy ra trong quá trình xoá danh mục');
        assert_test(await response.json(), 'Không thể xoá danh mục vui lòng thử lại');
        setCategories(categories.filter((_, i) => i !== index));
        setMessage('Xoá danh mục thành công');
        setOpenSnackBar(true);
        setOpenChange(false);
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
                <Button onClick={() => handleOpenDialog(-1)}>Thêm danh mục</Button>
                <BottomSnackbar
                    message={message}
                    openSnackbar={openSnackbar}
                    setOpenSnackBar={setOpenSnackBar}
                />
                <ConfirmDialog
                    open={openDeleteDialog}
                    handleClose={() => setDeleteDialog(false)}
                    title='Bạn có chắc chắn muốn xoá danh mục?'
                    content='Danh mục sau khi xoá sẽ không thể khôi phục'
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
                        {index === -1 ? 'Thêm danh mục' : 'Cập nhật danh mục'}
                    </DialogTitle>
                    <DialogContent>
                        <TextField
                            autoFocus
                            required
                            margin='dense'
                            id='categoryName'
                            name='categoryName'
                            label='Tên danh mục'
                            value={categoryData.categoryName}
                            onChange={(e) =>
                                setCategoryData({ ...categoryData, categoryName: e.target.value })
                            }
                            fullWidth
                            variant='standard'
                        />
                        <TextField
                            required
                            margin='dense'
                            id='categoryIcon'
                            name='categoryIcon'
                            label='Icon danh mục'
                            value={categoryData.categoryIcon}
                            onChange={(e) =>
                                setCategoryData({ ...categoryData, categoryIcon: e.target.value })
                            }
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
                                <TableCell align='center'>Mã danh mục</TableCell>
                                <TableCell align='center'>Tên danh mục</TableCell>
                                <TableCell align='center'>Icon</TableCell>
                                <TableCell align='center'>Hành động</TableCell>
                            </TableRow>
                        </TableHead>
                        <TableBody>
                            {categories.map((e, idx) => (
                                <TableRow
                                    key={e.categoryId}
                                    sx={{ '&:last-child td, &:last-child th': { border: 0 } }}
                                >
                                    <TableCell align='center'>{idx + 1}</TableCell>
                                    <TableCell align='center'>{e.categoryId}</TableCell>
                                    <TableCell align='center'>{e.categoryName}</TableCell>
                                    <TableCell align='center'>{e.categoryIcon}</TableCell>
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

export default ManageCategory;
