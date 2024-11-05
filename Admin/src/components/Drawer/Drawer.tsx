import * as React from 'react';
import Box from '@mui/material/Box';
import Drawer from '@mui/material/Drawer';
import List from '@mui/material/List';
import Divider from '@mui/material/Divider';
import ListItem from '@mui/material/ListItem';
import ListItemButton from '@mui/material/ListItemButton';
import ListItemIcon from '@mui/material/ListItemIcon';
import ListItemText from '@mui/material/ListItemText';
import DashboardIcon from '@mui/icons-material/Dashboard';
import HomeIcon from '@mui/icons-material/Home';
import ManageIcon from '@mui/icons-material/DragIndicator';
import { useNavigate } from 'react-router-dom';

interface Stage {
    name: string;
    entry: string;
}

const LeftDrawer: React.FC<{ open: boolean; toggleDrawer: (newOpen: boolean) => void }> = ({
    open,
    toggleDrawer,
}) => {
    const navigate = useNavigate();
    const firstList: Array<Stage> = [
        {
            name: 'Trang chủ',
            entry: '/home',
        },
        {
            name: 'Thống kê',
            entry: '/dashboard',
        },
    ];
    const secondList: Array<Stage> = [
        {
            name: 'Quản lý sản phẩm',
            entry: '/admin/product',
        },
        {
            name: 'Quản lý khuyến mãi',
            entry: '/admin/sale',
        },
        {
            name: 'Quản lý tài khoản',
            entry: '/admin/account',
        },
        {
            name: 'Quản lý cửa hàng',
            entry: '/admin/store',
        },
        {
            name: 'Quản lý đơn hàng',
            entry: '/admin/order',
        },
        {
            name: 'Quản lý danh mục',
            entry: '/admin/category',
        },
    ];
    const DrawerList = (
        <Box sx={{ width: 250 }} role='presentation' onClick={() => toggleDrawer(false)}>
            <List>
                {firstList.map((e, index) => (
                    <ListItem key={e.name} disablePadding>
                        <ListItemButton onClick={() => navigate(e.entry)}>
                            <ListItemIcon>
                                {index % 2 === 1 ? <DashboardIcon /> : <HomeIcon />}
                            </ListItemIcon>
                            <ListItemText primary={e.name} />
                        </ListItemButton>
                    </ListItem>
                ))}
            </List>
            <Divider />
            <List>
                {secondList.map((e) => (
                    <ListItem key={e.name} disablePadding>
                        <ListItemButton onClick={() => navigate(e.entry)}>
                            <ListItemIcon>
                                <ManageIcon />
                            </ListItemIcon>
                            <ListItemText primary={e.name} />
                        </ListItemButton>
                    </ListItem>
                ))}
            </List>
        </Box>
    );

    return (
        <div>
            <Drawer open={open} onClose={() => toggleDrawer(false)}>
                {DrawerList}
            </Drawer>
        </div>
    );
};
export default LeftDrawer;
